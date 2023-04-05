import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:flutter/material.dart';

class MainViewPage extends StatelessWidget {
  const MainViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Builder(builder: (context) {
              return const MenuIcon();
            }),
          ),
          const SizedBox(width: 200, height: 200, child: CirclesCorner())
        ],
      ),
      drawer: const MyDrawerClass(), // TODO: Zrobić ten drawer do końca
    );
  }
}
