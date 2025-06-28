import 'package:flutter/material.dart';
import 'package:movie_app/widgets/horizontal_widget_set_scroller.dart';
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
      ApiService().fetchTopRatedMovies(),
      ApiService().fetchUpCommingMovies(),
    ]);
  }

  Widget sectionTitle(String text) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: movieData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading movies"));
        } else {
          final nowPlayingMovies =
              snapshot.data![0] as List<Map<String, String>>;
          final trendingMovies = snapshot.data![1] as List<Map<String, String>>;
          final topRatedMovies = snapshot.data![2] as List<Map<String, String>>;
          final upCommingMovies =
              snapshot.data![3] as List<Map<String, String>>;

          final List<Widget> trandingMoviesWidgets = trendingMovies
              .map(
                (movie) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MovieImageTextRow(
                    imageUrl: movie["poster"]!,
                    title: movie["title"]!,
                    id: movie["id"]!,
                    //description: movie["description"]!,
                  ),
                ),
              )
              .toList();

          final List<Widget> topRatedMoviesWidgets = topRatedMovies
              .map(
                (movie) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MovieImageTextRow(
                    imageUrl: movie["poster"]!,
                    title: movie["title"]!,
                    id: movie["id"]!,
                    //description: movie["description"]!,
                  ),
                ),
              )
              .toList();

          final List<Widget> upCommingMoviesWidgets = upCommingMovies
              .map(
                (movie) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MovieImageTextRow(
                    imageUrl: movie["poster"]!,
                    title: movie["title"]!,
                    id: movie["id"]!,
                    //description: movie["description"]!,
                  ),
                ),
              )
              .toList();
          //print(trandingMoviesWidgets);
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Welcome to Movie App'),
                expandedHeight: MediaQuery.of(context).size.height,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: MovieGallery(movies: nowPlayingMovies),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  sectionTitle('Trending Movies'),
                  HorizontalWidgetSetScroller(widgets: trandingMoviesWidgets),
                  sectionTitle('Top Rated Movies'),
                  HorizontalWidgetSetScroller(widgets: topRatedMoviesWidgets),
                  sectionTitle('Up Comming Movies'),
                  HorizontalWidgetSetScroller(widgets: upCommingMoviesWidgets),
                ]),
              ),
            ],
          );
        }
      },
    );
  }
}
