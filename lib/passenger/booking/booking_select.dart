// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_vfare_app/loading.dart';
import 'package:my_vfare_app/passenger/booking/booking_destination.dart';
import 'package:my_vfare_app/responsive.dart';

class BookingSelect extends StatefulWidget {
  @override
  _BookingSelectState createState() => _BookingSelectState();
}

class _BookingSelectState extends State<BookingSelect> {
  String? terminal;
  String date = 'Select Date';
  String temp1 = ' ';
  String temp2 = ' ';
  final _formKey = GlobalKey<FormState>();
  late DateTime pickedDate;
  String company = '';
  String conductor = '';
  String driver = '';
  String route = '';
  String plateNo = '';

  _getBusDetails(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('Bus')
          .doc('Holder')
          .collection('Bus List')
          .doc(id)
          .get()
          .then((value) {
        setState(() {
          company = value.get('company');
          conductor = value.get('conductor');
          driver = value.get('driver');
          route = value.get('route');
          plateNo = value.get('plate number');
        });
      });
    } catch (e) {}
  }

  @override
  void initState() {
    pickedDate = DateTime.now();
    super.initState();
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
                      'Please select a terminal and date.',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Terminal',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 18),
                      ),
                      Spacer(),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Booking')
                            .doc('Holder')
                            .collection('Terminal')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<DropdownMenuItem<String>> points = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data!.docs[i];
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
                                    hintText: "Select Terminal"),
                                validator: (value) => value == null
                                    ? 'This field is required!'
                                    : null,
                                value: terminal,
                                items: points,
                                onChanged: (value) => setState(() {
                                  terminal = value!;
                                  temp2 = terminal!;
                                }),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        Responsive.isMobile(context) ? 16 : 18),
                                icon:
                                    Icon(Icons.arrow_drop_down_circle_outlined),
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
                      Text('Date: ',
                          style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 18),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      IconButton(
                          onPressed: _pickDate,
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.black54,
                          ))
                    ],
                  ),
                  /*
                  Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 18),
                      ),
                      Spacer(),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Booking')
                            .doc('Date')
                            .collection(temp2)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<DropdownMenuItem<String>> points = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data!.docs[i];
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
                                    hintText: "Select Date"),
                                validator: (value) => value == null
                                    ? 'This field is required!'
                                    : null,
                                value: date,
                                items: points,
                                onChanged: (value) => setState(() {
                                  date = value!;
                                  temp1 = date!;
                                }),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        Responsive.isMobile(context) ? 16 : 18),
                                icon:
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                              )),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),*/
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Book')
                        .doc(temp2) //terminal
                        .collection(date)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading();
                      }
                      if (snapshot.data!.docs.isEmpty &&
                          (date != 'Select Date' && temp2 != ' ')) {
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                'There no buses available for booking',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Center(
                              child: Text(
                                'in your selected terminal and date.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                'Please select another.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            )
                          ],
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: size.height * .5,
                          width: size.width * .9,
                          child: ListView(children: [
                            ...snapshot.data!.docs.map((e) {
                              String id = e.get('bus id');
                              String date = e.get('date');
                              String time = e.get('time');

                              return ListTile(
                                title: Text(id),
                                subtitle: Text(time),
                                trailing: Icon(Icons.time_to_leave),
                                onTap: () async {
                                  await _getBusDetails(id);
                                  showGeneralDialog(
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
                                              constraints: BoxConstraints(
                                                  maxWidth: 650,
                                                  maxHeight: 650),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                              width: size.width * .8,
                                              height: size.height * .5,
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Date',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(date,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Time',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(time,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Company',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(company,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('BUS ID',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(id,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Route',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(route,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Terminal',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(terminal!,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Plate Number',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(plateNo,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Driver',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(driver,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Conductor',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      Text(conductor,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 14
                                                                  : 16)),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                BookingDestination(
                                                                    terminal:
                                                                        terminal!,
                                                                    company:
                                                                        company,
                                                                    route:
                                                                        route,
                                                                    time: time,
                                                                    date: date,
                                                                    busID: id,
                                                                    driver:
                                                                        driver,
                                                                    conductor:
                                                                        conductor,
                                                                    plateNo:
                                                                        plateNo)));
                                                      },
                                                      child: Text('Proceed',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 16
                                                                  : 16)),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Colors.amber[600],
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 100,
                                                                vertical: 5),
                                                      ))
                                                ],
                                              )),
                                        );
                                      });
                                },
                              );
                            }),
                            SizedBox()
                          ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? date1 = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        //firstDate: DateTime(DateTime.now().day),
        //firstDate: DateTime(DateTime.now().year - 70),
        //lastDate: DateTime(DateTime.now().year + 2));
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));

    if (date1 != null) {
      setState(() {
        pickedDate = date1;
        date = DateFormat.yMMMMd().format(pickedDate);
        print(DateFormat.yMMMMd().format(pickedDate));
      });
    }
  }
}
