import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class CurrentLocation extends StatefulWidget {
  List _stationData;

  //CurrentLocation constructor
  CurrentLocation(this._stationData);

  //Create state for _CurrentLocation, calls _CurrentLocation constructor
  @override
  _CurrentLocation createState() => _CurrentLocation(this._stationData);
}

class _CurrentLocation extends State<CurrentLocation> {
  List _stationData = [];
  List<Marker> _markers = [];
  LatLng _initialPosition = LatLng(34.0522, -118.2437);
  GoogleMapController _controller;
  Location _location = Location();

  //_CurrentLocation constructor
  _CurrentLocation(this._stationData);

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
  void initState(){
    super.initState();
    for(int i = 0; i < this._stationData.length; i++){
      _markers.add(Marker(
        markerId: MarkerId(this._stationData[i]['properties']['addressStreet']),
        draggable: false,
        position: LatLng(this._stationData[i]['properties']['latitude'], this._stationData[i]['properties']['longitude']),
      ));
    }
    // _markers.add(Marker(
    //     markerId: MarkerId('testMarker'),
    //     draggable: false,
    //     position: LatLng(34.0485, -118.25854)
    // ));
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
            markers: Set.from(_markers),
          ),
        ],
      ),
    );
  }
}