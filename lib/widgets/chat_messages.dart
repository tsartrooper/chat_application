import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_app/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget{
  const ChatMessages({super.key});

  void _deleteChat(String doc){
    FirebaseFirestore.instance.collection("chats").doc(doc).delete();
  }

  @override
  Widget build(BuildContext context){
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    final chats = FirebaseFirestore.instance.collection("chats").get();

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chats").orderBy(
          "createdAt",
          descending: true
        ).snapshots(),
        builder: (ctx, chatSnapshots){
          if(chatSnapshots.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          if(!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty){
            return const Center(
              child: Text("No messages.")
            );
          }
          if(chatSnapshots.hasError){
            return const Center(
              child: Text("Something went wrong")
            );
          }
          final loadedMessages = chatSnapshots.data!.docs;

          return ListView.builder(
            reverse: true,
              itemCount: loadedMessages.length,
              itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index+1 < loadedMessages.length
                                    ? loadedMessages[index+1].data()
                                    : null;
            final currentMessageUserId = chatMessage["userId"];
            final NextMessageUserId =
            nextChatMessage != null
            ? nextChatMessage["userId"] : null;
            final nextUserIsSame = NextMessageUserId == currentMessageUserId;
            if(nextUserIsSame) {
              return GestureDetector(
                onDoubleTap: (){
                  if(authenticatedUser.uid == currentMessageUserId){
                    _deleteChat(loadedMessages[index].id);
                  }},
                child: MessageBubble.next(
                    message: chatMessage["text"],
                    isMe: authenticatedUser.uid == currentMessageUserId),
              );
            }
              else{
                return GestureDetector(
                  onDoubleTap: (){
                    if(authenticatedUser.uid == currentMessageUserId){
                      _deleteChat(loadedMessages[index].id);
                    }},
                    child: MessageBubble.first(
                  userImage: chatMessage["userImage"],
                  username: chatMessage["username"],
                  message: chatMessage["text"],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                )
                );
            }
            }
            );
        }
    );
  }


}