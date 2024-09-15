import 'package:argamasa_mamposteria/componentes/texfieldNum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Content/home.dart';
import '../componentes/boton.dart';
import '../componentes/textfield.dart';
import 'inicio_sesion.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasController = TextEditingController();
  final emailController = TextEditingController();
  final nivelesController = TextEditingController();
  final cpController = TextEditingController();
  final calleController = TextEditingController();
  final numeroController = TextEditingController();
  final coloniaController = TextEditingController();
  final estadoController = TextEditingController();
  final municipioController = TextEditingController();

  void updateUserName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(newName);
        user = FirebaseAuth.instance.currentUser; // Refresh the user object
        print("User display name updated: ${user?.displayName}");
      } catch (e) {
        print("Error updating user display name: $e");
      }
    }
  }

  //register user in method event
  void registerUserIn(BuildContext context) async {
    try {
      // Validar que las contraseñas coincidan
      if (passwordController.text != confirmPasController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Las contraseñas no coinciden"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Mostrar indicador de carga
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Registrar el usuario
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'nombreCompleto': usernameController.text,
        'niveles': nivelesController.text,
        'cp': cpController.text,
        'calle': calleController.text,
        'numero': numeroController.text,
        'colonia': coloniaController.text,
        'estado': estadoController.text,
        'municipio': municipioController.text,
        'email': emailController.text,
      });

      // Actualizar el nombre de usuario
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await user.updateDisplayName(usernameController.text);
          user =
              FirebaseAuth.instance.currentUser; // Refrescar el objeto usuario
          print("Nombre de usuario actualizado: ${user?.displayName}");
        } catch (e) {
          print("Error al actualizar el nombre de usuario: $e");
        }
      }

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario registrado exitosamente"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Cerrar el diálogo de carga en caso de error
      Navigator.of(context).pop();

      print("Error al registrar el usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar el usuario: $e"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(maxWidth: 700),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.to(LoginPage());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 1, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Vulnerabilidad de viviendas',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aboreto(fontSize: 38),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    //(Welcome!) text
                    Text('Ingresa tus datos',
                        style: GoogleFonts.heebo(fontSize: 20)),

                    const SizedBox(
                      height: 15,
                    ), // this makes a type of space betweeno your objects

                    //username textfield
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Nombre Completo',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    TextFieldNum(
                      controller: nivelesController,
                      hintText: 'Niveles de la vivienda',
                      obscureText: false,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Solo permite dígitos
                      ],
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    TextFieldNum(
                      controller: cpController,
                      hintText: 'CP',
                      obscureText: false,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Solo permite dígitos
                      ],
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: MyTextField(
                            controller: calleController,
                            hintText: 'Calle',
                            obscureText: false,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFieldNum(
                            controller: numeroController,
                            hintText: 'Número',
                            obscureText: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: coloniaController,
                      hintText: 'Colonia',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: municipioController,
                      hintText: 'Municipio',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: estadoController,
                      hintText: 'Estado',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: passwordController,
                      hintText: 'Contraseña',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    MyTextField(
                      controller: confirmPasController,
                      hintText: 'Confirmación de contraseña',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //log in button
                    MyButton(
                      text: 'Registrarse',
                      onTap: () {
                        registerUserIn(context);
                        Get.to(LoginPage());
                      },
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //already have an account? Log in now
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              '¿Ya tienes una cuenta?',
                              style: TextStyle(
                                  color: Color.fromARGB(183, 66, 66, 66)),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //Register now text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 180.0),
                      child: Expanded(
                        child: Divider(
                          thickness: 0.4,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        // Navigate to the logIn page
                        Get.to(LoginPage());
                      },
                      //GestureD is for making everythin that its inside a button
                      child: Text(
                        "Ingresar",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 15,
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 160, 55, 29)),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 180.0),
                      child: Expanded(
                        child: Divider(
                          thickness: 0.4,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
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
