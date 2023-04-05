import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:flutter/material.dart';
import '../fetch_JSON/get_data.dart';
import '../fetch_JSON/model_class.dart';
import 'front_text.dart';

class MainViewPage extends StatefulWidget {
  const MainViewPage({super.key});

  @override
  State<MainViewPage> createState() => _MainViewPageState();
}

class _MainViewPageState extends State<MainViewPage> {
  late Future<Currency> futureCurrency;

  @override
  void initState() {
    super.initState();
    futureCurrency = Network().fetchData(code: "eur");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureCurrency,
        builder: (context, AsyncSnapshot<Currency> snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                    const SizedBox(
                        width: 200, height: 150, child: CirclesCorner())
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 56),
                  child: AnimatedMainText(),
                )
              ],
            );
          } else if (snapshot.hasError) {
            throw Exception(snapshot.error);
          }
          return const CircularProgressIndicator();
        },
      ),
      drawer: const MyDrawerClass(), // TODO: Zrobić ten drawer do końca
    );
  }
}
