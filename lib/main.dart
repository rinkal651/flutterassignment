import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterassignment/repositories/movie_repository.dart';
import 'package:flutterassignment/screens/movie_list_screen.dart';

import 'bloc/movie_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => MovieRepository(),
        child: BlocProvider(
        create: (BuildContext context) => MovieBloc(movieRepository: context.read<MovieRepository>()),
    child: MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MovieListScreen(),
    )));
  }
}
