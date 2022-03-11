// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, empty_catches
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/login_register.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/register_two.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'responsive.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameTEC = TextEditingController();
  TextEditingController lastNameTEC = TextEditingController();
  TextEditingController mobileNumTEC = TextEditingController();
  String mobileNum = '';
  String firstName = '';
  String lastName = '';
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
              constraints: BoxConstraints(maxWidth: 350),
              padding: EdgeInsets.only(left: 10),
              width: size.width * .8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                child: TextFormField(
                  validator: (val) =>
                      val!.length < 11 ? 'Enter a valid mobile number!' : null,
                  controller: mobileNumTEC,
                  onChanged: (val) {
                    setState(() => mobileNum = val);
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter 11 Digit Mobile Number',
                      labelStyle: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 16 : 18,
                          color: Colors.black),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 350),
              padding: EdgeInsets.only(left: 10),
              width: size.width * .8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                child: TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'This field is required!' : null,
                  controller: firstNameTEC,
                  onChanged: (val) {
                    setState(() => firstName = val);
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter First Name',
                      labelStyle: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 16 : 18,
                          color: Colors.black),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 350),
              padding: EdgeInsets.only(left: 10),
              width: size.width * .8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                child: TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'This field is required!' : null,
                  controller: lastNameTEC,
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Last Name',
                      labelStyle: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 16 : 18,
                          color: Colors.black),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none),
                ),
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
                    if (mobileNum.substring(0, 2) == '09') {
                      try {
                        await FirebaseDatabase.instance
                            .reference()
                            .child('Phone Numbers')
                            .child(mobileNum)
                            .once()
                            .then((DataSnapshot snapshot) {
                          if (snapshot.value['value'] == mobileNum) {
                            checkPhone = false;
                          }
                        });
                      } catch (e) {}
                      if (checkPhone) {
                        setState(() {
                          error = '';
                        });
                        try {
                          await auth.getCode(mobileNum.substring(1));

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => RegisterTwo(
                                    mobileNum: mobileNum.substring(1),
                                    firstName: firstName,
                                    lastName: lastName,
                                  )));
                        } catch (e) {}
                      } else {
                        setState(() {
                          error = 'Phone number is already taken!';
                          checkPhone = true;
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
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              height: size.height * .2,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Enter the code that was',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15 : 24,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'sent to your mobile number.',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15 : 24,
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
                                    Responsive.isMobile(context) ? 16 : 24,
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
            ),*/