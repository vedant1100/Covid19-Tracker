import 'package:covid_19_tracker_app/services/statesServices.dart';
import 'package:covid_19_tracker_app/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){return StatesServicesProvider();}),
        ChangeNotifierProvider(create: (context){return CountriesServiceProvider();})
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        theme:ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue
        ),
        home: const splashScreen(),
      ),
    );
  }
}
