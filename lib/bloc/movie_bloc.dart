
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterassignment/utils/db_operation.dart';
import '../repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(InitialState()) {

    on<FetchMovies>((event, emit) async {
        if(state is MovieLoading) return;
        if (state is InitialState) {
          emit(MovieLoading());
        }

        try {
          final movies = await movieRepository.fetchMovies(event.page, event.category);
          emit(ApiMovieLoaded(movies: movies));
        } catch (e, stack) {
          if(kDebugMode) {
            print(e);
            print(stack);
          }
          emit(MovieError());
        }
    });

    on<GetSavedMovie>((event, emit) async {
      if(state is MovieLoading) return;
      if (state is InitialState) {
        emit(MovieLoading());
      }

      try {
        final movies = await DbOperation().getMovies();
        emit(DbMoviesLoaded(movies: movies));
      } catch (e, stack) {
        if(kDebugMode) {
          print(e);
          print(stack);
        }
        emit(MovieError());
      }
    });

    on<RemoveSavedMovie>((event, emit) async {
      try {
        final affectedRowCount = await DbOperation().removeMovie(movieId: event.movieId);

        if(affectedRowCount != 0) {
          emit(DbOpSucceed());
        }
      } catch (e, stack) {
        if(kDebugMode) {
          print(e);
          print(stack);
        }
        emit(MovieError());
      }
    });

    on<SaveMovie>((event, emit) async {
      try {
        final id = await DbOperation().insertMovie(event.movie);
        emit(DbOpSucceed());
      } catch (e, stack) {
        if(kDebugMode) {
          print(e);
          print(stack);
        }
        emit(MovieError());
      }
    });
  }
}
