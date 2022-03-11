// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../responsive.dart';
import 'announcement-heading.dart';
import 'transaction-history.dart';
import 'home-details.dart';
import 'announcement.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          HomeDetails(),
          SizedBox(
            height: size.height * .025,
          ),
          AnnouncementHeading(),
          Announcement(),
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
                        Animation animation, Animation secondaryAnimation) {
                      return Center(
                          child: Container(
                              constraints: BoxConstraints(maxWidth: 800),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              width: size.width * .95,
                              height: size.height * .8,
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
                                        fontSize: Responsive.isMobile(context)
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
                                          constraints:
                                              BoxConstraints(maxWidth: 700),
                                          width: size.width * .8,
                                          child: Text(
                                            '1. This module contains the your app dashboard.',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                                          '2. The white text box above contains your user details as well as your account balance. Clicking on the account balance refreshes your account balance if you purchase a load.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '3. The Scan and Book button can also be seen below that. It will redirect you to their respective modules.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '4. Below that is the announcements tab wherein you can view the announcements from different bus companies as well as vFare itself. Swipe left to view more announcements and click on view all to view all announcements.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '5. You can view the whole announcement by clicking on each rectangular boxes.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '6. Below that is your Transaction History. All your transactions will be displayed there and to view each whole transaction, jusq click the transaction itself and a dialog box will appear.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '7. To view all transactions, click on the view all text button beside the text - Transaction History.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                                          '8. You can also refund your payments and booking transactions with buses by clicking on the transaction and click the Refund button. Transactions from loading schemes are not included in the refund.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              decoration: TextDecoration.none,
                                              fontSize:
                                                  Responsive.isMobile(context)
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
                        fontSize: Responsive.isMobile(context) ? 14 : 18))),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          TransactionHistory()
        ],
      ),
    );
  }
}
