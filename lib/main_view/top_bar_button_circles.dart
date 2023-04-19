import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:currency_app/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
      ),
      iconSize: 40.sp,
    );
  }
}

class MyDrawerClass extends StatefulWidget {
  const MyDrawerClass({super.key});

  @override
  State<MyDrawerClass> createState() => _MyDrawerClassState();
}

class _MyDrawerClassState extends State<MyDrawerClass> {
  bool _valueOfSwitch = false;
  List<String> iconsPath = [
    "assets/icons/github.png",
    "assets/icons/linkedin.png",
    "assets/icons/info-button.png"
  ];
  List<String> buttonName = ["GitHub", "LinkedIn", "Info"];
  List<String> urlWebsite = [
    "https://github.com/sqsiek0",
    "https://linkedin.com/in/klaudiusz-kalinowski-26699b261/",
    "http://github.com/sqsiek0/currency_app"
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor:
            _valueOfSwitch ? darkTheme.primary : lightTheme.primary,
        elevation: 8,
        width: 0.8.sw,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: 1.sw,
                height: 0.4.sh,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: _valueOfSwitch
                        ? darkTheme.secondary
                        : lightTheme.secondary,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Klaudiusz Kalinowski",
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _valueOfSwitch
                                      ? darkTheme.primary
                                      : lightTheme.primary),
                            ),
                            Switch(
                                //TODO: Wybrać kolory tego switcha jak wybierzesz palete
                                value: _valueOfSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    _valueOfSwitch = value;
                                  });
                                  print(_valueOfSwitch);
                                }),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: _valueOfSwitch
                                ? darkTheme.primary
                                : lightTheme.primary,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 48.0.w),
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: ElevatedButton(
                          onPressed: () {
                            goToWebsite(urlWebsite[i]);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                _valueOfSwitch
                                    ? darkTheme.secondary
                                    : lightTheme.primary,
                              ),
                              fixedSize: MaterialStatePropertyAll<Size>(
                                Size(1.sw, 64.h),
                              ),
                              elevation:
                                  const MaterialStatePropertyAll<double>(4),
                              shape: MaterialStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                iconsPath[i],
                                height: 32.h,
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  buttonName[i],
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> goToWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   throw 'Could not launch $url';
    // }
    try {
      await launchUrl(uri);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}

class CirclesCorner extends StatefulWidget {
  const CirclesCorner({super.key});

  @override
  State<CirclesCorner> createState() => _CirclesCornerState();
}

class _CirclesCornerState extends State<CirclesCorner> {
  //TODO: Zmienne do kolorów - zmien jak się zdecydujesz jakie kolory chcesz
  Color? bigCircleColor = Colors.grey[300];
  Color? smallCircleColor = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -35.h,
            left: 20.w,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                  color: smallCircleColor,
                  borderRadius: BorderRadius.circular(50.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.r,
                      blurRadius: 8.r,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
            )),
        Positioned(
          top: -85.h,
          left: 75.w,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
                color: bigCircleColor,
                borderRadius: BorderRadius.circular(100.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.r,
                    blurRadius: 8.r,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
