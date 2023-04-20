import 'package:currency_app/fetch_JSON/model_class.dart';
import 'package:currency_app/second_view/on_click_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../fetch_JSON/get_data.dart';

class MainContainerInfo extends StatefulWidget {
  const MainContainerInfo({super.key});

  @override
  State<MainContainerInfo> createState() => _MainContainerInfoState();
}

class _MainContainerInfoState extends State<MainContainerInfo>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: const Duration(milliseconds: 1500));
  late Future<Currency> futureCurrency;

  late final AnimationController _glowController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat(reverse: true);

  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    futureCurrency = Network().fetchData(code: "eur");
    _glowAnimation = Tween<double>(begin: 0.5, end: 12).animate(_glowController)
      ..addListener(() {
        setState(() {});
      });
    // _glowAnimation =
    //     CurvedAnimation(parent: _glowController, curve: Curves.easeIn)
    //       ..addListener(() {
    //         setState(() {});
    //       });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
          future: futureCurrency,
          builder: (context, AsyncSnapshot<Currency> snapshot) {
            if (snapshot.hasData) {
              return tabBarView(snapshot);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Container tabBarView(AsyncSnapshot<Currency> snapshot) {
    return Container(
        width: 1.sw,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(40.r),
                topEnd: Radius.circular(40.r))),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(32.r),
              ),
              width: 1.sw,
              height: 80.h,
              child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black26,
                  labelStyle: TextStyle(fontSize: 40.sp),
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.h,
                      ),
                      insets: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 16.h),
                      borderRadius: BorderRadius.circular(8.r)),
                  physics: const BouncingScrollPhysics(),
                  onTap: (value) {
                    if (value == 1) {
                      setState(() {
                        futureCurrency = Network().fetchData(code: "usd");
                      });
                    } else if (value == 2) {
                      setState(() {
                        futureCurrency = Network().fetchData(code: "eur");
                      });
                    }
                  },
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.money_off,
                        size: 32.sp,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.attach_money,
                        size: 32.sp,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.euro,
                        size: 32.sp,
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 1.sw,
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  //! Jeśli będziesz tworzył wykres spróbuj go opoznic ładoowaniem w kółko
                  Container(),
                  detailsOfCurrency(snapshot),
                  detailsOfCurrency(snapshot),
                ],
              ),
            ),
          )
        ]));
  }

  Column detailsOfCurrency(AsyncSnapshot<Currency> snapshot) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 168.w,
                height: 128.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.money_rounded,
                            size: 32.sp,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: Text(
                        snapshot.data!.rates[29].mid.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 168.w,
                height: 128.h,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.calendar_today,
                            size: 24.sp,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: Text(
                        snapshot.data!.rates[29].effectiveDate
                            .toLocal()
                            .toString()
                            .split(" ")[0],
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: clickOnGraph(snapshot),
        ),
      ],
    );
  }

  Container clickOnGraph(AsyncSnapshot<Currency> snapshot) {
    return Container(
      width: 318.w,
      height: 176.h,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                // offset: Offset(8, 8),
                blurRadius: 12,
                spreadRadius: _glowAnimation.value)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: GestureDetector(
            onTap: () {
              Get.to(
                () => GraphInfo(
                  data: snapshot.data,
                ),
                duration: const Duration(milliseconds: 500),
              );
            },
            child: Hero(
              tag: "graph",
              transitionOnUserGestures: true,
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                return MyGraph(
                  data: snapshot.data,
                );
              },
              child: MyGraph(
                data: snapshot.data,
              ),
            )),
      ),
    );
  }
}

class MyGraph extends StatefulWidget {
  const MyGraph({super.key, required this.data});
  final Currency? data;

  @override
  State<MyGraph> createState() => _MyGraphState();
}

class _MyGraphState extends State<MyGraph> {
  @override
  Widget build(BuildContext context) {
    bool visible = false;
    return LineChart(
      LineChartData(
        minY: 4,
        maxY: 5,
        minX: 0,
        maxX: 29,
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: visible)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: visible)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: visible,
              reservedSize: 24.h,
              interval: 7,
              getTitlesWidget: (value, meta) {
                return const Text("");
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: visible,
              reservedSize: 24.w,
              interval: 0.5,
              getTitlesWidget: (value, meta) {
                return const Text("");
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < widget.data!.rates.length; i++)
                FlSpot(i.toDouble(),
                    double.parse(widget.data!.rates[i].mid.toStringAsFixed(2)))
            ],
            isCurved: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
