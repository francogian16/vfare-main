// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'responsive.dart';

class LoginTwo extends StatefulWidget {
  String mobileNum;

  LoginTwo({required this.mobileNum});
  @override
  _LoginTwo createState() => _LoginTwo();
}

class _LoginTwo extends State<LoginTwo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeTEC = TextEditingController();
  String code = '';
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
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: 150, maxWidth: 600),
                      height: size.height * .2,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Enter the code that was',
                              style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 15 : 17,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'sent to your mobile number.',
                              style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 15 : 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 16),
                            child: TextFormField(
                              validator: (val) => val!.length < 6
                                  ? 'Enter a valid code!'
                                  : null,
                              controller: codeTEC,
                              onChanged: (val) {
                                setState(() => code = val);
                              },
                              decoration: InputDecoration(
                                hintText: '123456',
                                labelText: 'Enter Code',
                                labelStyle: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(13.5),
                                  child: Text(
                                    'Code',
                                    style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 16
                                            : 18,
                                        color: Colors.black),
                                  ),
                                ),
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(8),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.amber[600],
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            error = '';
                          });
                          try {
                            await auth.loginCode(
                              widget.mobileNum,
                              code,
                            );
                            setState(() {
                              error = '';
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Passenger()));
                          } catch (e) {
                            await auth.getCode(widget.mobileNum);
                            setState(() {
                              error = 'Invalid code!';
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
                          child: Text('Login',
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
