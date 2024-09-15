import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mamposteriapdf extends StatefulWidget {
  final int totalScore;

  const Mamposteriapdf({Key? key, required this.totalScore}) : super(key: key);

  @override
  State<Mamposteriapdf> createState() => _MamposteriapdfState();
}

class _MamposteriapdfState extends State<Mamposteriapdf> {
  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    String calculateVulnerability() {
      if (widget.totalScore <= 4) return 'Baja';
      if (widget.totalScore <= 8) return 'Media';
      return 'Alta';
    }

    String vulnerability = calculateVulnerability();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text('Informe de Vulnerabilidad de Mampostería',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Datos del Usuario:'),
              pw.Text('Nombre: ${userData['nombreCompleto']}'),
              pw.Text(
                  'Dirección: ${userData['calle']} #${userData['numero']}, ${userData['colonia']}'),
              pw.Text(
                  'Municipio: ${userData['municipio']}, ${userData['estado']}'),
              pw.Text('CP: ${userData['cp']}'),
              pw.Text('Niveles de la vivienda: ${userData['niveles']}'),
              pw.Text('Email: ${userData['email']}'),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Basado en los resultados de su cuestionario, hemos determinado que la vulnerabilidad de la mampostería de su vivienda es:'),
              pw.SizedBox(height: 10),
              pw.Text(
                vulnerability,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: vulnerability == 'Alta'
                      ? PdfColors.red
                      : (vulnerability == 'Media'
                          ? PdfColors.orange
                          : PdfColors.green),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Detalles del análisis:'),
              pw.SizedBox(height: 10),
              pw.Text('Puntuación total: ${widget.totalScore}'),
              pw.SizedBox(height: 20),
              pw.Text(
                'Recomendaciones:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text(vulnerability == 'Alta'
                  ? '- Se recomienda una evaluación estructural inmediata por un profesional.'
                  : (vulnerability == 'Media'
                      ? '- Considere mejorar el mantenimiento y realizar inspecciones regulares.'
                      : '- Mantenga las buenas prácticas de conservación actuales.')),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe de Vulnerabilidad'),
      ),
      body: PdfPreview(
          build: (format) => generatePdf(format), canChangePageFormat: false),
    );
  }
}
