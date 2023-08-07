import 'package:flutter/material.dart';
import 'package:movies/screens/sign_up_screen.dart';

import 'log_in_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget{
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState()=> _LoginOrRegisterScreenState();

}

class _LoginOrRegisterScreenState extends State <LoginOrRegisterScreen>{
  
  bool showLoginScreen = true;

  void togglePage()
  {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }
  
  
  
  @override
  Widget build(BuildContext context)
  {
    if(showLoginScreen)
    {
      return LoginScreen
      (
        onTap: togglePage,
      );
    }
    else{
      return SignUpScreen(
        onTap: togglePage,
      );
    }

  }
}