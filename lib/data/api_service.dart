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
              "id": movie["id"].toString(),
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
              "id": movie["id"].toString(),
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
              "id": movie["id"].toString(),
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
              "id": movie["id"].toString(),
            },
          )
          .toList();
    } else {
      throw Exception("Failed to upcomming movies");
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(String id) async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&append_to_response=credits",
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final actors = (data['credits']['cast'] as List)
          .take(5)
          .map(
            (actor) => {
              "name": actor['name'].toString(),
              "character": actor['character'].toString(),
              "profilePic": actor['profile_path'] != null
                  ? "https://image.tmdb.org/t/p/w185${actor['profile_path']}"
                  : "", // fallback if no image
            },
          )
          .toList();

      final crew = data['credits']['crew'] as List;
      final director = crew.firstWhere(
        (person) => person['job'] == 'Director',
        orElse: () => {'name': 'Unknown'},
      )['name'];

      return {
        "poster": data["poster_path"] != null
            ? "https://image.tmdb.org/t/p/w500${data['poster_path']}"
            : "",
        "id": data["id"],
        "title": data["title"],
        "description": data["overview"],
        "rating": data["vote_average"],
        "genres": data["genres"]?.last["name"],
        "date": data["release_date"],
        "director": director,
        "language": data["spoken_languages"].first["name"],
        "actors": actors,
      };
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<List<Map<String, String>>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$query&api_key=$apiKey",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(),
              "description": movie["overview"].toString(),
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                  : "",
              "id": movie["id"].toString(),
            },
          )
          .toList();
    } else {
      throw Exception("Failed to search movies");
    }
  }
}
