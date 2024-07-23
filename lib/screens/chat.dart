import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat_messages.dart';
import 'package:flutter_chat_app/widgets/new_messages.dart';

final _firebase = FirebaseAuth.instance;

class ChatScreen extends StatelessWidget{
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("FlutterChat"),
      actions: [IconButton(onPressed: (){_firebase.signOut();}, icon: Icon(Icons.logout))],),
      body: Column(
        children: [
          Expanded(
          child:ChatMessages()
          ),
          NewMessage()
        ],
      )
    );
  }

}