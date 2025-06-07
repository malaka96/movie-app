import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String apiKey = "9142bbfe1e62725733da91ca420f4a72";
  // static const String baseUrl =
  //     "https://api.themoviedb.org/3/movie/now_playing";

  Future<List<Map<String, String>>> fetchNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=9142bbfe1e62725733da91ca420f4a72",
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['results']
          .map<Map<String, String>>(
            (movie) => {
              "title": movie["title"].toString(), // ✅ Convert title to String
              "description": movie["overview"]
                  .toString(), // ✅ Ensure description is a String
              "poster": movie["poster_path"] != null
                  ? "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
                        .toString() // ✅ Convert poster URL safely
                  : "", // ✅ Handle null poster cases
            },
          )
          .toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
