
import 'package:flutter/material.dart';
import 'package:scolar_chat/models/message_model.dart';

import '../constants.dart';

class customChatBubble extends StatelessWidget {
    customChatBubble({required this.message});

  final MessageModel message ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 20,right: 20,bottom: 20),
        margin: const EdgeInsets.symmetric( horizontal: 16,vertical: 8),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child:  Text(message.message,style: const TextStyle(color: Colors.white), ),
      ),
    );
  }
}


class customChatBubbleForeFriend extends StatelessWidget {
  customChatBubbleForeFriend({ required this.message});

  final MessageModel message ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 20,right: 20,bottom: 20),
        margin: const EdgeInsets.symmetric( horizontal: 16,vertical: 8),
        decoration:const BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child:  Text(message.message,style: const TextStyle(color: Colors.white), ),
      ),
    );
  }
}