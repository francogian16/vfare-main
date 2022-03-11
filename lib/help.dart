// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'responsive.dart';

class Help extends StatefulWidget {
  @override
  _Help createState() => _Help();
}

class _Help extends State<Help> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Help Center'),
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 18 : 24,
                        color: Colors.yellow[600]),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .8,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'How to make an account?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '1. Click the Create Account button.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '2. Input your personal information and click Submit.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '3. You can now use your account. However, it is still not yet fully verified.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '4. To fully verify your account, go to your profile and click Register ID.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '5. Select what type of ID you want to register and your date of birth.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '6. Upload a snapshot of your face and a clear picture of your valid ID.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '7. Click Submit and wait 1-2 working days for verification of your account.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('How to make an account?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .4,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Where can I find my profile?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '1. Click the hamburger icon on the top left of your screen.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '2. Click the Profile icon.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('Where can I find my profile?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                              child: Container(
                                  constraints: BoxConstraints(maxWidth: 800),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  width: size.width * .95,
                                  height: size.height * .6,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'How to add credits?',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            decoration: TextDecoration.none,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 18),
                                      ),
                                      Text(
                                        'Through Terminals',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            decoration: TextDecoration.none,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 14
                                                    : 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '1. Go to your nearest Vfare loading station.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              )),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '2. Provide your account number and amount of credits to be added.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '3. Provide payment to the teller.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '4. Check your account to see if credits are successfully received.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(context);
                                          },
                                          child: Text('Done',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.amber[600],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100, vertical: 5),
                                          ))
                                    ],
                                  )),
                            );
                          }),
                      child: Text('How to add credits through terminals? ',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                              child: Container(
                                  constraints: BoxConstraints(maxWidth: 800),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  width: size.width * .95,
                                  height: size.height * .65,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'How to add credits?',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            decoration: TextDecoration.none,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 18),
                                      ),
                                      Text(
                                        'Through Regular Load',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            decoration: TextDecoration.none,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 14
                                                    : 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF263238)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '1. Click Add Money button on your dashboard ans select Regular Load.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              )),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '2. Input your account number and the amount.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '3. You will receive an sms for confirmation. Input it on the Enter code text box.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '4. Confirm details of transaction and check if your account will receive the credits.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(context);
                                          },
                                          child: Text('Done',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.amber[600],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100, vertical: 5),
                                          ))
                                    ],
                                  )),
                            );
                          }),
                      child: Text('How to add credits through regular load? ',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .6,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'How to scan and pay?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '1. Click the Scan icon on your dashboard and allow the app to use your camera.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '2. Scan the QR code found on your seat.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '3. Select all the necessary details and then confirm your payment.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('How to scan and pay?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .5,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'What is a QR Code?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'A QR code is a type of barcode that can be scanned by using a digital device such as cellphones, digital scanners, and such. QR codes are responsible for tracking information about products and services.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 14
                                                      : 16),
                                          textAlign: TextAlign.justify,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('What is a QR Code?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .6,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'How to book a seat?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '1. Press the Book Icon in the Homepage.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '2. Select the necessary details according to your preference.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '3. Double check all the selected details and then Confirm.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '4. The receipt will be displayed. Take a screenshot of the receipt and present it on the day of your booking.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('How to book a seat?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    width: size.width * .95,
                                    height: size.height * .6,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'How to send feedback?',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                            Container(
                                              height: 5,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF263238)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '1. Locate the Send Feedback option by selecting the options button that is on the top left corner of your dashboard.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 14
                                                              : 16),
                                                  textAlign: TextAlign.justify,
                                                )),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '2. A space for your feedback and scale of your experience will be presented.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 700),
                                              width: size.width * .8,
                                              child: Text(
                                                '3. Click “Send Feedback” to proceed.',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 14
                                                            : 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Spacer()
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )));
                          }),
                      child: Text('How to send feedback?',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
