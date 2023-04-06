import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class MyDrawerClass extends StatelessWidget {
  const MyDrawerClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
        child: Center(
      child: Placeholder(),
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
              ),
            )),
        Positioned(
          top: -75.h,
          left: 75.w,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: bigCircleColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        )
      ],
    );
  }
}
