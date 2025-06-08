import 'package:flutter/material.dart';

class MovieImageTextRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  //final String description;
  const MovieImageTextRow({
    required this.imageUrl,
    required this.title,
    //required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4, //40% of screen width
          height:
              (MediaQuery.of(context).size.width * 0.4) *
              (9 / 16), // 16:9 aspect ratio
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, //Ensure image covers the area
            ),
          ),
        ),
        const SizedBox(width: 16), // Spacing between image & text
        Expanded(
          //Ensures text fills remaining space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // const SizedBox(height: 8),
              // Text(
              //   description,
              //   style: const TextStyle(fontSize: 16, color: Colors.white),
              //   maxLines: 3, //Prevents overflow
              //   overflow: TextOverflow.ellipsis,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
