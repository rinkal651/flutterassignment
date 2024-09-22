import 'package:intl/intl.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;

  // final bool adult;
  // final String backdropPath;
  // final String originalLanguage;
  // final String originalTitle;
  // final String overview;
  // final double popularity;
  // final bool video;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,

    // required this.adult,
    // required this.backdropPath,
    // required this.originalLanguage,
    // required this.originalTitle,
    // required this.overview,
    // required this.popularity,
    // required this.video,
  });

  // Factory constructor for parsing JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      posterPath: json['poster_path'],
      releaseDate: DateFormat('dd-MMM-yyyy').format(DateTime.parse(json['release_date'])),
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      genreIds: List<int>.from(json['genre_ids']),

      // adult: json['adult'],
      // backdropPath: json['backdrop_path'],
      // originalLanguage: json['original_language'],
      // originalTitle: json['original_title'],
      // overview: json['overview'],
      // popularity: json['popularity'].toDouble(),
      // video: json['video'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'genreIds': List<dynamic>.from(genreIds.map((x) => x)),

      // 'adult': adult,
      // 'backdrop_path': backdropPath,
      // 'original_language': originalLanguage,
      // 'original_title': originalTitle,
      // 'overview': overview,
      // 'popularity': popularity,
      // 'video': video,
    };
  }
}