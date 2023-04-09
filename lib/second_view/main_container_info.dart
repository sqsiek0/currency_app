import 'package:currency_app/fetch_JSON/model_class.dart';
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
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
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
                            GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity! < 50) {
                                    setState(() {
                                      futureCurrency =
                                          Network().fetchData(code: "usd");
                                    });
                                  }
                                },
                                child: Container()),
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
          ),
        ),
      ],
    );
  }
}
