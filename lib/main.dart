import 'package:flutter/material.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(title: Text("siema")),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("s"),
              Text("c"),
              Text("m"),
              Container(
                width: 200,
                height: 100,
                color: Colors.black26,
              )
            ],
          ),
        ),
      ),
    );
  }
}
