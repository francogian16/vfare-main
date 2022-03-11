// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_final_fields, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/discount.dart';
import 'package:my_vfare_app/passenger/home-details.dart';
import 'package:my_vfare_app/passenger/np2p.dart';
import 'package:my_vfare_app/passenger/payment_confirmation.dart';
import 'package:my_vfare_app/responsive.dart';
import 'app_scanner_widget.dart';
import 'package:air_design/air_design.dart';
import 'package:intl/intl.dart';

///
/// CustomSizeScannerPage
class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String _code = '';
  int indicator = 0;
  bool camera = true;
  String conductor = '';
  String driver = '';
  String company = '';
  String route = '';
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Color(0xFF263238),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AppCardOutlinedStyleWidget.defaultStyle(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
                width: size.width * .85,
                height: size.height * .6,
                child: camera
                    ? AppBarcodeScannerWidget.defaultStyle(
                        resultCallback: (String code) async {
                          print(code);
                          try {
                            await FirebaseFirestore.instance
                                .collection('Bus')
                                .doc('Holder')
                                .collection('Bus List')
                                .doc(code.substring(4, 11))
                                .get()
                                .then((value) async {
                              setState(() {
                                company = value.get('company');
                                print(company);
                              });

                              await FirebaseFirestore.instance
                                  .collection(company)
                                  .doc('Holder')
                                  .collection('Bus')
                                  .doc(code.substring(4, 11))
                                  .collection('Seat')
                                  .doc(code.substring(12))
                                  .get()
                                  .then((value) async {
                                if (value.get('value') == 1) {
                                  await FirebaseFirestore.instance
                                      .collection(company)
                                      .doc('Holder')
                                      .collection('Bus')
                                      .doc(code.substring(4, 11))
                                      .collection('QR Code')
                                      .doc(code)
                                      .get()
                                      .then((val) {
                                    if (code == val.get('value')) {
                                      FirebaseFirestore.instance
                                          .collection('Bus')
                                          .doc('Holder')
                                          .collection('Bus List')
                                          .doc(code.substring(4, 11))
                                          .get()
                                          .then((value) {
                                        setState(() {
                                          driver = value.get('driver');
                                          conductor = value.get('conductor');
                                          route = value.get('route');
                                          _code = val.get('value');
                                          indicator = 1;
                                          camera = false;

                                          if (driver == 'none' ||
                                              conductor == 'none' ||
                                              route == 'none') {
                                            setState(() {
                                              indicator = 2;
                                            });
                                          } else {
                                            if (code.substring(0, 3) == 'P2P') {
                                              FirebaseFirestore.instance
                                                  .collection(company)
                                                  .doc('Holder')
                                                  .collection('Routes')
                                                  .doc('Amount')
                                                  .collection(route)
                                                  .doc(route.substring(0, 3) +
                                                      '-' +
                                                      route.substring(4))
                                                  .get()
                                                  .then((value) {
                                                setState(() {
                                                  amount = value.get('amount');
                                                  print(amount);
                                                });
                                              });
                                            }
                                          }
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        indicator = 2;
                                      });
                                    }
                                  });
                                } else {
                                  setState(() {
                                    indicator = 3;
                                  });
                                }
                              });
                            });
                          } catch (e) {
                            setState(() {
                              indicator = 2;
                            });
                          }
                        },
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            (indicator == 1)
                ? SizedBox(
                    height: size.height * .2,
                    width: size.width * .7,
                    child: Column(
                      children: [
                        Container(
                            constraints:
                                BoxConstraints(maxWidth: 280, maxHeight: 50),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF263238)),
                            width: size.width * .8,
                            height: size.height * .07,
                            child: Center(
                              child: Text(
                                _code,
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 16 : 18,
                                    color: Colors.white),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            print(route);
                            print(route.substring(4));
                            print(company);
                            print(_code.substring(4, 11));
                            print(_code.substring(12));
                            print(driver);
                            print(conductor);
                            print(amount);
                            print(_code.substring(0, 3));

                            _code.substring(0, 3) == 'N2P'
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => NonP2P(
                                          time: DateFormat.jm()
                                              .format(DateTime.now()),
                                          date: DateFormat.yMMMMd()
                                              .format(DateTime.now()),
                                          route: route,
                                          busName: company,
                                          busID: _code.substring(4, 11),
                                          seatID: _code.substring(12),
                                          driver: driver,
                                          conductor: conductor,
                                          type: _code.substring(0, 3),
                                        )))
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => TypePay(
                                          value: 0,
                                          time: DateFormat.jm()
                                              .format(DateTime.now()),
                                          date: DateFormat.yMMMMd()
                                              .format(DateTime.now()),
                                          alTime: DateFormat.H()
                                              .format(DateTime.now()),
                                          route: route,
                                          destination: route.substring(4),
                                          busName: company,
                                          busID: _code.substring(4, 11),
                                          seatID: _code.substring(12),
                                          driver: driver,
                                          conductor: conductor,
                                          amount: amount,
                                          type: _code.substring(0, 3),
                                        )));
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
                              child: Text('Proceed',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Responsive.isMobile(context)
                                          ? 18
                                          : 18)),
                            ),
                          ),
                        ),
                      ],
                    ))
                : (indicator == 0)
                    ? Container(
                        constraints:
                            BoxConstraints(maxWidth: 280, maxHeight: 50),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF263238)),
                        width: size.width * .8,
                        height: size.height * .07,
                        child: Center(
                          child: Text(
                            'Please Scan the QR Code.',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 18,
                                color: Colors.white),
                          ),
                        ))
                    : (indicator == 3)
                        ? Container(
                            constraints:
                                BoxConstraints(maxWidth: 280, maxHeight: 50),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF263238)),
                            width: size.width * .8,
                            height: size.height * .07,
                            child: Center(
                              child: Text(
                                'Seat is already taken!',
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 16 : 18,
                                    color: Colors.white),
                              ),
                            ))
                        : Container(
                            constraints:
                                BoxConstraints(maxWidth: 280, maxHeight: 50),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF263238)),
                            width: size.width * .8,
                            height: size.height * .07,
                            child: Center(
                              child: Text(
                                'Invalid QR Code. Scan Again.',
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 16 : 18,
                                    color: Colors.white),
                              ),
                            ))
          ],
        ),
      ),
    );
  }
}
