import 'package:covid_19_tracker_app/services/statesServices.dart';
import 'package:covid_19_tracker_app/view/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class worldStats extends StatefulWidget {
  const worldStats({super.key});

  @override
  State<worldStats> createState() => _worldStatsState();
}

class _worldStatsState extends State<worldStats> with TickerProviderStateMixin {
  List<Map<String,double>>?information =[];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  ).. repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  List<Color>colorList=[
    const Color(0xFF42A5F5),
    const Color(0xFF33691E),
    const Color(0xFFD50000)
  ];

  @override
  void initState(){
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    await Provider.of<StatesServicesProvider>(context, listen:false).parseRecords();
    var records=Provider.of<StatesServicesProvider>(context, listen: false).statesServices?.countryInformation;
    information=records;
    // print("Data : ${information?[0]['cases']}");
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
              future:fetchRecords(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Expanded(
                    flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50,
                      )
                  );
                }
                else{
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          dataMap: {
                            'cases': information?[0]['cases'] ?? 0.0,
                            'Recovered':information?[0]['recovered'] ?? 0.0,
                            'Deaths':information?[0]['deaths'] ?? 0.0,
                          },
                          chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Card(
                        child: Column(
                          children: [
                            reusableRow(value: information?[0]['cases'].toString()?? " ", title: 'Cases'),
                            reusableRow(value: information?[0]['recovered'].toString()?? ' ', title: 'Recovered'),
                            reusableRow(value: information?[0]['deaths'].toString()??' ', title: 'Deaths'),
                            reusableRow(value: information?[0]['active'].toString()??' ', title: 'Active'),
                            reusableRow(value: information?[0]['critical'].toString()??' ', title: 'Critical'),
                            reusableRow(value: information?[0]['affectedCountries'].toString()??' ', title: 'Affected Countries'),
                            reusableRow(value: information?[0]['todayRecovered'].toString()??' ', title: 'Today Recovered'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),

                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: FilledButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const countriesList()));
                          },
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              backgroundColor: const Color(0xFF43A047)
                          ),
                          child: const Text('Track Countries'),
                        ),
                      )
                    ],
                  );
                }
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class reusableRow extends StatelessWidget {
  String title,value;
  reusableRow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
              Text(value,style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
