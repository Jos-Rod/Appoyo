import 'dart:developer';
import 'dart:io';

import 'package:appoyo_flutter/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  var profilePic;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
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
              Column(
                children: <Widget>[
                  signUpFields(),
                  Expanded(child: Container()),
                  signUpButtons()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpFields(){ 
    return Padding(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _profilePicture(context),
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
            controller: txtEmail,
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
            controller: txtPassword,
          )
        ],
      ),
    );
  }

  Widget _profilePicture(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 80,
            backgroundImage: profilePic == null ?
            NetworkImage("https://thumbs.dreamstime.com/b/omita-al-avatar-placeholder-de-la-foto-icono-del-perfil-124557887.jpg") :
            FileImage(new File(profilePic)),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext bc){
              return _imageSourcePicker(context);
            }
          );
        }
      ),
    );
  }

  Widget signUpButtons(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Spacer(),
        ButtonTheme(
          height: 80.0,
          minWidth: 80.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0)),
          ),
          child: RaisedButton(
            color: Color(0xFFD500).withAlpha(255),
            child: Icon(Icons.arrow_forward, color: Colors.white, size: 40,),
            onPressed: signUp,
          ),
        )
      ],
    );
  }

  Widget _imageSourcePicker(BuildContext context){
    return Container(
      color: Colors.white,
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Galería'),
            onTap: () async {                      
              Navigator.of(context).pop(); //CLOSE BOTTOM SHEET
              _snackbarPhoto(context, await onAddImage(ImageSource.gallery));
            }
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Cámara'),
            onTap: () async {         
              Navigator.of(context).pop(); //CLOSE BOTTOM SHEET
              _snackbarPhoto(context, await onAddImage(ImageSource.camera));
            }
          ),
        ],
      ),
    );
  }

  _snackbarPhoto(BuildContext context, bool done){
    return done ? 
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("¡Listo! La imagen seleccionada se registrará como logo", style: TextStyle(color: Colors.white, fontSize: 14)),
        backgroundColor: Theme.of(context).accentColor
      )
    ) : 
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("¿Eh? Parece que hubo un error, intenta de nuevo", style: TextStyle(color: Colors.white, fontSize: 14)),
        backgroundColor: Theme.of(context).accentColor
      )
    );
  }

  Future<bool> onAddImage(ImageSource origen) async {
    final picker = ImagePicker();
    var foto = await picker.getImage(
      source: origen
    );

    if( foto != null){
      this.profilePic = foto.path;
      inspect(profilePic);
      setState(() {
        
      });
      return true;
    }
    
    return false;
  }

  signUp() async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

    File file = File(profilePic);

    firebase_storage.UploadTask ref = firebase_storage.FirebaseStorage.instance
    .ref('users/${txtEmail.text}.png')
    .putFile(file);

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPassword.text
      );
      inspect(userCredential);

      //Get.off(HomePage());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }
}