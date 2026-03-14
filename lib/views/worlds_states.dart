import 'dart:async';
import 'package:coviedapp/reuseable/reuse_rows.dart';
import 'package:coviedapp/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),

              /// FutureBuilder
              FutureBuilder(
                future: services.fetchWorldStatesRecords(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    return const Text("Error loading data");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              /// Pie Chart
              PieChart(
                dataMap: const {
                  "Total": 25,
                  "Recovered": 10,
                  "Death": 5,
                  "Active": 10,
                },
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.left),
                animationDuration: const Duration(milliseconds: 1300),
                chartType: ChartType.ring,
                colorList: colorList,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(
                    children:  [
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
                child: const Center(
                  child: Text(
                    "Track Countries",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}