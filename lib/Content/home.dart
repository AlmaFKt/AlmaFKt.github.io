import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sesiones/inicio_sesion.dart';
import 'Cuestionarios/argamasa_cuestionario.dart';
import 'Cuestionarios/mamposteria_cuestionario.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Vulnerabilidad de Viviendas',
          style: GoogleFonts.aboreto(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Color.fromARGB(255, 125, 163, 206),
        /*actions: [
          IconButton(
            onPressed: () {
           async {
                try {
                  await Auth.signUserOut(context);
                  Get.to(() => LoginPage());
                } catch (e) {}
              },
            },
            icon: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 1, 0, 0),
            ),
          ),
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Información sobre la Vulnerabilidad de Viviendas',
                  style: GoogleFonts.aBeeZee(fontSize: 30),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Baja Vulnerabilidad:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Las viviendas con baja vulnerabilidad son aquellas que están bien construidas y tienen una alta resistencia a los desastres naturales.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Media Vulnerabilidad:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Las viviendas con media vulnerabilidad tienen una construcción moderada y pueden resistir algunos desastres naturales, pero pueden sufrir daños.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alta Vulnerabilidad:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Las viviendas con alta vulnerabilidad son aquellas que están mal construidas y tienen una baja resistencia a los desastres naturales.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(MamposteriaPage());
                    },
                    child: Text('Cuestionario de Mampostería'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(ArgamasaPage());
                    },
                    child: Text('Cuestionario de Argamasa'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
