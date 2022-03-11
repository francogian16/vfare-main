// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/payment_confirmation.dart';
import 'package:my_vfare_app/responsive.dart';

class PaymentRequest extends StatefulWidget {
  String mobileNum;
  PaymentRequest({required this.mobileNum});

  @override
  State<PaymentRequest> createState() => _PaymentRequest();
}

class _PaymentRequest extends State<PaymentRequest> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF263238),
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Approved Discount Requests'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 800, minHeight: 600),
                  width: size.width * .975,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'List of Approved Discount Requests',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Responsive.isMobile(context) ? 16 : 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Passenger')
                            .doc(widget.mobileNum)
                            .collection('Approved Requests')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Center(
                                child: Text(
                                    'There are no approved requests as of the moment.',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        decoration: TextDecoration.none,
                                        fontSize: Responsive.isMobile(context)
                                            ? 14
                                            : 16)),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ...snapshot.data!.docs.map((e) {
                                    return StudentReq(
                                        alTime: e.get('alTime'),
                                        amount: e.get('amount'),
                                        busID: e.get('busID'),
                                        busName: e.get('busName'),
                                        conductor: e.get('conductor'),
                                        driver: e.get('driver'),
                                        destination: e.get('destination'),
                                        route: e.get('route'),
                                        seat: e.get('seatID'),
                                        type: e.get('type'),
                                        date: e.get('date'),
                                        time: e.get('time'),
                                        mobileNum: e.get('mobile num'),
                                        label: e.get('label'),
                                        idNum: e.get('id num'),
                                        docId: e.get('doc id'),
                                        check: e.get('check'));
                                  }),
                                ]);
                          }
                          return SizedBox();
                        },
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                    ],
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
                                                  '1. This module contains the List of your Approved Discount Requests.',
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
                                                '2. Just click the arrow pointing to the right on the row wherein you inputted your ID Number and ID Type.',
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
                                                '3. Upon clicking the arrow, a dialog box will appear that will redirect you to payment confirmation of your transaction.',
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
                      child: Text('Need help?',
                          style: TextStyle(
                              color: Colors.yellow[600],
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 18))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentReq extends StatelessWidget {
  const StudentReq(
      {Key? key,
      required this.alTime,
      required this.amount,
      required this.busID,
      required this.busName,
      required this.conductor,
      required this.check,
      required this.driver,
      required this.date,
      required this.label,
      required this.idNum,
      required this.destination,
      required this.mobileNum,
      required this.route,
      required this.seat,
      required this.time,
      required this.type,
      required this.docId})
      : super(key: key);

  final String alTime;
  final int amount;
  final String label;
  final String idNum;
  final String busID;
  final bool check;
  final String busName;
  final String conductor;
  final String driver;
  final String date;
  final String destination;
  final String mobileNum;
  final String route;
  final String seat;
  final String time;
  final String type;
  final int docId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return (Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 800, maxHeight: 650),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: size.width * .9,
                  height: size.height * .4,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Text('Your discount request has been approved.',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Text('Proceed to Payment Confirmation?',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PaymentConfirmation(
                                      discount: true,
                                      value: 0,
                                      time: time,
                                      date: date,
                                      alTime: alTime,
                                      route: route,
                                      destination: destination,
                                      busName: busName,
                                      busID: busID,
                                      seatID: seat,
                                      driver: driver,
                                      conductor: conductor,
                                      amount: amount,
                                      type: type,
                                      label: label,
                                    )));
                          },
                          child: Text('Proceed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 16)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber[600],
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 5),
                          ))
                    ],
                  )),
            ));
          }),
      child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 120),
          padding:
              EdgeInsets.only(left: size.width * .05, right: size.width * .05),
          height: size.height * .125,
          width: size.width * 1,
          child: Column(
            children: [
              Row(
                children: [
                  Text(idNum,
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 15 : 17,
                          color: Colors.black)),
                  Spacer(),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                    size: Responsive.isMobile(context) ? 30 : 40,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                          color: Colors.black45)),
                  Spacer(),
                ],
              ),
            ],
          )),
    );
  }
}
