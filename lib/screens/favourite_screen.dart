import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import 'movie_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(GetSavedMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liked Movies", style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.redAccent,),

      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is InitialState ||
              (state is MovieLoading && state is! DbMoviesLoaded)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DbMoviesLoaded) {
            if(state.movies.isEmpty) {
              return Center(child: Text("Not liked any movie!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),));// Scroll to position 0 (the start
            }
            return Padding(
              padding: EdgeInsets.all(2),
              child: ListView.builder(
                itemCount:  state.movies.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                    return MovieCard(movie: state.movies[index],isFavouriteScreen: true);
                },
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text("Something went wrong!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),));// Scroll to position 0 (the start
          } else if(state is DbOpSucceed) {
            BlocProvider.of<MovieBloc>(context).add(GetSavedMovie());
          }
          return Container();
        },
      ),
    );
  }
}
