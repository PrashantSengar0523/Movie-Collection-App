import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app/add_form.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Full-screen image
            CachedNetworkImage(
              imageUrl: 'https://i.postimg.cc/W46TCLY3/movie.jpg',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
            ),
            // Elevated button with elevation effect on all four sides
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 60,
                  width: 220,
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 'add_movie_button', // Unique tag for the hero animation
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent, // Background color
                        borderRadius: BorderRadius.circular(10), // Border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.6), // Shadow color
                            spreadRadius: 3, // Adjust spread radius
                            blurRadius: 10, // Adjust blur radius
                            offset: const Offset(0, 4), // Shadow offset
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent, // Button color
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Border radius
                          ),
                          elevation: 0, // Remove the default elevation
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeleteAndAddScreen(),
                            ),
                          );
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Add Movie to Your', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Collections', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
