import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:currency_app/second_view/second_view_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
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
    return Consumer<ThemeSwitch>(
        builder: (context, switchTheme, child) => ScreenUtilInit(
              designSize: const Size(412, 732),
              builder: (context, child) => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: Colors.amber,
                  scaffoldBackgroundColor: const Color(0xFFE5E5E5),
                ),
                darkTheme: ThemeData(
                    primaryColor: Colors.green,
                    scaffoldBackgroundColor: const Color(0xFF1E1E1E)),
                themeMode: switchTheme.valueOfSwitch
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: Scaffold(
                  body: SafeArea(
                    child: FutureBuilder(
                      future: futureCurrency,
                      builder: (context, AsyncSnapshot<Currency> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 16.h, left: 16.w),
                                    child: Builder(builder: (context) {
                                      return const MenuIcon();
                                    }),
                                  ),
                                  SizedBox(
                                      width: 200.w,
                                      height: 125.h,
                                      child: const CirclesCorner())
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 56.w),
                                child: const AnimatedMainText(),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onVerticalDragUpdate: (details) {
                                    if (details.delta.dy < 0) {
                                      Get.to(() => const SecondView(),
                                          transition: Transition.downToUp,
                                          duration: const Duration(
                                              milliseconds: 600));
                                    }
                                  },
                                  child: swipeUp(context),
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          throw Exception(snapshot.error);
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  drawer: const MyDrawerClass(),
                ),
              ),
            ));
  }

  Widget swipeUp(BuildContext context) {
    return Icon(Icons.swipe_up_rounded, size: 64.sp);
  }
}
