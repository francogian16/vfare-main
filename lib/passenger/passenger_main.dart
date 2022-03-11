// ignore_for_file: use_key_in_widget_constructors

import 'body.dart';
import 'sidebar.dart';
import 'package:flutter/material.dart';

class Passenger extends StatefulWidget {
  @override
  _Passenger createState() => _Passenger();
}

class _Passenger extends State<Passenger> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        //toolbarHeight: size.height * .085,
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Image.asset('assets/icons/1.png', height: size.height * .05),
        elevation: 0,
      ),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      toolbarHeight: size.height * .085,
      backgroundColor: Colors.yellow[600],
      centerTitle: true,
      title: Image.asset('assets/icons/1.png', height: size.height * .05),
      elevation: 0,
    );
  }
}
