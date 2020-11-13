import 'dart:developer';
import 'dart:math';

import 'package:appoyo_flutter/controllers/map_controller.dart';
import 'package:appoyo_flutter/pages/request_page.dart';
import 'package:appoyo_flutter/widgets/map_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                            leading: CircleAvatar(
                              radius: 25,                              
                              backgroundImage: NetworkImage("https://scontent.fcyw1-1.fna.fbcdn.net/v/t1.0-9/89015809_495765844423812_7664341119345360896_o.jpg?_nc_cat=102&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeEE7y78I8tGmEr6189SM9Ao8tHHqkqD-xjy0ceqSoP7GM8OGgIpOGNPMhfeg_rW4zCipoIayiRfs0z_RxZsuz6R&_nc_ohc=xHiRPhNGXJcAX9nmJrc&_nc_ht=scontent.fcyw1-1.fna&oh=78c1695c58b76c8f4942f96a2af93bc3&oe=5FD32A4D"),
                            ),
                            title: Text(snapshot.data.documents[index]['titulo']),
                            subtitle: Text('${_calculateDistance(snapshot.data.documents[index]['lat'], snapshot.data.documents[index]['lon'], _.position.latitude, _.position.longitude)} km \n ${_getTimePassed(snapshot.data.documents[index]['fechaRequest'])}'),
                            onTap: () {
                              final titulo = snapshot.data.documents[index]['titulo'];
                              final descripcion = snapshot.data.documents[index]['descripcion'];
                              final pagoSugerido = snapshot.data.documents[index]['pagoSugerido'];
                              final lon = snapshot.data.documents[index]['lon'];
                              final lat = snapshot.data.documents[index]['lat'];
                              final fechaRequest = snapshot.data.documents[index]['fechaRequest'];
                              Get.to(RequestPage(), arguments: [ titulo, descripcion, pagoSugerido, lon, lat, fechaRequest ]);
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
}