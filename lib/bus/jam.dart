// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/responsive.dart';

class JamBus extends StatefulWidget {
  String busID;
  String date;
  String time;

  JamBus({required this.busID, required this.date, required this.time});

  @override
  _JamBus createState() => _JamBus();
}

class _JamBus extends State<JamBus> {
  int count = 1;
  int index = 0;
  List listLetter = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
  ];

  List indicate = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
  ];

  @override
  void initState() {
    _getIndicator();
    super.initState();
  }

  _getIndicator() {
    for (int i = 0; i < 9; i++) {
      count = 1;
      for (int j = 0; j < 4; j++) {
        FirebaseFirestore.instance
            .collection('JAM')
            .doc('Holder')
            .collection('Bus Booking')
            .doc('Holder')
            .collection('${widget.busID} - ${widget.date}')
            .doc('${listLetter[i]}$count')
            .get()
            .then((value) {
          setState(() {
            indicate[index] = value.get('value');
            index++;
          });
        });
        count++;
      }
    }

    count = 1;
    for (int i = 0; i < 5; i++) {
      FirebaseFirestore.instance
          .collection('JAM')
          .doc('Holder')
          .collection('Bus Booking')
          .doc('Holder')
          .collection('${widget.busID} - ${widget.date}')
          .doc('${listLetter[9]}$count')
          .get()
          .then((value) {
        setState(() {
          indicate[index] = value.get('value');
          index++;
        });
      });
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        width: size.width * .9,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[0] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'A1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[1] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'A2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[2] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'A3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[3] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'A4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[4] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'B1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[5] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'B2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[6] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'B3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[7] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'B4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[8] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'C1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[9] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'C2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[10] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'C3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[11] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'C4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[12] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'D1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[13] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'D2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[14] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'D3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[15] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'D4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[16] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'E1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[17] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'E2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[18] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'E3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[19] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'E4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[20] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'F1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[21] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'F2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[22] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'F3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[23] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'F4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[24] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'G1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[25] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'G2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[26] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'G3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[27] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'G4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[28] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'H1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[29] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'H2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[30] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'H3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[31] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'H4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[32] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'I1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[33] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'I2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[34] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'I3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[35] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'I4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[36] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'J1',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[37] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'J2',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[38] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'J3',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[39] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'J4',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: Responsive.isMobile(context) ? 40 : 50,
                    width: Responsive.isMobile(context) ? 45 : 55,
                    decoration: BoxDecoration(
                        color: indicate[40] == 1
                            ? Colors.lightGreenAccent[700]
                            : Colors.black87),
                    child: Center(
                      child: Text(
                        'J5',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 25 : 30,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
