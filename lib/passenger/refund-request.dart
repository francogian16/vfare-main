// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/responsive.dart';

class RefundRequest extends StatefulWidget {
  String mobileNum;
  RefundRequest({required this.mobileNum});
  @override
  State<RefundRequest> createState() => _RefundRequest();
}

class _RefundRequest extends State<RefundRequest> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Refund Request');

  User? user = FirebaseAuth.instance.currentUser;
  String mobileNum = ' ';

  @override
  void initState() {
    print(widget.mobileNum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF263238),
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Approved Refund Requests'),
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
                      StreamBuilder(
                        stream: dbCollection
                            .doc('Holder')
                            .collection('Requests')
                            .where('mobile number', isEqualTo: widget.mobileNum)
                            .where('status', isEqualTo: true)
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
                                    'There are no approved refund requests as of the moment.',
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
                                    return RefundRequestDetails(
                                      activity: e.get('activity'),
                                      name: e.get('route'),
                                      label: e.get('company'),
                                      date: e.get('date'),
                                      amount: e.get('amount'),
                                      time: e.get('time'),
                                      ref_no: e.get('reference number'),
                                      mobileNum: widget.mobileNum,
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
                                                  '1. This module contains the List of your Approved Refund Requests.',
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
                                                '2. You can view the details of the refund by click any of the rows that you can see.',
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
                                                '3. Upon clicking a row, a dialog box will appear that will show you the details of the refund.',
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

class RefundRequestDetails extends StatelessWidget {
  const RefundRequestDetails({
    Key? key,
    required this.activity,
    required this.name,
    required this.label,
    required this.date,
    required this.amount,
    required this.time,
    required this.ref_no,
    required this.mobileNum,
  }) : super(key: key);

  final String activity;
  final String name;
  final String label;
  final String date;
  final int amount;
  final String time;
  final int ref_no;
  final String mobileNum;

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
                        'REFUND SUCCESSFUL',
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 16 : 18),
                      ),
                      Text(
                        activity,
                        style: TextStyle(
                            color: Colors.black45,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 14 : 16),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                            fontSize: Responsive.isMobile(context) ? 19 : 21),
                      ),
                      Text(
                        label,
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
                          Text(date,
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
                          Text(time,
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
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(context);
                          },
                          child: Text('Done',
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
            );
          }),
      child: Container(
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 120),
          padding:
              EdgeInsets.only(left: size.width * .05, right: size.width * .05),
          height: size.height * .125,
          width: size.width * 1,
          child: Column(
            children: [
              Row(
                children: [
                  Text(activity,
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                          color: Colors.black45)),
                  Spacer(),
                  Text(date,
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
                  Text(name,
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
                Text(label,
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12 : 14,
                        color: Colors.black54)),
                Spacer(),
                Text(time,
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
