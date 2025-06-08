import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_image_text_row.dart';
import '../widgets/movie_gallery.dart';
import '../data/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> movieData;

  @override
  void initState() {
    super.initState();
    movieData = Future.wait([
      ApiService().fetchNowPlayingMovies(),
      ApiService().fetchTrendingMovies(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading movies"));
          } else {
            final nowPlayingMovies =
                snapshot.data![0] as List<Map<String, String>>;
            final trendingMovies =
                snapshot.data![1] as List<Map<String, String>>;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: MovieGallery(movies: nowPlayingMovies),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: MovieImageTextRow(
                        imageUrl: nowPlayingMovies[0]["poster"]!,
                        title: nowPlayingMovies[0]["title"]!,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        "Trending Movies 🔥",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ...trendingMovies.map(
                      (movie) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MovieImageTextRow(
                          imageUrl: movie["poster"]!,
                          title: movie["title"]!,
                          //description: movie["description"]!,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
