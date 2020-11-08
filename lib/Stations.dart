import 'package:flutter/material.dart';


class Stations extends StatefulWidget{
  List _stationData;
  Stations(List data){
    this._stationData = data;
  }
  @override
  State<StatefulWidget> createState(){
    return _Stations(_stationData);
  }
}
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
class _Stations extends State<Stations>{
  List _stationData;
  _Stations(List data){
    this._stationData = data;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Metro Bike Stations")
      ),
      body: ListView.builder(
        itemCount: _stationData == null ? 0 : _stationData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(195, 195, 195, 1.0),
                  child:
                  Text(
                    '${_stationData[index]['properties']['bikesAvailable']}',
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                ),
                Text('   ${_stationData[index]['properties']['addressStreet']}, ${_stationData[index]['properties']['addressCity']}, ${_stationData[index]['properties']['addressZipCode']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
          );
        },
      )
    );
  }
}