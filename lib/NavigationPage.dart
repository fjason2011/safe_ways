import 'package:http/http.dart' as superagent;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safe_ways/CurrentLocation.dart';
import 'package:safe_ways/Directions.dart';
import 'package:safe_ways/History.dart';
import 'package:safe_ways/Paths.dart';
import 'package:safe_ways/Stations.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPage createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  List _stationData;
  int _currentIndex = 0;

  //method that returns metro bike share api data. superagent variable name is not JS superagent module. I just named it that
  //because I like the name and wanted to create confusion, check the imports
  Future getStationData() async{
    superagent.Response response = await superagent.get('https://bikeshare.metro.net/stations/json/');
    return json.decode(response.body)['features'];
  }

  //this method is called in app startup. If you need any data or need to set data, this will be a pretty good place to start
  //if you are using api's follow async/await promise procedure similar to JS
  @override
  void initState(){
    super.initState();
    getStationData().then((value){
      setState(() {
        this._stationData = value;
      });
    });
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
    return NavigationPage();
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