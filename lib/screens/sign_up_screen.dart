import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/widgets/my_button.dart';
import 'package:movies/widgets/square_tile.dart';
import 'package:movies/widgets/userfields.dart';

import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onTap;
  const SignUpScreen({super.key, required this.onTap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try creating new user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //show message that passwords do not match
        Navigator.pop(context);
        showErrorMsg("Passwords don't match");
        //Navigator.pop(context);
      }

      // pop loading circle
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMsg(e.code);
    }
  }

  //error message to user
  void showErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF000B49),
              child: Center(
                child: Text('Welcome',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                const Icon(
                  Icons.movie_filter,
                  size: 50,
                ),

                const Text(
                  'Lets get started!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 25,
                ),
                UserFields(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10), //email textfield

                UserFields(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ), //password textfield

                const SizedBox(height: 10), //email textfield

                UserFields(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ), //confirm password textfield

                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Or continue with',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                //adding google and apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'assets/images/google.png'),

                    const SizedBox(
                      width: 10,
                    ),

                    //apple button
                    SquareTile(
                        onTap: () {}, imagePath: 'assets/images/apple.png'),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                //not a member? Sign up now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log In Now',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
