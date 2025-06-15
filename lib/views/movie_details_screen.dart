import 'package:flutter/material.dart';
import 'package:movie_app/data/api_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Map<String, dynamic>> movieData;

  @override
  void initState() {
    super.initState();
    movieData = ApiService().fetchMovieDetails("1284120");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading movies"));
          } else {
            final moviePoster = snapshot.data!["poster"];

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Movie Details'),
                  expandedHeight: MediaQuery.of(context).size.height,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      moviePoster,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
                    Text('yello'),
                    SizedBox(height: 10),
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
