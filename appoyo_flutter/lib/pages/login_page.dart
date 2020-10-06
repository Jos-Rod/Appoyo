import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.black,
            flexibleSpace: Container(
              padding: EdgeInsets.all(15.0),
              child: Text("Appoyo", style: TextStyle(fontSize: 50, color: Colors.white)),
              alignment: Alignment.bottomLeft
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            background(),
            Column(
              children: <Widget>[
                loginFields(),
                Expanded(child: Container()),           
                loginButtons()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginFields(){
    return Padding(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 150,
            width: 150,
          ),
          SizedBox(height: 50.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Correo"
            ),
          ),
          SizedBox(height: 35.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Contraseña"
            ),
          )
        ],
      ),
    );
  }

  Widget loginButtons(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: ButtonTheme(            
            height: 80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0)),
            ),
            child: RaisedButton(
              color: Colors.white,
              child: Text("Regsitrate", style: TextStyle(fontSize: 18)),
              onPressed: () {},
            ),
          ),
        ),
        ButtonTheme(
          height: 130.0,
          minWidth: 130.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0)),
          ),
          child: RaisedButton(
            color: Color(0xFFD500).withAlpha(255),
            child: Icon(Icons.arrow_forward, color: Colors.white, size: 60,),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget background(){
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xFFF957).withAlpha(100),
          ),
        )
      ],
    );
  }
}