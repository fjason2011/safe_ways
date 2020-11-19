import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  List<Location> _searchLocations = [];
  Position _currentPosition;
  List<Marker> _markers = [];
  GoogleMapController _mapController;
  String _searchQuery;

  //_CurrentLocation constructor
  _CurrentLocation(this._stationData);

  @override
  void initState(){
    _getCurrentLocation();
    _setMarkers();
    super.initState();
  }

  void _setMarkers(){
    for(int i = 0; i < this._stationData.length; i++){
      _addMarker(this._stationData[i]['properties']);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<void> _addMarker(object) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/bikemarker.png', 150);

    // creating a new MARKER
    final Marker marker = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId:  MarkerId(object['addressStreet']),
      position: LatLng(object['latitude'], object['longitude']),
      infoWindow: InfoWindow(
          title: object['addressStreet'],
          snippet: 'Metro Bikes Left: ${object['bikesAvailable']}'
      ),
    );

    setState(() {
      // adding a new marker to set
      _markers.add(marker);
    });
  }

  void _onMapCreated(controller){
    setState(() {
      _mapController = controller;
    });
  }

  void _searchAndNavigate() async{
    _searchLocations = await locationFromAddress(_searchQuery);
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_searchLocations[0].latitude, _searchLocations[0].longitude),
          zoom: 25.0
        )
      )
    );

    /* UNHIGHLIGHT TO ENABLE MARKER SEARCH LOCATION
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('${_searchLocations[0].timestamp}'),
          position:  LatLng(_searchLocations[0].latitude, _searchLocations[0].longitude)
        )
      );
    });*/
  }

  void _getCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15.0,
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: Set.from(_markers),
            mapType: MapType.normal,
          ),
          Positioned(
              top: 55.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                  width:  double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color:  Colors.white
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top:15.0),
                    suffixIcon:  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _searchAndNavigate,
                      iconSize:  30.0,
                    )
                  ),
                  onChanged: (value){
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}