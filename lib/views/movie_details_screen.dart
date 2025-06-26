import 'package:flutter/material.dart';
import 'package:movie_app/data/api_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Map<String, dynamic>> movieData;

  @override
  void initState() {
    super.initState();
    movieData = ApiService().fetchMovieDetails(widget.id);
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
            final data = snapshot.data as Map<String, dynamic>;
            final String moviePoster = data["poster"] ?? '';
            final String title = data["title"] ?? 'Untitled';
            final String genre = data["genres"] ?? 'Unknown';
            final double rating = (data["rating"] ?? 0).toDouble();
            final String description = data["description"] ?? '';
            final String releaseDate = data["date"] ?? 'Unknown';
            final List<Map<String, String>> actors =
                List<Map<String, String>>.from(data["actors"] ?? []);

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Movie Details'),
                  expandedHeight: MediaQuery.of(context).size.height,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: (moviePoster.isNotEmpty)
                        ? Image.network(moviePoster, fit: BoxFit.cover)
                        : Container(
                            color: Colors.grey[800],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            label: Text('Title'),
                            labelStyle: TextStyle(fontSize: 12),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(title),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text('Genre'),
                                labelStyle: TextStyle(fontSize: 12),
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Chip(
                                label: Text('Rating'),
                                labelStyle: TextStyle(fontSize: 12),
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(genre),
                                Text('${rating.toStringAsFixed(1)}/10'),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Chip(
                            label: Text('Description'),
                            labelStyle: TextStyle(fontSize: 12),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(description),
                          ),
                          SizedBox(height: 15),
                          Chip(
                            label: Text('Release Date'),
                            labelStyle: TextStyle(fontSize: 12),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(releaseDate),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Actors'),
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: actors.map((actor) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    actor["profilePic"]!,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  actor["name"] ?? '',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  actor["character"] ?? '',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
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
