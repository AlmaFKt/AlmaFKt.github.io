import 'package:argamasa_mamposteria/componentes/boton.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Información sobre la Vulnerabilidad de Viviendas',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Las viviendas con baja vulnerabilidad son aquellas que están bien construidas y tienen una alta resistencia a los desastres naturales.',
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Media Vulnerabilidad:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Las viviendas con media vulnerabilidad tienen algunas deficiencias en su construcción que las hacen susceptibles a daños moderados en caso de desastres naturales.',
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Alta Vulnerabilidad:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Las viviendas con alta vulnerabilidad son aquellas que están mal construidas y tienen una baja resistencia a los desastres naturales.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          MyButton(
                            text: 'Cuestionario mamposteria',
                            onTap: () {
                              Get.to(MamposteriaPage());
                            },
                          ),
                          MyButton(
                            text: 'Cuestionario argamasa',
                            onTap: () {
                              Get.to(ArgamasaPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
