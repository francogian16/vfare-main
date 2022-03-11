// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, empty_catches
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/login_register.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'responsive.dart';

class RegisterTwo extends StatefulWidget {
  String? firstName;
  String? lastName;
  String mobileNum;

  RegisterTwo({this.firstName, this.lastName, required this.mobileNum});

  @override
  _RegisterTwo createState() => _RegisterTwo();
}

class _RegisterTwo extends State<RegisterTwo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeTEC = TextEditingController();
  String code = '';
  String error = '';
  final AuthClass auth = AuthClass();
  bool checkPhone = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Color(0xFF263238),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150, maxWidth: 600),
              height: size.height * .2,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Enter the code that was',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15 : 17,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'sent to your mobile number.',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15 : 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextFormField(
                      validator: (val) =>
                          val!.length < 6 ? 'Enter a valid code!' : null,
                      controller: codeTEC,
                      onChanged: (val) {
                        setState(() => code = val);
                      },
                      decoration: InputDecoration(
                        hintText: '123456',
                        labelText: 'Enter Code',
                        labelStyle:
                            TextStyle(fontSize: 16, color: Colors.black),
                        border: OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(13.5),
                          child: Text(
                            'Code',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 18,
                                color: Colors.black),
                          ),
                        ),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(8),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.amber[600],
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      error = '';
                    });
                    try {
                      await auth.verifyCode(widget.mobileNum, code,
                          widget.firstName!, widget.lastName!, context);

                      showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                              child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 800, maxHeight: 650),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  width: size.width * .95,
                                  height: size.height * .3,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Text(
                                            'Account created successfully! ',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 16
                                                        : 18),
                                          ),
                                          Image.asset(
                                              'assets/icons/checked.png',
                                              height:
                                                  Responsive.isMobile(context)
                                                      ? 18
                                                      : 20,
                                              color: Colors.black87),
                                          Spacer(
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                      Container(
                                          width: Responsive.isMobile(context)
                                              ? 300
                                              : 400,
                                          child: Text(
                                              'You may now login your account.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16))),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        Passenger()));
                                          },
                                          child: Text('Done',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 16
                                                      : 18)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.amber[600],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100, vertical: 5),
                                          ))
                                    ],
                                  )),
                            );
                          });
                    } catch (e) {
                      await auth.getCode(widget.mobileNum);
                      setState(() {
                        error = 'Invalid code!';
                      });
                    }
                  }
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: 280, maxHeight: 50),
                  width: size.width * .7,
                  height: size.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600]),
                  child: Center(
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.isMobile(context) ? 16 : 16)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            Spacer(
              flex: 9,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
/*
            */