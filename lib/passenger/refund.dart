// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/responsive.dart';

class Refund extends StatefulWidget {
  int ref;
  int amount;
  String time;
  String date;
  String activity;
  String route;
  String company;
  String mobileNum;
  String busId;
  String seat;
  String type;

  Refund(
      {required this.seat,
      required this.busId,
      required this.ref,
      required this.amount,
      required this.time,
      required this.date,
      required this.activity,
      required this.route,
      required this.company,
      required this.mobileNum,
      required this.type});

  @override
  _Refund createState() => _Refund();
}

class _Refund extends State<Refund> {
  final _formKey = GlobalKey<FormState>();
  final listReason = [
    "Incorrect Ticket",
    "Wrong Bus",
    "Change of plans for reservation",
    "Others"
  ];
  String? reason;
  TextEditingController controller = TextEditingController();
  String reasonText = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Refund'),
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(40),
                  height: size.height * .6,
                  width: size.width * .975,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 300,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            value: reason,
                            items: listReason.map(buildMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => reason = value),
                            hint: Text("Select Reason"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    Responsive.isMobile(context) ? 15 : 17),
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          )),
                        ),
                        reason == 'Others'
                            ? Container(
                                width: 280,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 16),
                                  child: TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'This field is required!'
                                        : null,
                                    controller: controller,
                                    onChanged: (val) {
                                      setState(() => reasonText = val);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'State reason',
                                      labelStyle: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 15
                                              : 17,
                                          color: Colors.black),

                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (reason != 'Others') {
                                  setState(() {
                                    reasonText = reason!;
                                  });
                                }
                                await FirebaseFirestore.instance
                                    .collection('Passenger')
                                    .doc(widget.mobileNum)
                                    .collection('Transaction')
                                    .doc(widget.ref.toString())
                                    .update({'refund': false});

                                await FirebaseFirestore.instance
                                    .collection(widget.company)
                                    .doc('Holder')
                                    .collection('Refund Request')
                                    .doc('Holder')
                                    .collection('Requests')
                                    .doc(widget.ref.toString())
                                    .set({
                                  'reason': reasonText,
                                  'reference number': widget.ref,
                                  'amount': widget.amount,
                                  'activity': widget.activity,
                                  'time': widget.time,
                                  'date': widget.date,
                                  'route': widget.route,
                                  'company': widget.company,
                                  'mobile number': widget.mobileNum,
                                  'pending': true,
                                  'status': false,
                                  'con': false,
                                  'bus id': widget.busId,
                                  'seat id': widget.seat,
                                  'type': widget.type,
                                  'timestamp': DateTime.now()
                                });

                                await FirebaseFirestore.instance
                                    .collection('Refund Request')
                                    .doc('Holder')
                                    .collection('Requests')
                                    .doc(widget.ref.toString())
                                    .set({
                                  'reason': reasonText,
                                  'reference number': widget.ref,
                                  'amount': widget.amount,
                                  'activity': widget.activity,
                                  'time': widget.time,
                                  'date': widget.date,
                                  'route': widget.route,
                                  'company': widget.company,
                                  'mobile number': widget.mobileNum,
                                  'pending': true,
                                  'status': false,
                                  'con': false,
                                  'bus id': widget.busId,
                                  'seat id': widget.seat,
                                  'type': widget.type,
                                  'timestamp': DateTime.now()
                                });

                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: false,
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
                                                Row(
                                                  children: [
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    Text(
                                                      'Refund request forwarded! ',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 16
                                                              : 18),
                                                    ),
                                                    Image.asset(
                                                        'assets/icons/checked.png',
                                                        height:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 18
                                                                : 20,
                                                        color: Colors.black87),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: Responsive.isMobile(
                                                          context)
                                                      ? 300
                                                      : 400,
                                                  child: Text(
                                                      'Please wait for 1 to 2 working days to process request.',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 14
                                                              : 16)),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop(context);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  Passenger()));
                                                    },
                                                    child: Text('Done',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 16
                                                                : 16)),
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
                                            )),
                                      );
                                    });
                              }
                            },
                            child: Text('Confirm Refund',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Responsive.isMobile(context)
                                        ? 16
                                        : 18)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber[600],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                            ))
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String listReason) => DropdownMenuItem(
        value: listReason,
        child: Text(
          listReason,
          style: TextStyle(color: Colors.black),
        ),
      );
}
