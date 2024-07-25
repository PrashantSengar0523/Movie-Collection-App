import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // Import this for Uint8List
import 'package:get/get.dart';
import 'package:my_app/controllers/add_movie_controller.dart';
import 'package:my_app/models/movie_collection_model.dart';

class DeleteAndAddScreen extends StatelessWidget {
  DeleteAndAddScreen({super.key});

  final ValueNotifier<Uint8List?> _selectedImageBytes = ValueNotifier<Uint8List?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final controller =Get.put(AddMovieController());

  void _selectImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      _selectedImageBytes.value = result.files.single.bytes;
    } else {
      // User canceled the picker
    }
  }

  void _addMovie() {
    if (_selectedImageBytes.value != null &&
        nameController.text.isNotEmpty &&
        directorController.text.isNotEmpty) {
      final movie = MovieCollectionModel(
        image: 'data:image/png;base64,${base64Encode(_selectedImageBytes.value!)}',
        name: nameController.text.toString(),
        director: directorController.text.toString(),
      );
      controller.addMovie(movie);
      Get.back();
    } else {
      // Show error message
      Get.snackbar('Error', 'Please select an image and fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<Uint8List?>(
            valueListenable: _selectedImageBytes,
            builder: (context, selectedImageBytes, child) {
              return selectedImageBytes != null
                  ? Image.memory(
                      selectedImageBytes,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: '', // Default image URL
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _selectImage(context),
                  child: const SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white70,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Movie Name',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: directorController,
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Directed By',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Hero(
                    tag: 'add_movie_button',
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      onPressed: _addMovie,
                      child: const Text(
                        'Add',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
