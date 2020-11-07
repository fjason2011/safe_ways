import 'package:flutter/material.dart';
import 'package:safe_ways/CurrentLocation.dart';
import 'package:safe_ways/Directions.dart';
import 'package:safe_ways/History.dart';
import 'package:safe_ways/Paths.dart';
import 'package:safe_ways/Stations.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Ways',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _menuIndex = 0;
  static List<Widget> _Pages = <Widget>[History(), CurrentLocation(), Stations(), Paths(), Directions()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Pages[_menuIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _menuIndex,
        /*
          Navigation Colors by Metro Rail Stations:
            Gold: 0xffae08, (255,174,8)
            Blue: 0x2371e7, (35,113,231)
            Green: 0x0e884e, (14,136,78)
            Red: 0xff2f00, (255,47,0)
            Orange: 0xff7801, (255,120,1)
            Purple: 0x780e67, (120,14,103)
            Silver: 0xc3c3c3, (195,195,195)
          */
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Color.fromRGBO(255,255,255,1.0),
                semanticLabel: "Path History",
              ),
              label: "History",
              backgroundColor:Color.fromRGBO(255,174,8, 1.0)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_location,
              color: Color.fromRGBO(255,255,255,1.0),
              semanticLabel: "Current Location",
            ),
            label: "Location",
            backgroundColor: Color.fromRGBO(35,113,231,1.0),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_bike,
                color: Color.fromRGBO(255,255,255,1.0),
                semanticLabel: "Metro Bike Stations",
              ),
              label: "Stations",
              backgroundColor: Color.fromRGBO(14,136,78,1.0)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timeline,
                color: Color.fromRGBO(255,255,255,1.0),
                semanticLabel: "Find Directions to Bike Station",
              ),
              label: "Paths",
              backgroundColor:  Color.fromRGBO(255,47,0,1.0)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions,
                color: Color.fromRGBO(255,255,255,1.0),
                semanticLabel: "Direction Steps to Bike Station",
              ),
              label: "Directions",
              backgroundColor: Color.fromRGBO(255,120,1,1.0)
          ),

        ],
        onTap: (index){
          setState(() {
            _menuIndex = index;
          });
        },
      ),
    );
  }


}