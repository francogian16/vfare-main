// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/bus/alps.dart';
import 'package:my_vfare_app/bus/jam.dart';
import 'package:my_vfare_app/bus/rrcg.dart';
import 'package:my_vfare_app/passenger/payment_confirmation.dart';
import 'package:my_vfare_app/responsive.dart';

class BookingSeat extends StatefulWidget {
  String terminal;
  String company;
  String route;
  String destination;
  String date;
  String time;
  String busID;
  String plateNo;
  String driver;
  String conductor;

  BookingSeat(
      {required this.terminal,
      required this.company,
      required this.route,
      required this.time,
      required this.date,
      required this.plateNo,
      required this.driver,
      required this.conductor,
      required this.busID,
      required this.destination});
  @override
  _BookingSeat createState() => _BookingSeat();
}

class _BookingSeat extends State<BookingSeat> {
  final _formKey = GlobalKey<FormState>();

  String? seat;
  int amount = 0;

  @override
  void initState() {
    _getAmount();
    super.initState();
  }

  _getAmount() async {
    await FirebaseFirestore.instance
        .collection(widget.company)
        .doc('Holder')
        .collection('Routes')
        .doc('Amount')
        .collection(widget.route)
        .doc(widget.route.substring(0, 3) + '-' + widget.destination)
        .get()
        .then((value) {
      setState(() {
        amount = value.get('amount');
        print(amount);
      });
    });
    /*
    FirebaseDatabase.instance
        .reference()
        .child('Amount')
        .child(widget.route)
        .child(widget.route.substring(0, 3) + '-' + widget.destination)
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        amount = snapshot.value['amount'];
        print(amount);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Booking'),
          backgroundColor: Color(0xFF263238),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                margin: EdgeInsets.all(Responsive.isMobile(context) ? 15 : 50),
                width: size.width * 1,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Please select your seat.',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Seat',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 18),
                          ),
                          Spacer(),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(widget.company)
                                .doc('Holder')
                                .collection('Bus Booking')
                                .doc('Holder')
                                .collection('${widget.busID} - ${widget.date}')
                                .where('value', isEqualTo: 1)
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
                                        style: TextStyle(color: Colors.black)),
                                    value: snap.id,
                                  ));
                                }
                                return Container(
                                  width: 200,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Select Seat"),
                                    validator: (value) => value == null
                                        ? 'This field is required!'
                                        : null,
                                    value: seat,
                                    items: points,
                                    onChanged: (value) =>
                                        setState(() => seat = value!),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Responsive.isMobile(context)
                                            ? 16
                                            : 18),
                                    icon: Icon(
                                        Icons.arrow_drop_down_circle_outlined),
                                  )),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: Responsive.isMobile(context) ? 20 : 25,
                              width: Responsive.isMobile(context) ? 20 : 25,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent[700]),
                            ),
                          ),
                          Text(
                            ' - Available',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 15,
                                color: Colors.black87),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: Responsive.isMobile(context) ? 20 : 25,
                              width: Responsive.isMobile(context) ? 20 : 25,
                              decoration: BoxDecoration(color: Colors.black87),
                            ),
                          ),
                          Text(
                            ' - Occupied',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 15,
                                color: Colors.black87),
                          ),
                          Spacer()
                        ],
                      ),
                      Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 550),
                          width: size.width * .9,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              widget.company == 'ALPS'
                                  ? AlpsBus(
                                      busID: widget.busID,
                                      date: widget.date,
                                      time: widget.time)
                                  : widget.company == 'JAM'
                                      ? JamBus(
                                          busID: widget.busID,
                                          date: widget.date,
                                          time: widget.time)
                                      : RrcgBus(
                                          busID: widget.busID,
                                          date: widget.date,
                                          time: widget.time),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.amber[600],
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                PaymentConfirmation(
                                                  discount: false,
                                                  value: 1,
                                                  time: widget.time,
                                                  date: widget.date,
                                                  route: widget.route,
                                                  destination:
                                                      widget.destination,
                                                  busName: widget.company,
                                                  busID: widget.busID,
                                                  seatID: seat.toString(),
                                                  driver: widget.driver,
                                                  conductor: widget.conductor,
                                                  plateNo: widget.plateNo,
                                                  amount: amount,
                                                )));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 280, maxHeight: 50),
                                  width: size.width * .7,
                                  height: size.height * .05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.amber[600]),
                                  child: Center(
                                    child: Text('Continue',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
