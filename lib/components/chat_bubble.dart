import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({Key? key,required this.message}) : super(key: key);
  final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32),

        margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32) ,
            topRight:Radius.circular(32) ,
            bottomRight:Radius.circular(32) ,
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message!.message,
          style: TextStyle(
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}



class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({Key? key,required this.message}) : super(key: key);
  final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32),

        margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32) ,
            topRight:Radius.circular(32) ,
            bottomLeft:Radius.circular(32) ,
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message!.message,
          style: TextStyle(
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}