import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  final String message;
  final String user;
  //final String time;
  const Reviews({
    super.key,
    required this.message,
    required this.user,
    //required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 230, 230),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(message),
            ],
          )
        ],
      ),
    );
  }
}
