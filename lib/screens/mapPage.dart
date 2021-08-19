import 'package:LoginApp/screens/userlocation.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: SafeArea(child: Center(
        child: InkWell(
          onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserLocation()),
                    );
            print('pressed');
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.blue),
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Show My Current Location',style: TextStyle(color: Colors.white),),
            )))
      ))
    );
  }
}