import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterassignment/repositories/genre_repository.dart';
import 'package:flutterassignment/screens/favourite_screen.dart';
import 'package:flutterassignment/screens/movie_list.dart';
import 'package:flutterassignment/utils/api_request.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';


class MovieListScreen extends StatefulWidget {

  static Map<int, String> genre = {};

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> with SingleTickerProviderStateMixin {
  int currentPage = 1;
  int currentTab = 1;

  @override
  void initState() {
    super.initState();
    getGenre();
  }

  getGenre() async {
    MovieListScreen.genre = await GenreRepository().fetchGenre();
    BlocProvider.of<MovieBloc>(context).add(FetchMovies(currentPage, MovieType.NOW_PLAYING));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Movies', style: TextStyle(color: Colors.black54),),
          actions:[IconButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavouriteScreen()));
              onTabNavigate(currentTab);
            },
            icon: Icon(CupertinoIcons.heart_fill),
            tooltip: "Favourite Movies",
          )],
          bottom: TabBar(
              labelColor: Colors.black54,
            tabs: [
              Tab(text: 'Now Playing'),
              Tab(text: 'Popular'),
              Tab(text: 'Top Rated'),
            ],
            onTap: (index) {
              currentTab = index;
              onTabNavigate(index);
            },
          ),
        ),
        body: TabBarView(
      children: [
      // Content for each tab
      Center(child: MovieList(movieType: MovieType.NOW_PLAYING,)),
      Center(child: MovieList(movieType: MovieType.POPULAR,)),
      Center(child: MovieList(movieType: MovieType.TOP_RATED,)),
      ],
      ),
      ),
    );
  }

  onTabNavigate(int index) {
    switch (index) {
      case 0:
        BlocProvider.of<MovieBloc>(context).add(
            FetchMovies(1, MovieType.NOW_PLAYING));
        break;
      case 1:
        BlocProvider.of<MovieBloc>(context).add(
            FetchMovies(1, MovieType.POPULAR));
        break;
      case 2:
        BlocProvider.of<MovieBloc>(context).add(
            FetchMovies(1, MovieType.TOP_RATED));
        break;
    }
  }
}
