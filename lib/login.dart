// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/login-2.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'responsive.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String mobileNum = '';
  TextEditingController mobileNumTEC = TextEditingController();
  bool checkPhone = false;
  String error = '';
  final AuthClass auth = AuthClass();
  String checkRole = '';

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
              Image.asset(
                'assets/icons/2.png',
                height: Responsive.isMobile(context) ? 100 : 150,
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: 400, maxWidth: 500, minHeight: 300),
                width: size.width * .9,
                height: size.height * .4,
                child: Column(
                  children: [
                    Spacer(),
                    Text('Login as Passenger',
                        style: TextStyle(
                            color: Colors.amber[600],
                            fontWeight: FontWeight.w400,
                            fontSize: Responsive.isMobile(context) ? 16 : 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 350),
                      padding: EdgeInsets.only(left: 10),
                      width: size.width * .8,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                        child: TextFormField(
                          validator: (val) => val!.length < 11
                              ? 'Enter a valid mobile number!'
                              : null,
                          controller: mobileNumTEC,
                          onChanged: (val) {
                            setState(() => mobileNum = val);
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter 11 Digit Mobile Number',
                              labelStyle: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18,
                                  color: Colors.black),
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(8),
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.amber[600],
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (mobileNum.substring(0, 2) == '09') {
                            try {
                              await FirebaseDatabase.instance
                                  .reference()
                                  .child('Phone Numbers')
                                  .child(mobileNum)
                                  .once()
                                  .then((DataSnapshot snapshot) {
                                if (snapshot.value['value'] == mobileNum) {
                                  checkPhone = true;
                                }
                              });
                            } catch (e) {}
                            if (checkPhone) {
                              print('Hey');
                              setState(() {
                                error = '';
                              });
                              try {
                                await auth.getCode(mobileNum.substring(1));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => LoginTwo(
                                          mobileNum: mobileNum.substring(1),
                                        )));
                              } catch (e) {}
                            } else {
                              setState(() {
                                error = 'Phone number does not exist!';
                              });
                            }
                          } else {
                            setState(() {
                              error = 'Invalid phone number!';
                            });
                          }
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
                          child: Text('Get OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 20)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Spacer()
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 16),
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
