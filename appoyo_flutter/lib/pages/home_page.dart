import 'dart:developer';
import 'dart:math';

import 'package:appoyo_flutter/controllers/map_controller.dart';
import 'package:appoyo_flutter/pages/chat_page.dart';
import 'package:appoyo_flutter/pages/request_page.dart';
import 'package:appoyo_flutter/widgets/map_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' hide Coords;

import 'package:latlong/latlong.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:map_launcher/map_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    
    FirebaseFirestore store = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Appoyo", style: TextStyle(color: Colors.white)),
        actions: [
          FutureBuilder(
            future: getUserImage(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data)
              );
            }
          )
        ],
      ),
      body: GetBuilder(
        init: MapInputController(),
        builder: (_) => 
        Column(
          children: [
            Container(
              height: 200,
              color: Colors.grey,
              child: Stack(
                children: [
                  MapWidget(mapInputController: _),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text("Estás aquí:", style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: store.collection('requestappoyos').orderBy("fechaRequest", descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Algo salió mal'));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                 
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(                  
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            leading: FutureBuilder(
                              future: getUserImage(user: snapshot.data.documents[index]['user']),
                              builder: (BuildContext context, AsyncSnapshot<String> snap){
                                return CircleAvatar(
                                  radius: 25,                              
                                  backgroundImage: NetworkImage(snap.data),
                                );
                              }
                            ),
                            title: Text(snapshot.data.documents[index]['titulo']),
                            subtitle: Text('${_calculateDistance(snapshot.data.documents[index]['lat'], snapshot.data.documents[index]['lon'], _.position?.latitude ?? 0, _.position?.longitude ?? 0)} km \n ${_getTimePassed(snapshot.data.documents[index]['fechaRequest'])}'),
                            onTap: () {                              
                              LatLng pos = LatLng(snapshot.data.documents[index]['lat'], snapshot.data.documents[index]['lon']);

                              Get.dialog(
                                Center(
                                  child: Wrap(
                                    children: [
                                      Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: Column(
                                          children: [
                                            Container( //? TITULO
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22)),
                                                color: Get.theme.primaryColor,
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 10.0),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text("Appoyo", style: TextStyle(color: Colors.white, fontSize: 22.0)),
                                            ),
                                            Container( //? CONTENIDO
                                              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 30.0),
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  Text(snapshot.data.documents[index]['titulo'], style: TextStyle(fontSize: 24.0)),
                                                  SizedBox(height: 15),
                                                  Text(snapshot.data.documents[index]['descripcion'], style: TextStyle(fontSize: 16.0)),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(45),
                                                      child: FlutterMap(
                                                        options: new MapOptions(
                                                          center: pos,
                                                          zoom: 13.0,
                                                        ),
                                                        layers: [
                                                          new TileLayerOptions(
                                                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                            subdomains: ['a', 'b', 'c']
                                                          ),
                                                          new MarkerLayerOptions(
                                                            markers: [
                                                              new Marker(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                point: pos,
                                                                builder: (ctx) =>
                                                                new Container(
                                                                  child: Icon(Icons.location_on, size: 50),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )                                   
                                            ),
                                            Container( //? BOTONES
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(22), bottomLeft: Radius.circular(22)),
                                                color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ButtonTheme(
                                                      height: 50,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22)),
                                                      ),
                                                      buttonColor: Get.theme.primaryColorDark,
                                                      child: RaisedButton(
                                                        child: Text("Cancelar", style: TextStyle(color: Colors.white)),
                                                        onPressed: () => Get.back()
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ButtonTheme(
                                                      height: 50,
                                                      buttonColor: Get.theme.primaryColorDark,
                                                      child: RaisedButton(
                                                        child: Text("Abrir Mapa", style: TextStyle(color: Colors.white)),
                                                        onPressed: () => openMap(snapshot.data.documents[index]['lat'], snapshot.data.documents[index]['lon'])
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ButtonTheme(
                                                      height: 50,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(22)),
                                                      ),
                                                      buttonColor: Get.theme.accentColor,
                                                      child: RaisedButton(
                                                        child: Text("Contactar", style: TextStyle(color: Colors.white)),
                                                        onPressed: () {
                                                          Get.back();
                                                          Get.to(ChatPage());
                                                        },                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            },
                          ),
                        ),
                      );
                    }         
                  );                  
                },
              ),
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white, size: 35),
        elevation: 20,
        onPressed: () => Get.to(RequestPage()),
      ),
    );
  }

  String _getTimePassed(String date){
    DateTime requestDate = DateTime.parse(date);
    Duration difference = DateTime.now().difference(requestDate);

    String texto = "";

    if(difference.inMinutes < 60){
      texto = "Hace ${difference.inMinutes} minutos";
    }
    else if(difference.inHours < 24){
      texto = "Hace ${difference.inHours} horas";
    }
    else if(difference.inDays < 30){
      texto = "Hace ${difference.inDays} días";
    }
    else
    {
      texto = "Hace ${difference.inDays / 30} meses";
    }

    return texto;
  }

  int _calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return (12742 * asin(sqrt(a))).round();
  }

  Future<String> getUserImage({String user}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    var email = user != null ? user : auth.currentUser.email;

    String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('users/${email}.png')
      .getDownloadURL();

    return downloadURL;
  }

  void openMap(double lat, double lon) async {

    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(lat, lon),
      title: "Appoyo",
    );
  }
}