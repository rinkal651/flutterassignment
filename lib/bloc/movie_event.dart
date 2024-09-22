import 'package:equatable/equatable.dart';
import 'package:flutterassignment/model/movie.dart';
import 'package:flutterassignment/utils/api_request.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;
  final MovieType category;

  const FetchMovies(this.page, this.category);

  @override
  List<Object> get props => [page, category];
}

class GetSavedMovie extends MovieEvent {

  const GetSavedMovie();
}

class RemoveSavedMovie extends MovieEvent {
  final int movieId;
  const RemoveSavedMovie(this.movieId);
  @override
  List<Object> get props => [movieId];
}

class SaveMovie extends MovieEvent {
  final Movie movie;
  const SaveMovie(this.movie);
  @override
  List<Object> get props => [movie];
}
