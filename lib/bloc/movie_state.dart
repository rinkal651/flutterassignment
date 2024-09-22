import 'package:equatable/equatable.dart';
import '../model/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class InitialState extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {

  const MovieError();

  @override
  List<Object> get props => [];
}

class DbOpSucceed extends MovieState {}

class DbMoviesLoaded extends MovieState {
  final List<Movie> movies;
  const DbMoviesLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class ApiMovieLoaded extends MovieState {
  final List<Movie> movies;

  const ApiMovieLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}