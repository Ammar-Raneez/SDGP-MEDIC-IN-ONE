import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/GoogleUserSignInDetails.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/chatbot_message_bubble.dart';
import 'package:ui/constants.dart';

final _firestore = FirebaseFirestore.instance;

var loggedInUserEP;
var loggedInUserGoogle;

class ChatBotScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "chatBotScreen";

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  //used to clear the text field upon send
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Dio dio = new Dio();
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
//    messageStream();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        loggedInUserEP = user.email;
        print(loggedInUserEP);
      } else {
        // This will fire when user logs in using the Google Authentication way
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
        print(loggedInUserGoogle);
      }
    } catch (e) {
      print(e);
    }
  }

  //listen to real time updates in firestore database
//  void messageStream() async {
//    await for (var snapshot
//        in _firestore.collection("chatbot-messages").snapshots()) {
//      for (var message in snapshot.docs) {
//        print(message.data());
//      }
//    }
//  }

  // CREATING AN ALERT
  createAlertDialog(
      BuildContext context, String title, String message, int status) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertWidget(
          title: title,
          message: message,
          status: status,
        );
      },
    );
  }

  void handleSendMessage() async {
    messageTextController.clear();
    _firestore.collection("chatbot-messages").add({
      'text': messageText,
      'sender': loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle,
      'timestamp': Timestamp.now(),
    });

    //send data to chat bot api and get back response
    try {
      Response response = await dio.post(
          'http://127.0.0.1:5000/chatbot-predict',
          data: messageText
      );
      print(response);
    } catch (e) {
      // Displaying alert to the user
      createAlertDialog(context, "Error", e.message, 404);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MessageStream(),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      messageText = value;
                    },
                    controller: messageTextController,
                    decoration: kTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    messageTextController.clear();
                    _firestore.collection("chatbot-messages").add({
                      'text': messageText,
                      'sender': loggedInUserEP != null
                          ? loggedInUserEP
                          : loggedInUserGoogle,
                      'timestamp': Timestamp.now(),
                    });
                    //send data to chat bot api and get back response
                    try {
                      Response response = await dio.post(
                          'http://192.168.8.100/chatbot-predict',
                          data: {
                            'UserIn': messageText
                          });
                      print(response);
                    } catch (e) {
                      // Displaying alert to the user
                      createAlertDialog(context, "Error", e.message, 404);
                    }
                  },
                  child: Text(
                    'POST',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create a stream builder
    //that rebuilds itself on each change of query snapshot
    //in other words, the code is rebuilt whenever there's a change in the
    //firestore database
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("chatbot-messages")
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        //while fetching display a spinner
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        //order it based on most recent text
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];

          //get the current user
          final currentUser =
              loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle;

          final messageBubble = MessageBubble(
            messageSender: messageSender,
            messageText: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}