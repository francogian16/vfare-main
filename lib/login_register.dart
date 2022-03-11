// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_vfare_app/login.dart';
import 'package:my_vfare_app/main.dart';
import 'package:my_vfare_app/register_one.dart';
import 'responsive.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegister createState() => _LoginRegister();
}

class _LoginRegister extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF263238),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/refresh.png',
              height: Responsive.isMobile(context) ? 20 : 25,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => MyApp()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: Responsive.isMobile(context) ? 3 : 5,
            ),
            Image.asset(
              'assets/icons/2.png',
              height: Responsive.isMobile(context) ? 200 : 250,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.amber[600],
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Register()));
              },
              child: Container(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 60),
                width: size.width * .7,
                height: size.height * .05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber[600]),
                child: Center(
                  child: Text('Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.isMobile(context) ? 16 : 20)),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Login()));
              },
              child: Container(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 60),
                width: size.width * .7,
                height: size.height * .05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Responsive.isMobile(context) ? 16 : 20)),
                ),
              ),
            ),
            Spacer(
              flex: 9,
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF263238),
    );
  }
}
