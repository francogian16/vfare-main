// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/responsive.dart';
import 'package:my_vfare_app/services/database.dart';
import 'package:intl/intl.dart';

class BookingTicket extends StatefulWidget {
  String time;
  String date;
  String route;
  String destination;
  String busName;
  String busID;
  String seatID;
  int amount;
  int number;
  int credits;
  String mobileNum;
  String plateNo;
  String driver;
  String conductor;
  String type;
  String name;
  int ref;
  bool? check;
  BookingTicket(
      {required this.time,
      required this.date,
      required this.route,
      required this.name,
      required this.destination,
      required this.busName,
      required this.busID,
      required this.seatID,
      required this.amount,
      required this.number,
      required this.credits,
      required this.plateNo,
      this.check,
      required this.type,
      required this.conductor,
      required this.driver,
      required this.ref,
      required this.mobileNum});
  @override
  _BookingTicket createState() => _BookingTicket();
}

class _BookingTicket extends State<BookingTicket> {
  User? user = FirebaseAuth.instance.currentUser;
  int credits = 0;
  int current = 0;
  int revenue = 0;

  @override
  void initState() {
    setSeat();
    saveTicket();
    myCredits();
    _busTripActivity();
    _passengerPerformanceMonthly();
    _passengerPerformanceYearly();
    _passengerTypeActivity();
    super.initState();
  }

  _busTripActivity() async {
    int p2p = 0;
    int n2p = 0;
    int book = 0;

    if (widget.type == 'P2P') {
      setState(() {
        p2p = 1;
      });
    } else if (widget.type == 'N2P') {
      setState(() {
        n2p = 1;
      });
    } else {
      setState(() {
        book = 1;
      });
    }

    try {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Bus Trip Activity')
          .doc('Holder')
          .collection(widget.route)
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .get()
          .then((value) async {
        setState(() {
          p2p = value.get('p2p') + p2p;
          n2p = value.get('n2p') + n2p;
          book = value.get('book') + book;
        });

        await FirebaseFirestore.instance
            .collection(widget.busName)
            .doc('Holder')
            .collection('Analytics')
            .doc('Holder')
            .collection('Bus Trip Activity')
            .doc('Holder')
            .collection(widget.route)
            .doc(DateFormat.y().format(DateTime.now()) +
                ' - ' +
                DateFormat.MMMM().format(DateTime.now()))
            .update({'p2p': p2p, 'n2p': n2p, 'book': book});
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Bus Trip Activity')
          .doc('Holder')
          .collection(widget.route)
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .set({'p2p': p2p, 'n2p': n2p, 'book': book});
    }
  }

  _passengerTypeActivity() async {
    int Rp2p = 0;
    int Rn2p = 0;
    int Rbook = 0;
    int Dp2p = 0;
    int Dn2p = 0;
    int Dbook = 0;

    if (widget.check == true) {
      if (widget.type == 'P2P') {
        setState(() {
          Dp2p = 1;
        });
      } else if (widget.type == 'N2P') {
        setState(() {
          Dn2p = 1;
        });
      } else {
        setState(() {
          Dbook = 1;
        });
      }
    } else {
      if (widget.type == 'P2P') {
        setState(() {
          Rp2p = 1;
        });
      } else if (widget.type == 'N2P') {
        setState(() {
          Rn2p = 1;
        });
      } else {
        setState(() {
          Rbook = 1;
        });
      }
    }

    try {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Type Activity')
          .doc('Holder')
          .collection('Discounted')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .get()
          .then((value) async {
        setState(() {
          Dp2p = value.get('p2p') + Dp2p;
          Dn2p = value.get('n2p') + Dn2p;
          Dbook = value.get('book') + Dbook;
        });
        await FirebaseFirestore.instance
            .collection(widget.busName)
            .doc('Holder')
            .collection('Analytics')
            .doc('Holder')
            .collection('Passenger Type Activity')
            .doc('Holder')
            .collection('Discounted')
            .doc(DateFormat.y().format(DateTime.now()) +
                ' - ' +
                DateFormat.MMMM().format(DateTime.now()))
            .update({'p2p': Dp2p, 'n2p': Dn2p, 'book': Dbook});
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Type Activity')
          .doc('Holder')
          .collection('Discounted')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .set({'p2p': Dp2p, 'n2p': Dn2p, 'book': Dbook});
    }

    try {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Type Activity')
          .doc('Holder')
          .collection('Regular')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .get()
          .then((value) async {
        setState(() {
          Rp2p = value.get('p2p') + Rp2p;
          Rn2p = value.get('n2p') + Rn2p;
          Rbook = value.get('book') + Rbook;
        });
        await FirebaseFirestore.instance
            .collection(widget.busName)
            .doc('Holder')
            .collection('Analytics')
            .doc('Holder')
            .collection('Passenger Type Activity')
            .doc('Holder')
            .collection('Regular')
            .doc(DateFormat.y().format(DateTime.now()) +
                ' - ' +
                DateFormat.MMMM().format(DateTime.now()))
            .update({'p2p': Rp2p, 'n2p': Rn2p, 'book': Rbook});
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Type Activity')
          .doc('Holder')
          .collection('Regular')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .set({'p2p': Rp2p, 'n2p': Rn2p, 'book': Rbook});
    }
  }

  _passengerPerformanceMonthly() async {
    int p2p = 0;
    int n2p = 0;
    int book = 0;

    if (widget.type == 'P2P') {
      setState(() {
        p2p = 1;
      });
    } else if (widget.type == 'N2P') {
      setState(() {
        n2p = 1;
      });
    } else {
      setState(() {
        book = 1;
      });
    }

    try {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Performance Monthly')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .get()
          .then((value) async {
        setState(() {
          p2p = value.get('p2p') + p2p;
          n2p = value.get('n2p') + n2p;
          book = value.get('book') + book;
        });
        await FirebaseFirestore.instance
            .collection(widget.busName)
            .doc('Holder')
            .collection('Analytics')
            .doc('Holder')
            .collection('Passenger Performance Monthly')
            .doc(DateFormat.y().format(DateTime.now()) +
                ' - ' +
                DateFormat.MMMM().format(DateTime.now()))
            .update({'p2p': p2p, 'n2p': n2p, 'book': book});
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Performance Monthly')
          .doc(DateFormat.y().format(DateTime.now()) +
              ' - ' +
              DateFormat.MMMM().format(DateTime.now()))
          .set({'p2p': p2p, 'n2p': n2p, 'book': book});
    }
  }

  _passengerPerformanceYearly() async {
    int p2p = 0;
    int n2p = 0;
    int book = 0;

    if (widget.type == 'P2P') {
      setState(() {
        p2p = 1;
      });
    } else if (widget.type == 'N2P') {
      setState(() {
        n2p = 1;
      });
    } else {
      setState(() {
        book = 1;
      });
    }

    try {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Performance Yearly')
          .doc(DateFormat.y().format(DateTime.now()))
          .get()
          .then((value) async {
        setState(() {
          p2p = value.get('p2p') + p2p;
          n2p = value.get('n2p') + n2p;
          book = value.get('book') + book;
        });
        await FirebaseFirestore.instance
            .collection(widget.busName)
            .doc('Holder')
            .collection('Analytics')
            .doc('Holder')
            .collection('Passenger Performance Yearly')
            .doc(DateFormat.y().format(DateTime.now()))
            .update({'p2p': p2p, 'n2p': n2p, 'book': book});
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(widget.busName)
          .doc('Holder')
          .collection('Analytics')
          .doc('Holder')
          .collection('Passenger Performance Yearly')
          .doc(DateFormat.y().format(DateTime.now()))
          .set({'p2p': p2p, 'n2p': n2p, 'book': book});
    }
  }

  setSeat() async {
    await FirebaseFirestore.instance
        .collection(widget.busName)
        .doc('Holder')
        .collection('Bus Booking')
        .doc('Holder')
        .collection('${widget.busID} - ${widget.date}')
        .doc(widget.seatID)
        .update({'value': 0});
    await FirebaseFirestore.instance
        .collection('Bus Booking')
        .doc(widget.busID)
        .collection('Dates')
        .doc(widget.date)
        .get()
        .then((value) async {
      setState(() {
        current = value.get('current');
        revenue = value.get('revenue');
        current += 1;
        revenue += widget.amount;
      });

      await FirebaseFirestore.instance
          .collection('Bus Booking')
          .doc(widget.busID)
          .collection('Dates')
          .doc(widget.date)
          .update({'current': current, 'revenue': revenue});
    });
  }

  saveTicket() {
    DatabaseService(mobileNum: widget.mobileNum).addTransactionUserBooking(
        widget.time,
        widget.date,
        widget.route,
        widget.destination,
        widget.busName,
        widget.busID,
        widget.seatID,
        widget.amount,
        widget.number,
        widget.ref,
        widget.plateNo,
        widget.type,
        widget.name);
  }

  myCredits() {
    FirebaseDatabase.instance
        .reference()
        .child('Phone Numbers')
        .child(widget.mobileNum)
        .update({'credits': widget.credits - widget.amount});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Payment Successful ',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Passenger()));
              },
            )
          ],
          backgroundColor: Color(0xFF263238),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 650, maxHeight: 700),
                  padding:
                      EdgeInsets.all(Responsive.isMobile(context) ? 30 : 40),
                  width: size.width * .9,
                  height: size.height * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.busName == 'JAM'
                          ? Center(
                              child: Image.asset(
                                'assets/icons/JAM.png',
                                height: Responsive.isMobile(context) ? 50 : 65,
                              ),
                            )
                          : widget.busName == 'ALPS'
                              ? Center(
                                  child: Image.asset(
                                    'assets/icons/ALPS.png',
                                    height:
                                        Responsive.isMobile(context) ? 50 : 65,
                                  ),
                                )
                              : Center(
                                  child: Image.asset(
                                    'assets/icons/RRCG.png',
                                    height:
                                        Responsive.isMobile(context) ? 50 : 65,
                                  ),
                                ),
                      Center(
                        child: Text('Ticket No. ${widget.number}',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 18)),
                      ),
                      Row(
                        children: <Widget>[
                          Text('Bus Company',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.busName,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Bus ID',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.busID,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Driver',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.driver,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Conductor',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.conductor,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Plate Number',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.plateNo,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
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
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.date,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Time',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.time,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Fare',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('PHP ${widget.amount}.00',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Route',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.route,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Destination',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.destination,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Seat ID',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text(widget.seatID,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Reference No.',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                          Spacer(
                            flex: 5,
                          ),
                          Text('${widget.ref}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize:
                                      Responsive.isMobile(context) ? 14 : 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
