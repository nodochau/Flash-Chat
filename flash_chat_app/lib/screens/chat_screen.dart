import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User logedinUser;
bool backgroundColor = true;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late String messageText;
  String dropdownItem = '';
  var myItems = ['dark', 'light'];
  final messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      logedinUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Row(
            children: [
              DropdownButton<String>(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.red,
                  ),
                  //value: dropdowItem,
                  items: myItems.map((String myItems) {
                    return DropdownMenuItem(
                      value: myItems,
                      child: Text(myItems),
                    );
                  }).toList(),
                  onChanged: (String? newItem) {
                    setState(() {
                      dropdownItem = newItem!;
                      if (dropdownItem == 'dark') {
                        backgroundColor = true;
                      } else {
                        backgroundColor = false;
                      }
                    });
                  }),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    //getStreamMessages();
                    //getMessages();
                    //log out
                    _auth.signOut();
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
              // IconButton(
              //     onPressed: () {

              //     },
              //     icon: const Icon(Icons.settings_outlined)),
            ],
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              senderTextColor: backgroundColor,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageController.clear();
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': logedinUser.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MessageStream extends StatelessWidget {
  final bool senderTextColor;
  const MessageStream({Key? key, required this.senderTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          List<MessageBubble> messageBubbles = [];
          final messages = snapshot.data?.docs;
          final currentUser = logedinUser.email;

          for (var message in messages!) {
            // final messageData = message;
            final messageText = message['text'];
            final messageSender = message['sender'];
            if (currentUser == messageSender) {
              // this statement is replaced by isMe: currentUser == messageSender,
            }
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
              isbackgroundDark: senderTextColor,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe, isbackgroundDark;

  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
    required this.isMe,
    required this.isbackgroundDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,

        children: [
          Text(
            sender,
            style: TextStyle(
                fontSize: 10.0,
                color: isbackgroundDark ? Colors.white : Colors.black),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.limeAccent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.black : Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
