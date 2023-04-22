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

  @override
  void initState() {
    futureCurrency = Network().fetchData(code: "eur");

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    double noDollar = 32.sp;
    double dollar = 32.sp;
    double euro = 32.sp;

    return Container(
        width: 1.sw,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(40.r),
                topEnd: Radius.circular(40.r))),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      spreadRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ]),
              width: 1.sw,
              height: 80.h,
              child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onBackground.withAlpha(75),
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 4.h,
                      ),
                      insets:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 1.h),
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
                    } else {
                      setState(() {});
                    }
                  },
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.money_off,
                        size: noDollar,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.attach_money,
                        size: dollar,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.euro,
                        size: euro,
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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          "Welcome to this app!",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text(
                            "Here you can check the current prices of the most popular currencies in the world. Everything is in your pocket.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.5.h,
                                letterSpacing: 1.w,
                                fontSize: 16.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
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
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 4,
                          spreadRadius: 3,
                          offset: Offset(0, 3))
                    ]),
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
                            color: Theme.of(context).colorScheme.onBackground,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: Text(
                        snapshot.data!.rates[29].mid.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
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
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4,
                        spreadRadius: 3,
                        offset: Offset(0, 3))
                  ],
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
                            color: Theme.of(context).colorScheme.onBackground,
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
                          color: Theme.of(context).colorScheme.onBackground,
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

  Widget clickOnGraph(AsyncSnapshot<Currency> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 296.w,
            height: 176.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 4)
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
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      return MyGraph(
                        data: snapshot.data,
                      );
                    },
                    child: MyGraph(
                      data: snapshot.data,
                    ),
                  )),
            ),
          ),
        ),
      ],
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
        borderData: FlBorderData(
          border: Border.all(
              width: 2.w,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2)),
        ),
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
              axisNameWidget: Icon(Icons.arrow_drop_down_sharp,
                  size: 40.sp,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.5))
              // sideTitles: SideTitles(showTitles: visible)
              ),
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
            color: Theme.of(context).colorScheme.primary,
            spots: [
              for (int i = 0; i < widget.data!.rates.length; i++)
                FlSpot(i.toDouble(),
                    double.parse(widget.data!.rates[i].mid.toStringAsFixed(2)))
            ],
            isCurved: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
