// ignore_for_file: prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/loading.dart';
import 'package:my_vfare_app/login_register.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;

  //int indicate = 0;

  /* @override
  void initState() {
    _getRole();
    super.initState();
  }*/

  /*_getRole() {
    try {
      FirebaseDatabase.instance
          .reference()
          .child('Users')
          .child(user!.uid)
          .child('Profile')
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value['role'] == 'passenger') {
          setState(() {
            indicate = 1;
            print(user!.displayName);
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'vFare',
            theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF263238)),
            home: user == null ? LoginRegister() : Passenger(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}
