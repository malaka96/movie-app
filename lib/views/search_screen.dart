import 'package:flutter/material.dart';
import 'package:movie_app/data/api_service.dart';
import 'package:movie_app/widgets/movie_image_text_row.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  List<Map<String, String>> searchResults = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void resetSearch() {
    setState(() {
      _controller.clear();
      _focusNode.unfocus();
      searchResults = [];
    });
  }

  void performSearch(String query) async {
    final results =
        await ApiService().searchMovies(query);
    setState(() {
      searchResults = results; // You’ll map and display these
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> searchMoviesWidgets = searchResults
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: TextStyle(color: Colors.white),
                    onSubmitted: (value) => performSearch(value),
                    decoration: InputDecoration(
                      hintText: 'Shows, Movies and More',
                      suffixIcon: _isFocused
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: resetSearch,
                            )
                          : null,
                      hintStyle: TextStyle(color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: 
                  searchMoviesWidgets.map((widget){
                    return widget;
                  } ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
