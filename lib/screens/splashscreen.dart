import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/home.dart';

class SplashsCreen extends StatefulWidget {
  const SplashsCreen({Key? key}) : super(key: key);

  @override
  State<SplashsCreen> createState() => _SplashsCreenState();
}

class _SplashsCreenState extends State<SplashsCreen> {
  showTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    });
  }

  @override
  void initState() {
    showTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset("assets/img/todo.png")),
            const Center(
              child: Text(
                'TO DO',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                'Your Dream List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
