import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/widgets/my_button.dart';
import 'package:movies/widgets/square_tile.dart';
import 'package:movies/widgets/userfields.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
          Navigator.pop(context); // pop loading circle
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMsg();
      } else if (e.code == 'wrong-passowrd') {
        wrongPasswordMsg();
      }
    }
    
  }

  void wrongEmailMsg() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  void wrongPasswordMsg() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              const Icon(
                Icons.movie_filter,
                size: 50,
              ),

              const Text(
                'Welcome!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 25,
              ),
              UserFields(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ), //email textfield
              UserFields(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ), //password textfield

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.425, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        debugPrint('Forgot Password');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),
              MyButton(
                onTap: signUserIn,
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'assets/images/google.png'),

                  SizedBox(
                    width: 10,
                  ),

                  //apple button
                  SquareTile(imagePath: 'assets/images/apple.png'),
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
                    'Not a member? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.425, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      debugPrint('Sign Up Button');
                    },
                    child: const Text(
                      'Sign up now',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )

              // Center(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.all(15.0),
              //       primary: const Color(0xFF000B49),
              //       fixedSize: Size(MediaQuery.of(context).size.width * 0.425, 50),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //     ),
              //     onPressed: () {
              //       debugPrint('Log In Button');

              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const HomeScreen()));
              //     },
              //     child: const Text('Log In'),
              //   ),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.all(15.0),
              //     primary: const Color(0xFF000B49),
              //     fixedSize: Size(MediaQuery.of(context).size.width * 0.425, 50),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0),
              //     ),
              //   ),
              //   onPressed: () {
              //     debugPrint('Sign Up Button');
              //   },
              //   child: const Text('Sign Up '),
              // ),
            ],
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
