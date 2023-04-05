import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(Icons.menu));
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
  //* Zmienne do kolorów - zmien jak się zdecydujesz jakie kolory chcesz
  Color? bigCircleColor = Colors.grey[300];
  Color? smallCircleColor = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -30,
            left: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: smallCircleColor,
                borderRadius: BorderRadius.circular(50),
              ),
            )),
        Positioned(
          top: -75,
          left: 75,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: bigCircleColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        )
      ],
    );
  }
}
