import 'dart:async';
import 'dart:math';
import 'package:coviedapp/views/worlds_states.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WorldsStates()),
        (route) => false,
      );
    });

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Image(
                    image: AssetImage('assets/covid.png'),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2 * pi,
                    child: child,
                  );
                },
              ),
              
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const Align(
              alignment: Alignment.center,
              child: Text("COVID-19 Tracker",
                  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),

          ],
        ),
      ),
    );
  }
}