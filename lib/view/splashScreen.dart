import 'dart:async';
import 'package:covid_19_tracker_app/view/worldStats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const worldStats()))
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: SizedBox(
                    height: 200, width: 200,
                    child: const Center(
                      child: Image(image: AssetImage('assets/virus.png')),
                    ),
                  ),
                  builder: (context, Widget? child){
                    return Transform.rotate(
                        angle: _controller.value*2*math.pi,
                      child: child,
                    );
                  }
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              const Align(
                alignment: Alignment.center,
                child: Text('Covid 19\n Tracker App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
              )
            ],
          )
      ),
    );
  }
}
