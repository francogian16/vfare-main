// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/login_register.dart';
import 'responsive.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTEC = TextEditingController();
  String email = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF263238),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Image.asset(
                'assets/icons/2.png',
                height: Responsive.isMobile(context) ? 200 : 300,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: 500, maxHeight: 400, minHeight: 300),
                width: size.width * .9,
                height: size.height * .4,
                child: Column(
                  children: [
                    Spacer(),
                    Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 18 : 24),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        'Enter your email.',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 24,
                            color: Colors.black45),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .7,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 16),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a valid email!' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          controller: emailTEC,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelStyle: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 24,
                                color: Colors.black),

                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.amber[600],
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          emailTEC.clear();
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierLabel: MaterialLocalizations.of(context)
                                  .modalBarrierDismissLabel,
                              barrierColor: Colors.black45,
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              pageBuilder: (BuildContext buildContext,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return Center(
                                  child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 800, maxHeight: 650),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      width: size.width * .95,
                                      height: size.height * .3,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Please check your email.',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 24),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            LoginRegister()));
                                              },
                                              child: Text('Done',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 16
                                                              : 24)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.amber[600],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 100,
                                                    vertical: 5),
                                              ))
                                        ],
                                      )),
                                );
                              });
                        }
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 280, maxHeight: 50),
                        width: size.width * .7,
                        height: size.height * .05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber[600]),
                        child: Center(
                          child: Text('Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 24)),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              Spacer(
                flex: 20,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF263238),
    );
  }
}
