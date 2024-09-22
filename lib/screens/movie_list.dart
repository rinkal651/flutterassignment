import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../utils/api_request.dart';
import 'movie_card.dart';

class MovieList extends StatefulWidget {
  late MovieType movieType;
  MovieList({required this.movieType});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = ScrollController();

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(FetchMovies(currentPage, widget.movieType));
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is InitialState ||
            (state is MovieLoading && state is! ApiMovieLoaded) ) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ApiMovieLoaded) {

          if(currentPage != 1) {
            _scrollController.animateTo(
              0.0, duration: Duration(microseconds: 1),
              curve: Curves.easeInOut);
          } // Scroll to position 0 (the start

          if (state.movies.isEmpty) {
            return Center(child: Text("Something went wrong!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),));// Scroll to position 0 (the start
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:  state.movies.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                return _buildLoadingIndicator();
              } else {
                return MovieCard(movie: state.movies[index], isFavouriteScreen: false,);
              }
            },
          );
        } else if (state is MovieError) {
          return Center(child: Text("Something went wrong!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),));// Scroll to position 0 (the start
        }
        return Container();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if(kDebugMode)print("currentPage $currentPage");
      currentPage++;
      BlocProvider.of<MovieBloc>(context).add(FetchMovies(currentPage, widget.movieType));
    }
  }
}

