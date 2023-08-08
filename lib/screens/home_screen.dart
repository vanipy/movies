import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../widgets/movie_list_item.dart';
import 'movie_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Movie.movies;
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 150.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge,
              children: [
                TextSpan(
                  text: 'Featured',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: 'Movies'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          for (final movie in movies)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieScreen(movie: movie),
                  ),
                );
              },
              child: MovieListItem(
                imageUrl: movie.imagePath,
                name: movie.name,
                information:
                    '${movie.year}| ${movie.category}|${movie.duration.inHours}h ${movie.duration.inMinutes.remainder(60)}m',
              ),
            ),
        ]),
      )),
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
