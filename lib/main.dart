import 'package:flutter/material.dart';
import 'package:movie_app/theme/theme_data.dart';
import 'package:movie_app/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppThemes.darkTheme, home: HomeScreen());
  }
}
