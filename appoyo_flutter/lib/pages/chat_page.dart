import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  String _messageText = '';
  TextEditingController _messageTxt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Appoyo", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return index.isEven ? _message(text: "Hola amiguito, como estas", recieved: true) : _message(text: "Hola, estoy bien, gracias y tu?", recieved: false);
              }
            )
          ),
          _sendInput()
        ]
      ),
    );
  }

  Widget _message({@required String text, @required bool recieved} ){
    
    final media = MediaQuery.of(context).size;

    return Container(
    alignment: recieved ? Alignment.centerLeft : Alignment.centerRight,
    child: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: media.width * .8),
          decoration: BoxDecoration(
            color: recieved ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: recieved ? Radius.circular(20.0) : Radius.circular(0.0),
              bottomLeft: recieved ? Radius.circular(0.0) : Radius.circular(20.0),
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15.0), textAlign: TextAlign.justify,),
          ),
        ),
      ),
    );
  }

  Widget _sendInput(){//BuildContext context, String chatID, String currentUserId){

    OutlineInputBorder inputStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.0
      ),
      borderRadius: BorderRadius.all(Radius.circular(12.0))
    );

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: _messageTxt,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10.0),
                  enabledBorder: inputStyle,
                  disabledBorder: inputStyle,
                  focusedBorder: inputStyle,
                  hintText: 'Escriba su mensaje',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColorLight)
                ),
                onTap: (){
                  
                },
                onChanged: (value) => setState(() {
                  _messageText = value;
                })
              ),
            ),
            _sendButton()//chatID, currentUserId)
          ],
        ),
      ),
    );
  }

  Widget _sendButton(){//String chatID, String currentUserId){
    return IconButton(
      icon: Icon(Icons.send, color: Theme.of(context).primaryColor,),
      onPressed: () => {},
    );
  }
}