import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:currency_app/second_view/second_view_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  late Currency currencyUSD;
  late Currency currencyEUR;

  @override
  void initState() {
    super.initState();
    futureCurrency = Network().fetchData(code: "eur");
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: FutureBuilder(
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
                            padding: EdgeInsets.only(top: 16.h, left: 16.w),
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
                        child:
                            const AnimatedMainText(), //TODO: Zmienić tekst na coś w stylu Start your journey
                      ),
                      GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (details.velocity.pixelsPerSecond.dy < 100) {
                            Get.to(() => const SecondView(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 600));
                            
                          }
                        },
                        child: swipeUp(),
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
          drawer: const MyDrawerClass(), // TODO: Zrobić ten drawer do końca
        ),
      ),
    );
  }

  Widget swipeUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.h,
        ),
        Icon(
          Icons.arrow_circle_up_rounded,
          size: 64.sp,
        ),
      ],
    );
  }
}
