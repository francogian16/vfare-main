// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/passenger/payment_confirmation.dart';
import 'package:my_vfare_app/responsive.dart';

class TypePay extends StatefulWidget {
  String time;
  String? alTime;
  String date;
  String route;
  String destination;
  String busName;
  String busID;
  String seatID;
  String? conductor;
  String? driver;
  String? idNum;
  String? label;
  int amount;
  int value;
  String? type;
  TypePay(
      {this.alTime,
      this.idNum,
      this.label,
      required this.value,
      required this.time,
      required this.date,
      required this.route,
      required this.destination,
      required this.busName,
      required this.busID,
      required this.seatID,
      this.conductor,
      this.driver,
      required this.amount,
      this.type});

  @override
  _TypePay createState() => _TypePay();
}

class _TypePay extends State<TypePay> {
  String error = '';
  String? id;
  String idNum = '';
  int docId = 0;
  String? label;
  String mobileNum = '';
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController idNumTEC = TextEditingController();
  TextEditingController labelTEC = TextEditingController();
  bool discount = false;
  final listID = ["Regular", "Discounted"];
  final listType = ["Student", "Senior Citizen", "PWD"];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setNum();
    super.initState();
  }

  setNum() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snap) {
      setState(() {
        mobileNum = snap.value['mobile number'];
      });
    });
    await FirebaseDatabase.instance
        .reference()
        .child('Student Request')
        .once()
        .then((DataSnapshot snap) {
      setState(() {
        docId = snap.value['value'];
        docId++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Scan and Pay'),
          backgroundColor: Color(0xFF263238),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
                constraints: BoxConstraints(maxWidth: 650, maxHeight: 550),
                margin: EdgeInsets.all(Responsive.isMobile(context) ? 15 : 45),
                height: size.height * .8,
                width: size.width * 1,
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Row(
                            children: [
                              Text('Type', style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Container(
                                width: 180,
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Select Type"),
                                  validator: (value) => value == null
                                      ? 'This field is required!'
                                      : null,
                                  value: id,
                                  items: listID.map(buildMenuItem_5).toList(),
                                  onChanged: (value) => setState(() {
                                    id = value;
                                    if (id != 'Regular') {
                                      discount = true;
                                    } else {
                                      discount = false;
                                    }
                                  }),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Responsive.isMobile(context)
                                          ? 16
                                          : 16),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                )),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              )
                            ],
                          ),
                        ),
                        id == 'Discounted'
                            ? Center(
                                child: Text(
                                  'Please show your valid ID to the Bus Conductor',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              )
                            : SizedBox(),
                        id == 'Discounted'
                            ? Center(
                                child: Text(
                                  'and fill in the form below.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              )
                            : SizedBox(),
                        id == 'Discounted'
                            ? Container(
                                constraints: BoxConstraints(maxWidth: 600),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 16),
                                  child: TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'This field is required!'
                                        : null,
                                    controller: idNumTEC,
                                    onChanged: (val) {
                                      setState(() => idNum = val);
                                    },
                                    decoration: InputDecoration(
                                      hintText: '123456789',
                                      labelText: 'Enter ID No.',
                                      labelStyle: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 18,
                                          color: Colors.black),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(13.5),
                                        child: Text(
                                          'ID Number',
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18,
                                              color: Colors.black),
                                        ),
                                      ),
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        id == 'Discounted'
                            ? /*Container(
                                constraints: BoxConstraints(maxWidth: 600),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 16),
                                  child: TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'This field is required!'
                                        : null,
                                    controller: labelTEC,
                                    onChanged: (val) {
                                      setState(() => label = val);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'School',
                                      labelText: 'Enter Label',
                                      labelStyle: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 18,
                                          color: Colors.black),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(13.5),
                                        child: Text(
                                          'School',
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 16
                                                      : 18,
                                              color: Colors.black),
                                        ),
                                      ),
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              )*/
                            Container(
                                constraints: BoxConstraints(maxWidth: 400),
                                child: Row(
                                  children: [
                                    Text('ID Type',
                                        style: TextStyle(fontSize: 16)),
                                    Spacer(),
                                    Container(
                                      width: 180,
                                      child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
                                        decoration: InputDecoration.collapsed(
                                            hintText: "Select ID Type"),
                                        validator: (value) => value == null
                                            ? 'This field is required!'
                                            : null,
                                        value: label,
                                        items: listType
                                            .map(buildMenuItem_5)
                                            .toList(),
                                        onChanged: (value) => setState(() {
                                          label = value;
                                        }),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 16),
                                        icon: Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                      )),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: size.height * .1,
                        ),
                        Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber[600],
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (id == 'Regular') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PaymentConfirmation(
                                            discount: discount,
                                            value: 0,
                                            time: widget.time,
                                            date: widget.date,
                                            alTime: widget.alTime,
                                            route: widget.route,
                                            destination: widget.destination,
                                            busName: widget.busName,
                                            busID: widget.busID,
                                            seatID: widget.seatID,
                                            driver: widget.driver,
                                            conductor: widget.conductor,
                                            amount: widget.amount,
                                            type: widget.type,
                                            label: 'Regular',
                                          )));
                                } else {
                                  try {
                                    await FirebaseDatabase.instance
                                        .reference()
                                        .child('ID Number')
                                        .child(idNum)
                                        .get()
                                        .then((DataSnapshot snapshot) {
                                      if (snapshot.value['id number'] ==
                                              idNum &&
                                          snapshot.value['type'] == label) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    PaymentConfirmation(
                                                      discount: true,
                                                      value: 0,
                                                      time: widget.time,
                                                      date: widget.date,
                                                      alTime: widget.alTime,
                                                      route: widget.route,
                                                      label: label,
                                                      idNum: idNum,
                                                      destination:
                                                          widget.destination,
                                                      busName: widget.busName,
                                                      busID: widget.busID,
                                                      seatID: widget.seatID,
                                                      driver: widget.driver,
                                                      conductor:
                                                          widget.conductor,
                                                      amount: widget.amount,
                                                      type: widget.type,
                                                    )));
                                      }
                                    });
                                  } catch (e) {
                                    await FirebaseFirestore.instance
                                        .collection(widget.busName)
                                        .doc('Holder')
                                        .collection('Bus')
                                        .doc(widget.busID)
                                        .collection('Student Requests')
                                        .doc(docId.toString())
                                        .set({
                                      'timestamp': DateTime.now(),
                                      'time': widget.time,
                                      'date': widget.date,
                                      'alTime': widget.alTime,
                                      'route': widget.route,
                                      'destination': widget.destination,
                                      'busName': widget.busName,
                                      'busID': widget.busID,
                                      'seatID': widget.seatID,
                                      'driver': widget.driver,
                                      'conductor': widget.conductor,
                                      'amount': widget.amount,
                                      'type': widget.type,
                                      'status': false,
                                      'check': true,
                                      'mobile num': mobileNum,
                                      'label': label,
                                      'id num': idNum,
                                      'doc id': docId
                                    });

                                    await FirebaseDatabase.instance
                                        .reference()
                                        .child('Student Request')
                                        .set({'value': docId});

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
                                                    maxWidth: 800,
                                                    maxHeight: 650),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white),
                                                width: size.width * .95,
                                                height: size.height * .3,
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Please wait confirmation from the bus conductor.',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 14
                                                                : 24),
                                                      ),
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Responsive
                                                                        .isMobile(
                                                                            context)
                                                                    ? 16
                                                                    : 24)),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Colors.amber[600],
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      100,
                                                                  vertical: 5),
                                                        ))
                                                  ],
                                                )),
                                          );
                                        });
                                  }
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
                                            : 18)),
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
                                                          '1. You must select a type. Regular if you are not a Student, PWD, or Senior Citizen. Discounted if you are one.',
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
                                                        '2. If Regular, you may proceed to Payment Confirmation and pay right away. If Discounted, you must show your ID to the Bus Conductor, and input your ID Number and ID Type on the form that will be shown to you.',
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
                                                Row(
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 700),
                                                      width: size.width * .8,
                                                      child: Text(
                                                        '3. If you are a PWD or Senior Citizen and your ID is registered in the system, clicking Continue will redirect you to Payment Confirmation. If not, you will need to wait the confirmation from the bus conductor.',
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
                                                Row(
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 700),
                                                      width: size.width * .8,
                                                      child: Text(
                                                        '4. Approved Confirmation can be seen upon clicking the Menu Bar in your Dashboard and clicking the Payment Requests module.',
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

  DropdownMenuItem<String> buildMenuItem_5(String listID) => DropdownMenuItem(
        value: listID,
        child: Text(listID, style: TextStyle(color: Colors.black)),
      );
}
