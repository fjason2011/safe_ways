import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    setMarkers();
    super.initState();
    // _markers.add(Marker(
    //     markerId: MarkerId('testMarker'),
    //     draggable: false,
    //     position: LatLng(34.0485, -118.25854)
    // ));
  }

  void setMarkers(){
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
    final Uint8List markerIcon = await getBytesFromAsset('assets/bikemarker.png', 100);

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