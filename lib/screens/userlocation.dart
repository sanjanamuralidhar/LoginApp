import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {

  UserLocation({
    Key key,
  }) : super(key: key);

  @override
  _UserLocationState createState() {
    return _UserLocationState();
  }
}

class _UserLocationState extends State<UserLocation> {
  
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Position _currentPosition;
    List<Address> addresses;
    Address first;

  @override
  void initState() {
    _onLoadMap();
    super.initState();
  }


  CameraPosition initPosition ;
  ///On load map
  void _onLoadMap() async {
     await Future.delayed(Duration(seconds: 1));
     _currentPosition = await Geolocator.getCurrentPosition();
      final coordinates = new Coordinates(_currentPosition.latitude,_currentPosition.longitude);
log(coordinates.toString());

addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
setState(() {
      first = addresses.first;
    });
    final MarkerId markerId = MarkerId(_currentPosition.altitude.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(_currentPosition.latitude,_currentPosition.longitude),
      infoWindow: InfoWindow(title: first.thoroughfare),
      onTap: () {},
    );
// print(widget.location.id.toString());
    setState(() {
      initPosition = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 14.4746,
      );
      _markers[markerId] = marker;
    });
  }


  @override
  Widget build(BuildContext context) {
   Position pos = _currentPosition == null? null: _currentPosition;
   if(pos == null){
      return Scaffold(
         appBar: AppBar(
        centerTitle: true,
        title: Text('location',
        ),
      ),
              body: Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
    ),
      );
   }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('location',
        ),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition:CameraPosition(
                  target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                zoom:14.4746),
          markers: Set<Marker>.of(_markers.values),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          circles: Set.from([Circle( circleId: CircleId('currentCircle'),
      center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      radius: 10000,
          fillColor: Colors.blue.shade100.withOpacity(0.5),
          strokeColor:  Colors.blue.shade100.withOpacity(0.1),
    ),],),
        ),
      ),
    );
  }
 
}

