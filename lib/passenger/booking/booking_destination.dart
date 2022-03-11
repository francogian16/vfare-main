// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/booking/booking_seat.dart';
import 'package:my_vfare_app/responsive.dart';

class BookingDestination extends StatefulWidget {
  String terminal;
  String company;
  String route;
  String date;
  String busID;
  String time;
  String plateNo;
  String driver;
  String conductor;

  BookingDestination(
      {required this.terminal,
      required this.company,
      required this.route,
      required this.time,
      required this.date,
      required this.plateNo,
      required this.driver,
      required this.conductor,
      required this.busID});
  @override
  _BookingDestination createState() => _BookingDestination();
}

class _BookingDestination extends State<BookingDestination> {
  final _formKey = GlobalKey<FormState>();
  String? destination;

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
                  margin:
                      EdgeInsets.all(Responsive.isMobile(context) ? 15 : 50),
                  width: size.width * 1,
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Center(
                        child: Text(
                          'Please select your destination.',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                .collection(widget.company)
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
                                        style: TextStyle(color: Colors.black)),
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
                        height: size.height * .1,
                      ),
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber[600],
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print('${widget.busID} - ${widget.date}');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => BookingSeat(
                                      terminal: widget.terminal,
                                      company: widget.company,
                                      route: widget.route,
                                      time: widget.time,
                                      date: widget.date,
                                      busID: widget.busID,
                                      destination: destination!
                                          .substring(0, 3)
                                          .toString(),
                                      driver: widget.driver,
                                      conductor: widget.conductor,
                                      plateNo: widget.plateNo)));
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
                      )
                    ]),
                  ))),
        ));
  }

  DropdownMenuItem<String> buildMenuItem_3(String listDestination) =>
      DropdownMenuItem(
        value: listDestination,
        child: Text(listDestination, style: TextStyle(color: Colors.black)),
      );
}
