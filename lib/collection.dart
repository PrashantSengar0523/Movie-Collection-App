import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/add_movie_controller.dart';

class Collection extends StatelessWidget {
  const Collection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMovieController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.favouritList.isEmpty) {
          return const Center(
            child: Text(
              'No movies in your collection yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.favouritList.length,
          itemBuilder: (context, index) {
            final movie = controller.favouritList[index];
            return Column(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: CachedNetworkImage(
                          imageUrl: movie.image,
                          height: 210,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Directed by ${movie.director}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(movie);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      }),
    );
  }
}
