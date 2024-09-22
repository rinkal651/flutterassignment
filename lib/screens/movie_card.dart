import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterassignment/bloc/movie_event.dart';
import 'package:flutterassignment/screens/movie_list_screen.dart';
import 'package:flutterassignment/utils/api_request.dart';

import '../bloc/movie_bloc.dart';
import '../model/movie.dart';
import '../utils/db_operation.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavouriteScreen;

  MovieCard({
    required this.movie,
    required this.isFavouriteScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 180), // Set maximum height for the row
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image with constrained height
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: SizedBox(
                  height: 180, // Set a fixed height
                  child: Image.network(
                   ApiRequest.imagePrefix + movie.posterPath,
                    width: 100,
                    fit: BoxFit.cover,
                      errorBuilder: (context, ex, st) {
                          return Center(child: Text("Internet not connected"));
                      }
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            // Movie Details
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Title
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    // Genres
                    Text(
                      movie.genreIds
                          .where((id) =>
                          MovieListScreen.genre.containsKey(id)) // Ensure the id exists in the genres map
                          .map((id) => MovieListScreen.genre[id]!)
                          .join(', '), // Get the genre name for the given id
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 5),
                    // Release Date
                    Text(
                      'Release Date: ${movie.releaseDate}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Vote Average and Vote Count
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18),
                        SizedBox(width: 2),
                        Text(
                          '${movie.voteAverage}/10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(${movie.voteCount} votes)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          child: isFavouriteScreen ? Icon(CupertinoIcons.heart_fill) : Icon(CupertinoIcons.heart),
                          onTap: () async {
                            if (isFavouriteScreen) {
                              BlocProvider.of<MovieBloc>(context)
                                  .add(RemoveSavedMovie(movie.id));
                            } else {
                              final id = await DbOperation().insertMovie(movie);
                              if (id != null) {
                                showToastMessage(
                                    context, "Movie is added to Favourites.");
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void showToastMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text(message),
        duration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
