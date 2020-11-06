import 'dart:developer';

import 'package:appoyo_flutter/controllers/map_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:appoyo_flutter/widgets/map_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:latlong/latlong.dart';

import 'package:geolocator/geolocator.dart';

class RequestPage extends StatelessWidget {

  TextEditingController _txtProblemaTitulo = new TextEditingController();
  TextEditingController _txtProblemaDesc = new TextEditingController();
  TextEditingController _txtPago = new TextEditingController();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore store = FirebaseFirestore.instance;

  List<dynamic> arreglo = [];
  bool hayDatos = false;

  LatLng pos;

  @override
  Widget build(BuildContext context) {

    final argAux = Get.arguments;
    hayDatos = argAux != null;
    arreglo = hayDatos ? argAux : [];    

    return GetBuilder(
      init: MapInputController(),
      builder:(_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Appoyo", style: TextStyle(color: Colors.white)),
          leading: IconButton( 
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          )
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Pedir Appoyo", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 30),
                _titleInput(),
                SizedBox(height: 20),
                _detailInput(),
                SizedBox(height: 20),
                _paymentInput(context),
                SizedBox(height: 20),
                _mapInput(_)
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check, color: Colors.white, size: 35),
          elevation: 20,
          onPressed: () => {
            _postRequest(_txtProblemaTitulo.text, _txtProblemaDesc.text, int.parse(_txtPago.text), _.position)
          },
        ),
      ),
    );
  }

  Widget _titleInput(){
    return TextField(
      controller: _txtProblemaTitulo,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: hayDatos ? arreglo[0] : "¿Cuál es tu problema?",
      ),
      enabled: !hayDatos,
    );
  }

  Widget _detailInput(){
    return TextField(
      controller: _txtProblemaDesc,
      maxLines: 7,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText:  hayDatos ? arreglo[1] :"Describe tu problema..."
      ),
      enabled: !hayDatos,
    );
  }

  Widget _paymentInput(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Pago sugerido", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Spacer(),
        Text("\$  ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
        Container(
          width: 80,
          child: TextField(
            controller: _txtPago,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: hayDatos ? arreglo[2].toString() : "0.00"
            ),
            enabled: !hayDatos
          )
        )        
      ],
    );
  }

  Widget _mapInput(MapInputController map){
    return Container(
      child: ClipRRect(
        child: MapWidget(mapInputController: map),
        borderRadius: BorderRadius.circular(45),
      ),
      height: 150
    );
  }

  _postRequest(String titulo, String descripcion, num pago, LatLng position) async {
    print(titulo);
    print(descripcion);
    print(pago);
    print("${position.latitude}, ${position.longitude}");

    await store.collection('requestappoyos').add({
      'titulo': titulo,
      'descripcion': descripcion,
      'pagoSugerido': pago,
      'fechaRequest': new DateTime.now().toString(),
      'lat': position.latitude, 
      'lon': position.longitude
    })
    .then((value) {
      Get.snackbar("¡Listo!", "Se publicó tu solicitud");
      Get.back();
      print("Request de appoyo publicado");
    })
    .catchError((error) => {
      print("Jodido, algo esta mal: $error")
    });
  }
}