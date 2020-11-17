import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:safe_ways/NavigationPage.dart';
import 'package:safe_ways/delayed_animation.dart';
import 'package:http/http.dart' as superagent;
import 'dart:async';
import 'dart:convert';

//HomePage made using sagarshende23 Reflectly Login Screen splash page
//https://github.com/sagarshende23/Reflectly-Login-Screen
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List _stationData; //Metro Bike Share API Data
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    //Metro Bike Share API called here and saved to _stationData
    getStationData().then((value){
      setState(() {
        this._stationData = value;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future getStationData() async{
    superagent.Response response = await superagent.get('https://bikeshare.metro.net/stations/json/');
    return json.decode(response.body)['features'];
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromRGBO(195, 195, 195, 1.0),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                AvatarGlow(
                  endRadius: 120,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(195, 195, 195, 1.0),
                        backgroundImage: AssetImage("assets/safeways.png"),
                        radius: 75.0,
                      )),
                ),
                DelayedAnimation(
                  child: Text(
                    "Hi There!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "I'm SafeWays",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 30.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "Your New Personal",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 3000,
                ),
                DelayedAnimation(
                  child: Text(
                    "Traveling companion",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 3000,
                ),
                SizedBox(
                  height: 100.0,
                ),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: (){
                      //_stationData is then given to NavigationPage so the data is ready by the time the person wants to navigate through the tabs.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage(this._stationData)));
                    },
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),


              ],
            ),
          )
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Let\'s get started',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(195, 195, 195, 1.0),
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}