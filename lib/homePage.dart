import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  LatLng _initialPosition = LatLng(34.0522, -118.2437);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _ctrl) {
    _controller = _ctrl;
    _location.onLocationChanged.listen((event) {
      _controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(event.latitude, event.longitude), zoom: 10)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 10),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
                Icons.home,
                color: Color.fromRGBO(255,174,8, 1.0),
                semanticLabel: "Home",
              ),
              label: "Home",
              backgroundColor: Color.fromRGBO(195,195,195,0.5)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.my_location,
                color: Color.fromRGBO(35,113,231,1.0),
                semanticLabel: "Current Location",
              ),
              label: "Location",
              backgroundColor: Color.fromRGBO(195,195,195,0.5)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_bike,
                color: Color.fromRGBO(14,136,78,1.0),
                semanticLabel: "Metro Bike Stations",
              ),
              label: "Stations",
              backgroundColor: Color.fromRGBO(195,195,195,0.5)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timeline,
                color: Color.fromRGBO(255,47,0,1.0),
                semanticLabel: "Find Directions to Bike Station",
              ),
              label: "Paths",
              backgroundColor: Color.fromRGBO(195,195,195,0.5)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.directions,
                color: Color.fromRGBO(255,120,1,1.0),
                semanticLabel: "Direction Steps to Bike Station",
              ),
              label: "Directions",
              backgroundColor: Color.fromRGBO(195,195,195,0.5)
          )
        ],
      ),
    );
  }
}
