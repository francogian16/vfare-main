// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/responsive.dart';

class SendFeedback extends StatefulWidget {
  @override
  _Feedback createState() => _Feedback();
}

bool _rateOne = true;
bool _rateTwo = false;
bool _rateThree = false;
bool _rateFour = false;
bool _rateFive = false;
int rating = 5;

class _Feedback extends State<SendFeedback> {
  final _formKey = GlobalKey<FormState>();
  String feedback = '';
  TextEditingController myFeedback = TextEditingController();
  int quantity = 0;
  int total = 0;
  double average = 0;
  String error = '';

  @override
  void initState() {
    _getTotalRating();
    super.initState();
  }

  _getTotalRating() {
    FirebaseDatabase.instance
        .reference()
        .child('Rating')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        quantity = snapshot.value['quantity'];
        total = snapshot.value['total'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Send Feedback'),
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              constraints:
                  BoxConstraints(maxHeight: 250, minHeight: 200, maxWidth: 800),
              height: size.height * .2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'How was your experience with us?',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 18),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: myFeedback,
                        onChanged: (val) {
                          setState(() => feedback = val);
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'This field is required!' : null,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: "What can we improve?",
                            hintStyle: TextStyle(
                                color: Colors.black87.withOpacity(0.5),
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        maxLines: 2,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 20 : 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Rate your experience',
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 20 : 22,
                    color: Colors.amber[600]),
              ),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 10 : 20,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              width: size.width * .9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: ratingOne,
                    child: Icon(
                      Icons.sentiment_very_satisfied,
                      color: _rateOne ? Colors.amber[600] : Colors.white,
                      size: Responsive.isMobile(context) ? 55 : 65,
                    ),
                  ),
                  GestureDetector(
                    onTap: ratingTwo,
                    child: Icon(
                      Icons.sentiment_satisfied,
                      color: _rateTwo ? Colors.amber[600] : Colors.white,
                      size: Responsive.isMobile(context) ? 55 : 65,
                    ),
                  ),
                  GestureDetector(
                    onTap: ratingThree,
                    child: Icon(
                      Icons.sentiment_neutral,
                      color: _rateThree ? Colors.amber[600] : Colors.white,
                      size: Responsive.isMobile(context) ? 55 : 65,
                    ),
                  ),
                  GestureDetector(
                    onTap: ratingFour,
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      color: _rateFour ? Colors.amber[600] : Colors.white,
                      size: Responsive.isMobile(context) ? 55 : 65,
                    ),
                  ),
                  GestureDetector(
                    onTap: ratingFive,
                    child: Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: _rateFive ? Colors.amber[600] : Colors.white,
                      size: Responsive.isMobile(context) ? 55 : 65,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.amber[600],
                  onTap: () {
                    if (_rateOne == false &&
                        _rateTwo == false &&
                        _rateThree == false &&
                        _rateFour == false &&
                        _rateFive == false) {
                      setState(() {
                        error = 'Please rate your experience!';
                      });
                    } else {
                      setState(() {
                        error = '';
                      });
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          quantity++;
                          total += rating;
                          average = total / quantity;
                          FirebaseDatabase.instance
                              .reference()
                              .child('Rating')
                              .set({
                            'total': total,
                            'quantity': quantity,
                            'average': average
                          });
                        });
                        final data = {
                          'feedback': feedback,
                          'rating': rating,
                          'timestamp': DateTime.now()
                        };
                        FirebaseFirestore.instance
                            .collection('Feedback')
                            .add(data);

                        myFeedback.clear();
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
                                        maxWidth: 650, maxHeight: 650),
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
                                              'Thank you for your feedback! ',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16),
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
                                        Center(
                                          child: Text(
                                              'Your response have been submitted!.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 16)),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          Passenger()));
                                            },
                                            child: Text('Done',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 16
                                                            : 16)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber[600],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100, vertical: 5),
                                            ))
                                      ],
                                    )),
                              );
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
                      child: Text('Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 16),
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
                          Animation animation, Animation secondaryAnimation) {
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
                                      'What to do in this module?',
                                      style: TextStyle(
                                          color: Colors.black45,
                                          decoration: TextDecoration.none,
                                          fontSize: Responsive.isMobile(context)
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
                                            constraints:
                                                BoxConstraints(maxWidth: 700),
                                            width: size.width * .8,
                                            child: Text(
                                              '1. This module is where you can send your feedback and rating of vFare web application.',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: Responsive.isMobile(
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
                                            '2. You can type your feedback on the white text box containing a title of How was your experience with us?.',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                                            '3. A rating is required when sending the feedback. You can click any of the 5 faces shown. The one that you clicked is highlighted by color yellow.',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                  child: Text('Need help?',
                      style: TextStyle(
                          color: Colors.yellow[600],
                          fontSize: Responsive.isMobile(context) ? 14 : 18))),
            ),
          ],
        ),
      ),
    );
  }

  void ratingOne() {
    setState(() {
      rating = 5;
      _rateOne = !_rateOne;
      _rateTwo = false;
      _rateThree = false;
      _rateFour = false;
      _rateFive = false;
    });
  }

  void ratingTwo() {
    setState(() {
      rating = 4;
      _rateTwo = !_rateTwo;
      _rateOne = false;
      _rateThree = false;
      _rateFour = false;
      _rateFive = false;
    });
  }

  void ratingThree() {
    setState(() {
      rating = 3;
      _rateThree = !_rateThree;
      _rateTwo = false;
      _rateOne = false;
      _rateFour = false;
      _rateFive = false;
    });
  }

  void ratingFour() {
    setState(() {
      rating = 2;
      _rateFour = !_rateFour;
      _rateTwo = false;
      _rateThree = false;
      _rateOne = false;
      _rateFive = false;
    });
  }

  void ratingFive() {
    setState(() {
      rating = 1;
      _rateFive = !_rateFive;
      _rateTwo = false;
      _rateThree = false;
      _rateFour = false;
      _rateOne = false;
    });
  }
}
