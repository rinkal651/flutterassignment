import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum MovieType {
  NOW_PLAYING, POPULAR, TOP_RATED;

  String getUrl() {
    String url = "3/movie/";
    switch(this) {
      case MovieType.NOW_PLAYING:
        return url+"now_playing";
      case MovieType.POPULAR:
        return url+"popular";
      case MovieType.TOP_RATED:
        return url+"top_rated";
    }
    return "";
  }
}

class ApiRequest {
  static String gener = "3/genre/movie/list";

   final client = http.Client();
   final String APIKey = "0e7274f05c36db12cbe71d9ab0393d47";
   final String baseUrl = "api.themoviedb.org";
   static final String imagePrefix =  "https://image.tmdb.org/t/p/original/";


   Future apiCall(String url, {required Map<String, dynamic> params}) async {
     Map<String, dynamic> resp = {};
     try {
       params.addAll({"api_key": APIKey});
       var uri = Uri.https(baseUrl, url, params);
       var response = await client.get(uri);
       if(kDebugMode) print("apiCall => $url => ${response.statusCode} response.body <= ${response.body}");
       return json.decode(response.body);
     } catch(e) {
        if(kDebugMode) print(e);
     }
     return resp;
   }
}