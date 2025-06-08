import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieGallery extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieGallery({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          autoPlay: true,
          viewportFraction: 1.0,
        ),
        items: movies.map((movie) {
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CachedNetworkImage(
                  imageUrl: movie["poster"]!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 50),
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 20,
                right: 20,
                child: Text(
                  movie["title"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6,
                left: 20,
                right: 20,
                child: Text(
                  movie["description"]!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
