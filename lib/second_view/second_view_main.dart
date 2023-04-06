import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:flutter/material.dart';
import 'package:currency_app/main_view/front_text.dart';
import 'package:get/get.dart';
import '../fetch_JSON/get_data.dart';
import '../fetch_JSON/model_class.dart';

class SecondView extends StatefulWidget {
  const SecondView({super.key});

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Builder(builder: (context) {
                    return const MenuIcon();
                  }),
                ),
                const SizedBox(width: 200, height: 125, child: CirclesCorner())
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 56),
              child: AnimatedMainText(), //TODO: Zmienić na bez animacji
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Back"))
          ],
        ),
      ),
      drawer: const MyDrawerClass(), // TODO: Zrobić ten drawer do końca
    );
  }
}
