import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:my_app/models/movie_collection_model.dart';

class AddMovieController extends GetxController {
  static AddMovieController get instance => Get.find();
  final box = GetStorage();
  final favouritList = <MovieCollectionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavouriteMovies();
  }

  void toggleFavorite(MovieCollectionModel movie) {
    if (favouritList.contains(movie)) {
      favouritList.remove(movie);
    } else {
      favouritList.add(movie);
    }
    saveFavouriteMovies();
  }

  void saveFavouriteMovies() {
    List<Map<String, dynamic>> favList = favouritList.map((movie) => movie.toJson()).toList();
    box.write('favourites', favList);
  }

  void loadFavouriteMovies() {
    List<dynamic> favList = box.read<List<dynamic>>('favourites') ?? [];
    favouritList.assignAll(favList.map((e) => MovieCollectionModel.fromMap(e)).toList());
  }


  void addMovie(MovieCollectionModel movie) {
    favouritList.add(movie);
    saveFavouriteMovies();
  }
}
