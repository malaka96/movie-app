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
            final String title = snapshot.data!["title"];
            final String genre = snapshot.data!["genres"];
            final double rating = snapshot.data!["rating"];
            final String description = snapshot.data!["description"];
            final actors = snapshot.data!["actors"];

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Movie Details'),
                  expandedHeight: MediaQuery.of(context).size.height,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(moviePoster, fit: BoxFit.cover),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(title),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(genre),
                          Text('${rating.toStringAsFixed(1)}/10'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(description),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: actors.map((actor) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(actor["profilePic"]),
                              ),
                            ],
                          );
                        })),
                      ),
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
