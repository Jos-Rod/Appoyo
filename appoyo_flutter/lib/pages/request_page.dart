import 'package:flutter/material.dart';
import 'package:appoyo_flutter/widgets/map_widget.dart';
import 'package:get/get.dart';

class RequestPage extends StatelessWidget {

  TextEditingController _txtProblemaTitulo = new TextEditingController();
  TextEditingController _txtProblemaDesc = new TextEditingController();
  TextEditingController _txtPago = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _mapInput()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Colors.white, size: 35),
        elevation: 20,
        onPressed: () => {
          
        },
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
        hintText: "¿Cuál es tu problema?"
      )
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
        hintText: "Describe tu problema..."
      )
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
              hintText: "0.00"
            )
          )
        )        
      ],
    );
  }

  Widget _mapInput(){
    return Container(
      child: ClipRRect(
        child: MapWidget(),
        borderRadius: BorderRadius.circular(45),
      ),
      height: 150
    );
  }
}