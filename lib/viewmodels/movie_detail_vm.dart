//used provider to learn how to write and how does it works. 

import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/api.dart';

class MovieDetailViewModel extends ChangeNotifier {
  Movie? movie;
  bool isLoading = false;
  String? error;

  Future<void> load(String imdbID) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      movie = await ApiService.fetchMovieDetail(imdbID);
    } catch (e) {
      error = "Hata: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
