// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/discount.dart';
import 'package:my_vfare_app/passenger/payment_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:my_vfare_app/responsive.dart';

class NonP2P extends StatefulWidget {
  String time;
  String date;
  String route;
  String busName;
  String busID;
  String seatID;
  String conductor;
  String driver;
  String type;

  NonP2P(
      {required this.time,
      required this.date,
      required this.route,
      required this.busName,
      required this.busID,
      required this.seatID,
      required this.conductor,
      required this.driver,
      required this.type});
  @override
  _NonP2P createState() => _NonP2P();
}

class _NonP2P extends State<NonP2P> {
  final _formKey = GlobalKey<FormState>();
  String? destination;
  String? currentLoc;
  int amount = 0;
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('${widget.busName} Bus'),
          backgroundColor: Color(0xFF263238),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 500),
                margin: EdgeInsets.all(Responsive.isMobile(context) ? 15 : 30),
                height: size.height * .6,
                width: size.width * 1,
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                            Spacer(),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(widget.busName)
                                  .doc('Holder')
                                  .collection('Routes')
                                  .doc('Starting Point')
                                  .collection(widget.route)
                                  .where('indicator', isEqualTo: 0)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> points = [];
                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    DocumentSnapshot snap =
                                        snapshot.data!.docs[i];
                                    points.add(DropdownMenuItem(
                                      child: Text(snap.id,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      value: snap.id,
                                    ));
                                  }
                                  return Container(
                                    width: 250,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Select Start"),
                                      validator: (value) => value == null
                                          ? 'This field is required!'
                                          : null,
                                      value: currentLoc,
                                      items: points,
                                      onChanged: (value) =>
                                          setState(() => currentLoc = value!),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 16),
                                      icon: Icon(Icons
                                          .arrow_drop_down_circle_outlined),
                                    )),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                            Spacer(),
                            Text(
                              widget.time,
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                            Spacer(),
                            Text(
                              widget.date,
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Destination',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18),
                            ),
                            Spacer(),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(widget.busName)
                                  .doc('Holder')
                                  .collection('Routes')
                                  .doc('Destination Point')
                                  .collection(widget.route)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> points = [];
                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    DocumentSnapshot snap =
                                        snapshot.data!.docs[i];
                                    points.add(DropdownMenuItem(
                                      child: Text(snap.id,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      value: snap.id,
                                    ));
                                  }
                                  return Container(
                                    width: 250,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Select Destination"),
                                      validator: (value) => value == null
                                          ? 'This field is required!'
                                          : null,
                                      value: destination,
                                      items: points,
                                      onChanged: (value) =>
                                          setState(() => destination = value!),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 16),
                                      icon: Icon(Icons
                                          .arrow_drop_down_circle_outlined),
                                    )),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .1,
                        ),
                        Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber[600],
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (currentLoc.toString() !=
                                    destination.toString()) {
                                  await FirebaseFirestore.instance
                                      .collection(widget.busName)
                                      .doc('Holder')
                                      .collection('Routes')
                                      .doc('Amount')
                                      .collection(widget.route)
                                      .doc(currentLoc
                                              .toString()
                                              .substring(0, 3) +
                                          '-' +
                                          destination
                                              .toString()
                                              .substring(0, 3))
                                      .get()
                                      .then((value) {
                                    setState(() {
                                      amount = value.get('amount');
                                      print(amount);
                                    });
                                  });

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => TypePay(
                                            alTime: DateFormat.H()
                                                .format(DateTime.now()),
                                            time: widget.time,
                                            date: widget.date,
                                            route: widget.route,
                                            destination: destination
                                                .toString()
                                                .substring(0, 3),
                                            busName: widget.busName,
                                            busID: widget.busID,
                                            seatID: widget.seatID,
                                            conductor: widget.conductor,
                                            driver: widget.driver,
                                            amount: amount,
                                            value: 0,
                                            type: widget.type,
                                          )));
                                } else {
                                  setState(() {
                                    error =
                                        'Starting Point and Destination Point cannot be the same!';
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
                                child: Text('Continue',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Responsive.isMobile(context)
                                            ? 16
                                            : 16)),
                              ),
                            ),
                          ),
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
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  barrierColor: Colors.black45,
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  pageBuilder: (BuildContext buildContext,
                                      Animation animation,
                                      Animation secondaryAnimation) {
                                    return Center(
                                        child: Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 800),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
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
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 16
                                                              : 18),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
                                                    ),
                                                    Container(
                                                      height: 5,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF263238)),
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
                                                            BoxConstraints(
                                                                maxWidth: 700),
                                                        width: size.width * .8,
                                                        child: Text(
                                                          '1. You must select your point of origin as well as your destination point then click Continue button.',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                    Spacer()
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 700),
                                                      width: size.width * .8,
                                                      child: Text(
                                                        '2. It will redirect you to another page wherein you will select if you are a Regular or Discounted Passenger.',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 14
                                                                : 16),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                    Spacer()
                                                  ],
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop(context);
                                                    },
                                                    child: Text('Done',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16)),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.amber[600],
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 100,
                                                              vertical: 5),
                                                    ))
                                              ],
                                            )));
                                  }),
                              child: Text('Need help?',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 18))),
                        ),
                      ]),
                )),
          ),
        ));
  }
}
