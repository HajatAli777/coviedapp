import 'package:coviedapp/models/worldStates_model.dart';
import 'package:coviedapp/reuseable/reuse_rows.dart';
import 'package:coviedapp/services/states_services.dart';
import 'package:coviedapp/views/countries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  final StatesServices statesServices = StatesServices();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("World COVID Statistics"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldstatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                      controller: controller,
                    ),
                  );
                }
        
                var data = snapshot.data!;
        
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
        
                    /// Pie Chart
                    PieChart(
                      dataMap: {
                        "Total": data.cases!.toDouble(),
                        "Recovered": data.recovered!.toDouble(),
                        "Deaths": data.deaths!.toDouble(),
                        "Active": data.active!.toDouble(),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      colorList: colorList,
                    ),
        
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
        
                    /// Card Stats
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ReuseRows(
                                title: "Total",
                                value: snapshot.data!.cases.toString()),
                            ReuseRows(
                                title: "Deaths",
                                value: snapshot.data!.recovered.toString()),
                            ReuseRows(
                                title: "Recoevered",
                                value: snapshot.data!.deaths.toString()),
                            ReuseRows(
                                title: "Active",
                                value: snapshot.data!.active.toString()),
                                
                            ReuseRows(
                                title: "Critical",
                                value: snapshot.data!.cases.toString()),
                            ReuseRows(
                                title: "Today Deaths",
                                value: snapshot.data!.recovered.toString()),
                            ReuseRows(
                                title: "Today Recovered",
                                value: snapshot.data!.deaths.toString()),
                                                     ],
                        ),
                      ),
                    ),
        
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
        
                    /// Button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CountriesPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 141, 41),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Track Countries",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}