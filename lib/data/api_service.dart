import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "9142bbfe1e62725733da91ca420f4a72";

  Future<List<Map<String, String>>> fetchNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(),
              "description": movie["overview"].toString(),
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                  : "",
            },
          )
          .toList();
    } else {
      throw Exception("Failed to load now playing movies");
    }
  }

  Future<List<Map<String, String>>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(),
              "description": movie["overview"].toString(),
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                  : "",
            },
          )
          .toList();
    } else {
      throw Exception("Failed to load trending movies");
    }
  }

  Future<List<Map<String, String>>> fetchTopRatedMovies() async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(),
              "description": movie["overview"].toString(),
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                  : "",
            },
          )
          .toList();
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  Future<List<Map<String, String>>> fetchUpCommingMovies() async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(),
              "description": movie["overview"].toString(),
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                  : "",
            },
          )
          .toList();
    } else {
      throw Exception("Failed to upcomming movies");
    }
  }
}
