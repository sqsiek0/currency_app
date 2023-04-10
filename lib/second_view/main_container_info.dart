import 'package:currency_app/fetch_JSON/model_class.dart';
import 'package:currency_app/second_view/graphs_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../fetch_JSON/get_data.dart';

class MainContainerInfo extends StatefulWidget {
  const MainContainerInfo({super.key});

  @override
  State<MainContainerInfo> createState() => _MainContainerInfoState();
}

class _MainContainerInfoState extends State<MainContainerInfo>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
          future: futureCurrency,
          builder: (context, AsyncSnapshot<Currency> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(40.r),
                          topEnd: Radius.circular(40.r))),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 32.h),
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
                                  futureCurrency =
                                      Network().fetchData(code: "usd");
                                });
                              } else if (value == 2) {
                                setState(() {
                                  futureCurrency =
                                      Network().fetchData(code: "eur");
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
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
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
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 16.0.h, left: 16.0.w, bottom: 16.0.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.money_rounded,
                            size: 32.sp,
                          )),
                    ),
                    Text(
                      snapshot.data!.rates[29].mid.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 16.0.h, left: 16.0.w, bottom: 16.0.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.calendar_today,
                            size: 32.sp,
                          )),
                    ),
                    Text(
                      snapshot.data!.rates[29].effectiveDate
                          .toLocal()
                          .toString()
                          .split(" ")[0],
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
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
          child: Container(
            width: 318.w,
            height: 176.h,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 24.h, right: 24.w),
              child: graphView(snapshot.data),
            ),
          ),
        ),
      ],
    );
  }

  Widget graphView(Currency? data) {
    return LineChart(
      LineChartData(
        minY: 4,
        maxY: 5,
        minX: 0,
        maxX: 29,
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24.h,
              interval: 7,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  // case 0:
                  //   return Text(
                  //       "${data!.rates[0].effectiveDate.toLocal().day}/${data.rates[0].effectiveDate.toLocal().month}");
                  case 7:
                    return Text(
                        "${data!.rates[7].effectiveDate.toLocal().day}/${data.rates[7].effectiveDate.toLocal().month}");
                  case 14:
                    return Text(
                        "${data!.rates[14].effectiveDate.toLocal().day}/${data.rates[14].effectiveDate.toLocal().month}");
                  case 21:
                    return Text(
                        "${data!.rates[21].effectiveDate.toLocal().day}/${data.rates[21].effectiveDate.toLocal().month}");
                  case 28:
                    return Text(
                        "${data!.rates[28].effectiveDate.toLocal().day}/${data.rates[28].effectiveDate.toLocal().month}");
                }
                return Text("");
              },
            ),
          ),
          // leftTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     interval: 0.5,
          //     reservedSize: 48.w,
          //     getTitlesWidget: (value, meta) {
          //       return Text(
          //         value.toStringAsFixed(1),
          //       );
          //     },
          //   ),
          // ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < data!.rates.length; i++)
                FlSpot(i.toDouble(),
                    double.parse(data.rates[i].mid.toStringAsFixed(2)))
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
