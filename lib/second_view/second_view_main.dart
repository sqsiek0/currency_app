import 'package:currency_app/main_view/top_bar_button_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_container_info.dart';

class SecondView extends StatefulWidget {
  const SecondView({super.key});

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutBack,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, left: 16.w),
                    child: Builder(builder: (context) {
                      return const MenuIcon();
                    }),
                  ),
                  SizedBox(
                      width: 200.w, height: 125.h, child: const CirclesCorner())
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 56.h),
              ),
              const MainContainerInfo(),
            ],
          ),
        ),
      ),
      drawer: const MyDrawerClass(),
    );
  }
}
