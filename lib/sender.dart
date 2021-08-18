import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:device_info/device_info.dart';
class Sender extends StatefulWidget {
  
  const Sender({ Key? key }) : super(key: key);

  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  String id="";
void deviceid() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
setState(() {
  id =androidInfo.androidId;
});}
  void initState(){
    super.initState();
   deviceid();
    Geolocator.getPositionStream(intervalDuration: Duration(seconds: 2)).listen((event) {
     
      currentLocation=event;
      FirebaseFirestore.instance.collection("GeoData").doc(id).collection("live location").doc(DateTime.now().toString()).set({"position": currentLocation.toJson()});
    });
  }
  double lat=0.0;
 double lang=0.0;
late GoogleMapController mapController;
LatLng target=LatLng(0,0);

 CameraPosition _initialPosition = CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 16);
 late Position currentLocation;




  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
    Set<Marker> markers= HashSet<Marker>();
    
  void _printandsetlocation() async {
    
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
print(androidInfo.androidId);
setState(() {
  id= androidInfo.androidId;
});
   var newPosition = CameraPosition(
       target: LatLng(currentLocation.latitude, currentLocation.longitude),
      );

   CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
   CameraUpdate zoom = CameraUpdate.zoomTo(16);
     mapController.moveCamera(update);  
// Timer.periodic(Duration(seconds: 3), (timer) async{
         
       
//      currentLocation = await Geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

//    var newPosition = CameraPosition(
//        target: LatLng(currentLocation.latitude, currentLocation.longitude),
//       );

//    CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
//    CameraUpdate zoom = CameraUpdate.zoomTo(16);
//   FirebaseFirestore.instance.collection("GeoData").doc(androidInfo.androidId.toString()).collection("live location").doc(DateTime.now().toString()).set({"position": currentLocation.toJson()});
//                 // .collection(androidInfo.androidId).doc(DateTime.now().toString()).set({'lat': currentLocation.latitude,'long': currentLocation.longitude});    
                    
//                      setState(() {
//                        lat= currentLocation.latitude;
//                        lang =currentLocation.longitude;
//                      });
//    mapController.moveCamera(update);   
  
//     });
    }
    
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
 
        title: Text("GPS DEMO APP"),
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(id,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        )],
      ),
      body:SafeArea(
          child: Column(
        
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Latitude', style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),), Text(lat.toString(), style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),),Text("longitude", style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),), Text(lang.toString(), style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),)
               , Expanded(
                 child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          
                          child: Card(
                            child:GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: _initialPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                       
                             ),
                          ),
                        ),
                      ),
               ),
            ],
          ),
        ),
     
      floatingActionButton: FloatingActionButton(
        onPressed: _printandsetlocation,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}