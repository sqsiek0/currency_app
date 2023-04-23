import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:currency_app/colors/colors.dart';
import 'package:provider/provider.dart';
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
    final switchTheme = Provider.of<ThemeSwitch>(context);
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 8,
        width: 0.8.sw,
        child: Column(
          children: [
            SizedBox(
              width: 1.sw,
              height: 0.42.sh,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
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
                                color: Theme.of(context).hintColor),
                          ),
                          Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,

                              value: switchTheme.valueOfSwitch,
                              onChanged: (value) {
                                // setState(() {
                                //   _valueOfSwitch = value;
                                // });
                                switchTheme.changeTheme(value);
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
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: CircleAvatar(
                            radius: 100.r,
                            backgroundImage: Image.asset(
                              "assets/images/me.jpg",
                              fit: BoxFit.contain,
                            ).image,
                          )),
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
                              Theme.of(context).scaffoldBackgroundColor,
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
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                buttonName[i],
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
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
        ));
  }

  Future<void> goToWebsite(String url) async {
    final Uri uri = Uri.parse(url);
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
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(50.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 2.r,
                      blurRadius: 4.r,
                      offset: const Offset(0, 2), // changes position of shadow
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
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(100.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 2.r,
                    blurRadius: 4.r,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
