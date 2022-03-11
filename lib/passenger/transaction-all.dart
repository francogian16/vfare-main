// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, sized_box_for_whitespace, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/refund.dart';
import 'package:my_vfare_app/responsive.dart';

class AllTransactionHistory extends StatefulWidget {
  @override
  State<AllTransactionHistory> createState() => _AllTransactionHistoryState();
}

class _AllTransactionHistoryState extends State<AllTransactionHistory> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Passenger');

  User? user = FirebaseAuth.instance.currentUser;
  String mobileNum = ' ';

  @override
  void initState() {
    _getMobileNumber();

    super.initState();
  }

  _getMobileNumber() {
    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        mobileNum = snapshot.value['mobile number'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF263238),
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Transaction History'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 800, minHeight: 600),
              width: size.width * .975,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: dbCollection
                        .doc(mobileNum)
                        .collection('Transaction')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...snapshot.data!.docs.map((e) {
                                return AllTransactionDetails(
                                  activity: e.get('activity'),
                                  name: e.get('route'),
                                  label: e.get('company'),
                                  date: e.get('date'),
                                  amount: e.get('fare'),
                                  time: e.get('time'),
                                  ref_no: e.get('reference number'),
                                  indicator: e.get('activity'),
                                  refund: e.get('refund'),
                                  id: e.get('bus id'),
                                  seat: e.get('seat id'),
                                  mobileNum: mobileNum,
                                  type: e.get('type'),
                                );
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
          ),
        ),
      ),
    );
  }
}

class AllTransactionDetails extends StatelessWidget {
  const AllTransactionDetails(
      {Key? key,
      required this.id,
      required this.seat,
      required this.activity,
      required this.name,
      required this.label,
      required this.date,
      required this.amount,
      required this.time,
      required this.ref_no,
      required this.mobileNum,
      required this.refund,
      required this.indicator,
      required this.type})
      : super(key: key);

  final String activity;
  final String id;
  final String name;
  final String seat;
  final String label;
  final String date;
  final int amount;
  final String time;
  final int ref_no;
  final String indicator;
  final bool refund;
  final String mobileNum;
  final String type;

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
            return Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 800, maxHeight: 650),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: size.width * .95,
                  height: size.height * .7,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$activity',
                        style: TextStyle(
                            color: Colors.black45,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 14 : 16),
                      ),
                      indicator == 'Purchased from' ||
                              indicator == 'Booked from'
                          ? Text(
                              id,
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 19 : 21),
                            )
                          : SizedBox(),
                      Text(
                        '$name',
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 19 : 21),
                      ),
                      Text(
                        '$label',
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 19 : 21),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                          Container(
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(color: Color(0xFF263238)),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Date',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('$date',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Time',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('$time',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Amount',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('PHP $amount.00',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Reference No.',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('$ref_no',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.none,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      indicator == 'Purchased from' ||
                              indicator == 'Booked from'
                          ? Row(
                              children: <Widget>[
                                Text('Seat ID',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        decoration: TextDecoration.none,
                                        fontSize: Responsive.isMobile(context)
                                            ? 14
                                            : 16)),
                                Spacer(
                                  flex: 5,
                                ),
                                Text(seat,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        decoration: TextDecoration.none,
                                        fontSize: Responsive.isMobile(context)
                                            ? 14
                                            : 16)),
                              ],
                            )
                          : SizedBox(),
                      (indicator == 'Purchased from' ||
                                  indicator == 'Booked from') &&
                              refund == true
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Refund(
                                        busId: id,
                                        mobileNum: mobileNum,
                                        ref: ref_no,
                                        amount: amount,
                                        time: time,
                                        date: date,
                                        activity: activity,
                                        route: name,
                                        company: label,
                                        seat: seat,
                                        type: type)));
                              },
                              child: Text('Refund',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Responsive.isMobile(context)
                                          ? 16
                                          : 16)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber[600],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 5),
                              ))
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context);
                              },
                              child: Text('Done',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Responsive.isMobile(context)
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
          }),
      child: Container(
          constraints: BoxConstraints(maxWidth: 850, maxHeight: 120),
          padding:
              EdgeInsets.only(left: size.width * .05, right: size.width * .05),
          height: size.height * .125,
          width: size.width * 1,
          child: Column(
            children: [
              Row(
                children: [
                  Text("$activity",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                          color: Colors.black45)),
                  Spacer(),
                  Text("$date",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                          color: Colors.black45))
                ],
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Row(
                children: [
                  Text("$name",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 15 : 17,
                          color: Colors.black)),
                  Spacer(),
                  Text("PHP $amount.00",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 15 : 17,
                          color: Colors.black87))
                ],
              ),
              Row(children: [
                Text("$label",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12 : 14,
                        color: Colors.black54)),
                Spacer(),
                Text("$time",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12 : 14,
                        color: Colors.black45))
              ]),
              SizedBox(
                height: size.height * .02,
              ),
            ],
          )),
    );
  }
}
