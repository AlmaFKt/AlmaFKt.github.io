import 'package:argamasa_mamposteria/componentes/texfieldNum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componentes/boton.dart';
import '../componentes/textfield.dart';
import 'inicio_sesion.dart';

class RegisterPage extends StatelessWidget {
  //we copied the one from the login page, so we can do some changes
  RegisterPage({super.key});

  //Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasController = TextEditingController();
  final emailController = TextEditingController();
  final nivelesController = TextEditingController();
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
      // Validate password and confirm password
      if (passwordController.text != confirmPasController.text) {
        // Passwords don't match, show a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords don't match"),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
        return;
      }

      // Show loading indicator
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Use Firebase Authentication to create a new user account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // Update the user's display name
      if (userCredential.user != null) {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          try {
            await user.updateDisplayName(usernameController.text);
            user = FirebaseAuth.instance.currentUser; // Refresh the user object
            print("User display name updated: ${user?.displayName}");
          } catch (e) {
            print("Error updating user display name: $e");
          }
        }
      }

      // Close loading indicator
      Navigator.pop(context);

      // Registration successful, navigate to home page
      //Get.offAll(() => HomePage());
    } catch (error) {
      // Handle registration errors
      print("Registration failed: $error");

      // Close loading indicator
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed: $error"),
          duration: Duration(seconds: 4), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SafeArea(
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

                Text('Vulnerabilidad de viviendas',
                    style: GoogleFonts.aboreto(fontSize: 38)),

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
                  controller: emailController,
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
                      flex: 3, // 3/4 of the space
                      child: MyTextField(
                        controller: calleController,
                        hintText: 'Calle',
                        obscureText: false,
                      ),
                    ),
                    Expanded(
                      flex: 1, // 1/4 of the space
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
                  controller: estadoController,
                  hintText: 'Estado',
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          '¿Ya tienes una cuenta?',
                          style:
                              TextStyle(color: Color.fromARGB(183, 66, 66, 66)),
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
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 160, 55, 29)),
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
    );
  }
}
