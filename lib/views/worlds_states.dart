import 'dart:async';

import 'package:coviedapp/reuseable/reuse_rows.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates> with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldsStates()));
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
  final ColorList =<Color> [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.01,),
            PieChart(dataMap: {
              "Total": 25,
              "Recovered": 10,
              "Death": 5,
              "Active": 10,
            
            },
            chartRadius: MediaQuery.of(context).size.width/3.2,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.left,
            ),
            animationDuration: const Duration(milliseconds: 1300),
            chartType: ChartType.ring,
            colorList: ColorList,

            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
              child: Card(
                child: Column(
                  children: [
                    ReuseRows(title: "Total", value: "200"),
                    ReuseRows(title: "Recovered", value: "100"),
                    ReuseRows(title: "Death", value: "50"),
                    ReuseRows(title: "Active", value: "50"),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 141, 41),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text("Track Countries"),
              ),
            )
            
          ],
        ),
      )),
    );
  }
}