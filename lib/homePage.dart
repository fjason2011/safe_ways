import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';



class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  {
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
      );
    }
  }