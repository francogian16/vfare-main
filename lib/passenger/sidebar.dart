// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/help.dart';
import 'package:my_vfare_app/loading.dart';
import 'package:my_vfare_app/login_register.dart';
import 'package:my_vfare_app/main.dart';
import 'package:my_vfare_app/passenger/feedback.dart';
import 'package:my_vfare_app/passenger/payment-requests.dart';
import 'package:my_vfare_app/passenger/refund-request.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'user-profile.dart';
import 'package:my_vfare_app/responsive.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBar createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  String name = '';
  String mobileNum = '';
  final AuthClass auth = AuthClass();
  User? user = FirebaseAuth.instance.currentUser;

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image? image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image!;
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() {
    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value['first name'] + ' ' + snapshot.value['last name'];
        mobileNum = snapshot.value['mobile number'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 700, maxWidth: 500),
        height: size.height * .9,
        width: size.width * .9,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 300),
                height: size.height * .3,
                child: DrawerHeader(
                    padding: EdgeInsets.only(right: 1),
                    decoration: BoxDecoration(color: Color(0xFF263238)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Spacer(
                              flex: 3,
                            ),
                            FutureBuilder<Widget>(
                                future: _getImage(
                                    context, 'image/${user!.uid.toString()}'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height: Responsive.isMobile(context)
                                          ? 100
                                          : 110,
                                      width: Responsive.isMobile(context)
                                          ? 100
                                          : 110,
                                      child: snapshot.data,
                                    );
                                  }
                                  return Image.asset(
                                      'assets/icons/passenger.jpg',
                                      height: Responsive.isMobile(context)
                                          ? 100
                                          : 110);
                                }),
                            Spacer(flex: 3),
                            Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 18,
                                          color: Colors.white70),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * .005,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mobileNum,
                                      style: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 14
                                              : 16,
                                          color: Colors.white70),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * .03,
                                  )
                                ],
                              ),
                              width: Responsive.isMobile(context) ? 150 : 250,
                            ),
                            Spacer(
                              flex: 9,
                            )
                          ],
                        )
                      ],
                    )),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/user.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => UserProfile()));
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/menu.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Refund Requests',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => RefundRequest(
                            mobileNum: mobileNum,
                          )));
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/menu.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Payment Requests',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PaymentRequest(
                            mobileNum: mobileNum,
                          )));
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/help.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Help()));
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/chat.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Send Feedback',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => SendFeedback()));
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * .05),
                leading: Image.asset(
                  'assets/icons/logout2.png',
                  height: Responsive.isMobile(context) ? 35 : 45,
                ),
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 18),
                ),
                onTap: () async {
                  dynamic result = await auth.logout();
                  if (result == 'Success') {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => MyApp()));
                  }
                },
              ),
              Container(
                height: size.height * .0005,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
