import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutterassignment/utils/api_request.dart';

import '../model/movie.dart';

class MovieRepository {
  Future<List<Movie>> fetchMovies(int page, MovieType category) async {

    if(kDebugMode) print("fetchMovies $page ${category.getUrl()}");
    try {
      final Map<String, dynamic> response = await ApiRequest().apiCall(
          category.getUrl(), params: {"page": page.toString()});

      if(kDebugMode) print("response $response");
      if(response.isNotEmpty) {
        List<Movie> movieList = List<Movie>.from(response['results'].map((x) => Movie.fromJson(x)));
        return movieList;
      }
    } catch (e, stack) {
      if(kDebugMode){
        print(e);
        print(stack);
      }
    }
    return [];
  }
}
