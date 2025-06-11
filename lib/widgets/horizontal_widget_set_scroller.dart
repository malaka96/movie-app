import 'package:flutter/material.dart';

class HorizontalWidgetSetScroller extends StatelessWidget {
  final List<Widget> widgets;
  const HorizontalWidgetSetScroller({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    //print('from horizontal widget set');
    List<List<Widget>> chunkedWidgets = [];
    for (int i = 0; i < widgets.length; i += 3) {
      int end = (i + 3 < widgets.length) ? i + 3 : widgets.length;
      chunkedWidgets.add(widgets.sublist(i, end));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: chunkedWidgets.map((group) {
          return SizedBox(
            width: 350, // Set width for each column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: group,
            ),
          );
        }).toList(),
      ),
    );
  }
}
