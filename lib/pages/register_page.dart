import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:movie_search_app/components/input_text_field.dart";
import "package:movie_search_app/components/my_button.dart";
import "package:movie_search_app/services/auth_service.dart";

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text controllers.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up function
  void signUpUser() async {
    //show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //sign up the usr
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        errorMessage("passwords do n't match!");
      }
      //pop the loading context
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      errorMessage(e.code);
    }
  }

  void errorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Center(
              child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.movie_creation,
                size: 100,
                color: Colors.grey[800],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Welcome to Movie_Search',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 25,
              ),
              //email
              InputTextField(
                controller: emailController,
                placeHolder: "Enter your email",
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              //password
              InputTextField(
                controller: passwordController,
                placeHolder: "Enter your password",
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              //confirm password
              InputTextField(
                controller: confirmPasswordController,
                placeHolder: "Enter your password",
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              //button
              MyButton(
                onTap: signUpUser,
                backgroundColor: Colors.black,
                text: "Sign Up",
                textColor: Colors.white,
              ),

              const SizedBox(
                height: 50,
              ),

              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //google sign up button
              MyButton(
                onTap: () => AuthService().signInWithGoogle(),
                backgroundColor: Colors.grey.shade200,
                text: "Sign up with google",
                textColor: Colors.black,
                imagePath: 'lib/images/google.png',
              ),
              const SizedBox(
                height: 25,
              ),
              //not a member? Register now
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already a member?",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      )),
    );
  }
}
