import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/widgets/reviews.dart';
import 'package:movies/widgets/userfields.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  void postReview() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Reviews").add({
        'UserEmail': currentUser!.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }
    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustonClipper(),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Center(
              child: Text('Explore',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('log out button');
              // Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => LoginScreen()));
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Reviews")
                    .orderBy("TimeStamp", descending: false)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final review = snapshot.data!.docs[index];
                        return Reviews(
                          message: review['Message'],
                          user: review['UserEmail'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: UserFields(
                      controller: textController,
                      hintText: 'Write a review...',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postReview,
                    icon: const Icon(Icons.arrow_circle_up),
                  ),
                ],
              ),
            ),
            Text("Logged in as: ${currentUser!.email}"),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustonClipper extends CustomClipper<Path> {
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
