import 'package:flutter/material.dart';
import 'package:safe_ways/CurrentLocation.dart';
import 'package:safe_ways/Directions.dart';
import 'package:safe_ways/History.dart';
import 'package:safe_ways/Paths.dart';
import 'package:safe_ways/Stations.dart';

class NavigationPage extends StatefulWidget {
  List _stationData;

  NavigationPage(this._stationData);

  @override
  _NavigationPage createState() => _NavigationPage(this._stationData);
}

class _NavigationPage extends State<NavigationPage> {
  List _stationData;
  int _currentIndex = 0;

  _NavigationPage(this._stationData);

  @override
  void initState(){
    super.initState();
  }

  //onTap in BottomNavigationBar is of type void Function (int) so this method is called everytime the navigation bar is pressed
  //to update _currentIndex to the actual index of the naavigation items
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  //return widget of index that is called in bottom navigation bar
  Widget getPages(int index){
    //_stationData is passed individually to any Page that needs it
    if(index == 0){
      return History();
    }
    if(index == 1){
      return CurrentLocation(this._stationData);
    }
    if(index == 2){
      return Stations(this._stationData);
    }
    if(index == 3){
      return Paths();
    }
    if(index == 4){
      return Directions();
    }
    return NavigationPage(this._stationData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPages(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
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
              backgroundColor: Color.fromRGBO(255,174,8, 1.0)
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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }


}