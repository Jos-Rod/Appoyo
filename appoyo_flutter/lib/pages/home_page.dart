import 'dart:developer';

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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Appoyo", style: TextStyle(color: Colors.white)),
      ),
      body: GetBuilder(
        init: MapInputController(),
        builder: (_) => Column(
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
                stream: store.collection('requestappoyos').snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(                  
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                            ),
                            title: Text(snapshot.data.documents[index]['titulo']),
                            subtitle: Text('${snapshot.data.documents[index]['lat']}, ${snapshot.data.documents[index]['lon']} \n ${snapshot.data.documents[index]['fechaRequest']}'),
                          ),
                        ),
                      );
                    }          
                  );
                }
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
}