import 'package:currency_app/fetch_JSON/model_class.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GraphInfo extends StatefulWidget {
  const GraphInfo({super.key, required this.data});
  final Currency? data;

  @override
  State<GraphInfo> createState() => _GraphInfoState();
}

class _GraphInfoState extends State<GraphInfo> {
  TextStyle styleText = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: WholeUpContainerInfo(data: widget.data),
              ),
              SliverToBoxAdapter(
                child: dataBetweenViews(),
              ),
              SliverFixedExtentList(
                itemExtent: 1.sh * 0.12,
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.data!.rates.length,
                  (context, index) => listOfPastValues(context, index),
                ),
              )
            ],
          ),
        ));
  }

  Column dataBetweenViews() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: SizedBox(
            width: 126.w,
            child: Divider(
              thickness: 2,
              height: 2.h,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            child: Text("Last 30 days",
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        ),
      ],
    );
  }

  Padding listOfPastValues(BuildContext context, int index) {
    TextStyle styleText = TextStyle(
        fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.white70);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        color: Theme.of(context).colorScheme.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.price_change,
                  size: 32.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  widget.data!.rates[index].mid.toStringAsFixed(2),
                  style: styleText,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 24.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  widget.data!.rates[index].effectiveDate
                      .toLocal()
                      .toString()
                      .split(" ")[0],
                  style: styleText,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WholeUpContainerInfo extends SliverPersistentHeaderDelegate {
  WholeUpContainerInfo({required this.data});

  final Currency? data;
  TextStyle styleText = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: Colors.white70);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: 1.sw,
      height: 366.h,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.r),
              bottomRight: Radius.circular(32.r)),
          boxShadow: [
            BoxShadow(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
                blurRadius: 4,
                offset: const Offset(0, 6))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).hintColor,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
            graphAfterClick(context)
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 366.h;

  @override
  double get minExtent => 366.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget graphAfterClick(BuildContext context) {
    return Flexible(
        child: Hero(
            tag: "graph",
            transitionOnUserGestures: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: LineChart(
                LineChartData(
                  minY: 4,
                  maxY: 5,
                  minX: 0,
                  maxX: 29,
                  backgroundColor: Colors.transparent,
                  borderData: FlBorderData(
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.2),
                        width: 2),
                  ),
                  gridData: FlGridData(show: false),
                  lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((touchedSpot) {
                            return LineTooltipItem(
                                touchedSpot.y.toStringAsFixed(2),
                                TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp));
                          }).toList();
                        },
                      )),
                  titlesData: FlTitlesData(
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 7,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text(
                                "${data!.rates[0].effectiveDate.toLocal().day}/${data!.rates[0].effectiveDate.toLocal().month}",
                                style: styleText,
                              );
                            case 7:
                              return Text(
                                "${data!.rates[7].effectiveDate.toLocal().day}/${data!.rates[7].effectiveDate.toLocal().month}",
                                style: styleText,
                                softWrap: true,
                              );

                            case 14:
                              return Text(
                                "${data!.rates[14].effectiveDate.toLocal().day}/${data!.rates[14].effectiveDate.toLocal().month}",
                                style: styleText,
                              );
                            case 21:
                              return Text(
                                "${data!.rates[21].effectiveDate.toLocal().day}/${data!.rates[21].effectiveDate.toLocal().month}",
                                style: styleText,
                              );
                            case 28:
                              return Text(
                                "${data!.rates[28].effectiveDate.toLocal().day}/${data!.rates[28].effectiveDate.toLocal().month}",
                                style: styleText,
                              );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 32.w,
                        interval: 0.5,
                        getTitlesWidget: (value, meta) {
                          switch (value.toString()) {
                            case "4.0":
                              return Center(
                                  child: Text(
                                "4",
                                style: styleText,
                              ));
                            case "4.5":
                              return Center(
                                  child: Text(
                                "4.5",
                                style: styleText,
                              ));
                            case "5.0":
                              return Center(
                                  child: Text(
                                "5",
                                style: styleText,
                              ));
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      color: Theme.of(context).colorScheme.primary,
                      spots: [
                        for (int i = 0; i < data!.rates.length; i++)
                          FlSpot(
                              i.toDouble(),
                              double.parse(
                                  data!.rates[i].mid.toStringAsFixed(2)))
                      ],
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
