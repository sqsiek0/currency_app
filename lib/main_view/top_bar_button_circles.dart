import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:currency_app/colors/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Klaudiusz Kalinowski",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                )),
                            Switch(
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
            ],
          ),
        ));
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
