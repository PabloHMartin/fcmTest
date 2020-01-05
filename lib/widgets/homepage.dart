// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        final snackbar = SnackBar(
          content: Text(message['notification']['title']),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _fcm.subscribeToTopic('puppies');
              },
              color: Colors.lightGreen,
              child: Text('HORA VALLE'),
            ),
            RaisedButton(
              onPressed: () {
                _fcm.unsubscribeFromTopic('puppies');
              },
              color: Colors.lightGreen,
              child: Text('HORA PICO'),
            )
          ],
        ),
      ),
    );
  }
}
