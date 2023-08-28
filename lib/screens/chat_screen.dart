

import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'ChatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  var messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
     0,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
  @override
  Widget build(BuildContext context) {
  var email =ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
        builder: ( context, snaphot) {

          if (snaphot.hasData)
            {
             List<Message> messagesList=[];
             for(int i = 0 ; i<snaphot.data!.docs.length;i++ ){
               messagesList.add(Message.fromJson(snaphot.data!.docs[i]));
             }
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: kPrimaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          kLogo,
                          height: 50.0,
                        ),
                        Text('Chat'),
                      ],
                    ),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (BuildContext context, index) => messagesList[index].id ==email? ChatBubble(message: messagesList[index],):
                          ChatBubbleForFriend(message: messagesList[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: messageController,
                          onSubmitted: (value) {
                            messages.add({
                              kMessage: value,
                              kCreatedAt:DateTime.now(),
                              'id':email,
                            });
                            messageController.clear();
                            _scrollDown();
                          },
                          decoration: InputDecoration(
                            hintText: "send message",
                            suffixIcon: Icon(Icons.send),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                );
            }
          else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
