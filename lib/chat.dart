import 'package:chatapp/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class chatroom extends StatefulWidget {
  chatroom({super.key, required this.chatroomId, required this.Name});
  String chatroomId;
  String Name;

  @override
  State<chatroom> createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  final TextEditingController _message = TextEditingController();

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": auth.currentUser!.displayName,
        "message": _message.text,
        "time": DateTime.now(),
      };

      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatroomId)
          .collection('chats')
          .add(messages);

      _message.clear();
      print('sms snd');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Type some message")),
      );
    }
  }

  Widget message(Size size, Map<String, dynamic> map) {
    Timestamp tm = map['time'];

    return Container(
        width: size.width,
        alignment: map['sendby'] == auth.currentUser!.displayName!
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: map['sendby'] == auth.currentUser!.displayName!
            ? SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tm.toDate().day.toString() +
                          ":" +
                          tm.toDate().month.toString()),
                      Text(tm.toDate().hour.toString() +
                          ":" +
                          tm.toDate().minute.toString()),
                      Text(
                        map['message'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orangeAccent,
                ),
                child: Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(widget.Name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.25,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chatroom')
                        .doc(widget.chatroomId)
                        .collection('chats')
                        .orderBy("time", descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapShot) {
                      if (snapShot.data != null) {
                        return ListView.builder(
                            itemCount: snapShot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> map =
                                  snapShot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              return message(MediaQuery.of(context).size, map);
                            });
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              // margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              width: 350.0,
              height: 100.0,
              child: TextField(
                controller: _message,
                decoration: InputDecoration(
                  hintText: "Type your message",
                ),
              ),
            ),
            Container(
                child: IconButton(
              onPressed: onSendMessage,
              icon: Icon(Icons.send),
            ))
          ]),
        ),
      ),
    );
  }
}
