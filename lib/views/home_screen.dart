import 'package:flutter/material.dart';
import '../widgets/movie_gallery.dart';
import '../data/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // ✅ Added super.key

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, String>>> nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    nowPlayingMovies = ApiService().fetchNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: nowPlayingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading movies"));
          } else {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(
                    context,
                  ).size.height, // ✅ Gallery takes 70% of screen
                  floating: false,
                  pinned: true, // ✅ Keeps the image at the top
                  flexibleSpace: FlexibleSpaceBar(
                    background: MovieGallery(movies: snapshot.data!),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Other UI Elements Here",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "More Content Below...",
                        style: TextStyle(color: Colors.white),
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
