import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        primary: const Color(0xFF000B49),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.425, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        debugPrint('Sign Up Button');
      },
      child: const Text('Sign Up '),
    );
  }
}
