// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_vfare_app/passenger/booking/booking_ticket.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/passenger/ticket.dart';
import 'package:my_vfare_app/responsive.dart';
import 'package:intl/intl.dart';

class PaymentConfirmation extends StatefulWidget {
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
  String? plateNo;
  bool discount;
  String? idNum;
  String? label;
  int amount;
  int value;
  String? type;

  PaymentConfirmation(
      {required this.discount,
      this.alTime,
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
      this.plateNo,
      required this.amount,
      this.type});
  @override
  _PaymentConfirmation createState() => _PaymentConfirmation(value);
}

class _PaymentConfirmation extends State<PaymentConfirmation> {
  int indicate;
  _PaymentConfirmation(this.indicate);
  int num = 0;
  int ref = 0;
  int credits = 0;
  bool check = false;
  double amount = 0;
  User? user = FirebaseAuth.instance.currentUser;
  String error = '';
  String name = '';
  String mobileNum = '';
  bool verify = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _setCredits();
    super.initState();
  }

  _setCredits() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snap) {
      setState(() {
        mobileNum = snap.value['mobile number'];
        name = snap.value['last name'] + ', ' + snap.value['first name'];
        FirebaseDatabase.instance
            .reference()
            .child('Phone Numbers')
            .child(mobileNum)
            .once()
            .then((DataSnapshot snapshot) {
          setState(() {
            credits = snapshot.value['credits'];
            check = snapshot.value['verify'];
            print(check);
            if (check || widget.discount) {
              amount = widget.amount - (widget.amount * .2);
              print(amount);
            } else {
              amount = widget.amount.toDouble();
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Payment Confirmation'),
        backgroundColor: Color(0xFF263238),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/icons/4.png',
                height: Responsive.isMobile(context) ? 100 : 110,
              ),
            ),
            Center(
              child: Text(
                widget.busName,
                style:
                    TextStyle(fontSize: Responsive.isMobile(context) ? 15 : 17),
              ),
            ),
            Center(
              child: Text(
                widget.busID,
                style:
                    TextStyle(fontSize: Responsive.isMobile(context) ? 15 : 17),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 650, maxHeight: 550),
              height: size.height * .6,
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context) ? 40 : 50,
                  right: Responsive.isMobile(context) ? 40 : 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      Text('Time',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(widget.time,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Date',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(widget.date,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Fare',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text('PHP ${amount.toInt()}.00',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Route',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(widget.route,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Destination',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(widget.destination,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Seat ID',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                      Spacer(
                        flex: 5,
                      ),
                      Text(widget.seatID,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize:
                                  Responsive.isMobile(context) ? 16 : 18)),
                    ],
                  ),
                  Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.amber[600],
                      onTap: () async {
                        if (credits >= widget.amount) {
                          await FirebaseDatabase.instance
                              .reference()
                              .child('Number Generate')
                              .once()
                              .then((DataSnapshot snapshot) {
                            setState(() {
                              num = snapshot.value['value'];
                              ref = snapshot.value['reference'];
                              ref++;
                              num++;
                              error = '';
                            });
                          });
                          await FirebaseDatabase.instance
                              .reference()
                              .child('Number Generate')
                              .update({'value': num, 'reference': ref});

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => indicate == 1
                                  ? BookingTicket(
                                      time: widget.time,
                                      date: widget.date,
                                      route: widget.route,
                                      destination: widget.destination,
                                      busName: widget.busName,
                                      busID: widget.busID,
                                      seatID: widget.seatID,
                                      amount: amount.toInt(),
                                      number: num,
                                      ref: ref,
                                      mobileNum: mobileNum,
                                      credits: credits,
                                      driver: widget.driver!,
                                      conductor: widget.conductor!,
                                      plateNo: widget.plateNo!,
                                      check: check,
                                      name: name.toUpperCase(),
                                      type: 'Booking')
                                  : Ticket(
                                      alTime:
                                          DateFormat.H().format(DateTime.now()),
                                      time: widget.time,
                                      name: name.toUpperCase(),
                                      date: widget.date,
                                      route: widget.route,
                                      destination: widget.destination,
                                      busName: widget.busName,
                                      busID: widget.busID,
                                      seatID: widget.seatID,
                                      driver: widget.driver!,
                                      conductor: widget.conductor!,
                                      amount: amount.toInt(),
                                      number: num,
                                      mobileNum: mobileNum,
                                      ref: ref,
                                      label: widget.label,
                                      credits: credits,
                                      verify: verify,
                                      check: check,
                                      type: widget.type!)));
                        } else {
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierLabel: MaterialLocalizations.of(context)
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
                                          Text(
                                            'You do not have enought credits!',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 14
                                                        : 16),
                                          ),
                                          Container(
                                            width: size.width * 8,
                                            child: Center(
                                              child: Text(
                                                  'Please add more credits to continue this transaction.',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 12
                                                              : 14)),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            Passenger()));
                                              },
                                              child: Text('Done',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 16
                                                              : 16)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.amber[600],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 100,
                                                    vertical: 5),
                                              ))
                                        ],
                                      )),
                                );
                              });
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
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 16)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () => showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
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
                                                    '1. This is the Payment Confirmation Module wherein you can see the details of your transaction.',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize:
                                                            Responsive.isMobile(
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
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '2. If you click continue, the amount displayed will be deducted to your account and your transaction will be complete.',
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
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '3. It will also redirect you to the Ticket module wherein it will display the full details of your transaction. To exit the Ticket Module, click on the X button on the top right corner of your screen.',
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
                                                constraints: BoxConstraints(
                                                    maxWidth: 700),
                                                width: size.width * .8,
                                                child: Text(
                                                  '4. It is highly recommended that you take a screenshot of each digital receipt in every transaction for future purposes.',
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
                                                    horizontal: 100,
                                                    vertical: 5),
                                              ))
                                        ],
                                      )));
                            }),
                        child: Text('Need help?',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 18))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
