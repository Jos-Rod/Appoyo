import 'package:appoyo_flutter/pages/request_page.dart';
import 'package:appoyo_flutter/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Appoyo", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
            child: Stack(
              children: [
                MapWidget(),
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
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return Card(                  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                      ),
                      title: Text('Se me poncho la llanta'),
                      subtitle: Text('A 800m \nHace 5 minutos'),
                      
                    ),
                  ),
                );
              }          
            ),
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white, size: 35),
        elevation: 20,
        onPressed: () => Get.to(RequestPage()),
      ),
    );
  }
}