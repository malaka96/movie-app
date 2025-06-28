import 'package:flutter/material.dart';
import 'package:movie_app/data/api_service.dart';
import 'package:movie_app/widgets/movie_image_text_row.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Map<String, dynamic>>> favoriteMoviesFuture;

  @override
  void initState() {
    super.initState();
    favoriteMoviesFuture = loadFavoriteMovies();
  }

  Future<List<Map<String, dynamic>>> loadFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_movies') ?? [];
    List<Map<String, dynamic>> movies = [];
    for (final id in favoriteIds) {
      try {
        final movie = await ApiService().fetchMovieDetails(id);
        movies.add(movie);
      } catch (_) {
        // Ignore errors for missing movies
      }
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: favoriteMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading movies"));
        } else {
          final favoriteMovies = snapshot.data ?? [];
          if (favoriteMovies.isEmpty) {
            return const Center(child: Text("No favorite movies found"));
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Favorite Movies', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: favoriteMovies.map((movie) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: MovieImageTextRow(
                              imageUrl: movie['poster'].toString(),
                              title: movie['title'].toString(),
                              id: movie['id'].toString(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
