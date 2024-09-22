import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutterassignment/model/genre.dart';

import '../utils/api_request.dart';

class GenreRepository {
  Future<Map<int, String>> fetchGenre() async {

    try {
      final Map<String, dynamic> response = await ApiRequest().apiCall(ApiRequest.gener, params: {});

      if(kDebugMode)print("response $response");

      if (response != null) {
        List<Genre> genreList = List<Genre>.from(response['genres'].map((genre) => Genre.fromJson(genre)));
        Map<int, String> genreMap = {for (var genre in genreList) genre.id: genre.name};
        return genreMap;
      }
    } catch (e, stack) {
      if(kDebugMode) {
        print(e);
        print(stack);
      }
    }
    return {};
  }
}