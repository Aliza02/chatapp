import 'package:chatapp/auth_method.dart';
import 'package:chatapp/chat.dart';
import 'package:chatapp/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  // final FirebaseFirestore store = FirebaseFirestore.instance;
  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');
  // Map<String, dynamic>? userMap = {};

  String chatroomid(String user1, String user2) {
    if (user1.hashCode <= user2.hashCode) {
      return '$user1-$user2';
    } else {
      return '$user2-$user1';
    }
    // print(user1[0].toLowerCase().codeUnits[0]);
    // print(user2[0].toLowerCase().codeUnits[0]);
    // if (user1[0].toLowerCase().codeUnits[0] >
    //     user2.toLowerCase().codeUnits[0]) {
    // return "$user1$user2";
    // } else {
    //   return "$user2$user1";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("homepage"),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Signout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => login())));
                }),
          ],
        ),
        body: StreamBuilder(
          stream: user.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              print('snapshot');
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentsnapshot =
                        streamSnapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // print('kl');
                        String name = documentsnapshot['name'];
                        String roomid =
                            chatroomid(auth.currentUser!.displayName!, name);
                        // print(roomid);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chatroom(
                                      chatroomId: roomid,
                                      Name: name,
                                    )));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(documentsnapshot['name']),
                          subtitle: Text(documentsnapshot['email']),
                        ),
                      ),
                    );
                  });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
