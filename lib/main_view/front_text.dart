import 'package:flutter/material.dart';

class MainText extends StatefulWidget {
  const MainText({super.key});

  @override
  State<MainText> createState() => _MainTextState();
}

class _MainTextState extends State<MainText> {
  Color bigText = Colors.black;

  Color smallText = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: RichText(
            text: TextSpan(
                text: "Find out",
                style: TextStyle(
                    fontSize: 44,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: bigText),
                children: [
              TextSpan(
                  text: " the details",
                  style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                      color: smallText))
            ])));
  }
}

class AnimatedMainText extends StatefulWidget {
  const AnimatedMainText({super.key});

  @override
  State<AnimatedMainText> createState() => _AnimatedMainTextState();
}

class _AnimatedMainTextState extends State<AnimatedMainText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500))
    ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, 0.07), // todo: Pobawić się tymi wartościami
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: const MainText(),
    );
  }
}