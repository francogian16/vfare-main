// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_vfare_app/passenger/booking/booking_select.dart';
import 'package:my_vfare_app/passenger/qrcodescanner/scanner_page.dart';
import 'package:my_vfare_app/passenger/np2p.dart';
import 'package:my_vfare_app/responsive.dart';
import 'package:my_vfare_app/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  String name = '';
  String mobileNum = '';
  int credit = 0;
  final AuthClass auth = AuthClass();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getProfile();
    //getCredits();
    super.initState();
  }

  getProfile() async {
    List<int> myList = [];
    for (int i = 0; i < 12; i++) {
      myList.add(0);
      print(DateFormat.H().format(DateTime.now()));
    }
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snapshot) async {
      setState(() {
        name = snapshot.value['first name'] + ' ' + snapshot.value['last name'];
        mobileNum = snapshot.value['mobile number'];
        FirebaseDatabase.instance
            .reference()
            .child('Phone Numbers')
            .child(mobileNum)
            .once()
            .then((DataSnapshot snapshot) {
          setState(() {
            credit = snapshot.value['credits'];
          });
        });
      });
    });
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxHeight: 80),
          height: size.height * .15 - 27,
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36))),
        ),
        Column(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 300, maxWidth: 500, minHeight: 200),
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                height: size.width * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                width: size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Spacer(
                          flex: 7,
                        ),
                        FutureBuilder<Widget>(
                            future: _getImage(
                                context, 'image/${user!.uid.toString()}'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: Responsive.isMobile(context) ? 40 : 80,
                                  height:
                                      Responsive.isMobile(context) ? 40 : 80,
                                  child: snapshot.data,
                                );
                              }
                              return Image.asset('assets/icons/passenger.jpg',
                                  width: Responsive.isMobile(context) ? 40 : 80,
                                  height:
                                      Responsive.isMobile(context) ? 40 : 80);
                            }),
                        //Image.asset('assets/icons/passenger.jpg',
                        //height: Responsive.isMobile(context) ? 50 : 100),
                        Spacer(
                          flex: 7,
                        ),
                        Container(
                          width: 200,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(name,
                                    style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 16
                                            : 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(mobileNum,
                                    style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 13
                                            : 15)),
                              )
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Text('Current Balance',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 20)),
                        Spacer(
                          flex: 9,
                        ),
                        TextButton(
                            onPressed: getProfile,
                            child: Text('PHP $credit.00',
                                style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 20
                                        : 22))),
                        //Text('PHP $credit.00',
                        //style: TextStyle(
                        // fontSize:
                        // Responsive.isMobile(context) ? 20 : 32)),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // button color
                  Container(
                    constraints: BoxConstraints(maxHeight: 250, maxWidth: 200),
                    padding: EdgeInsets.all(10),
                    height: Responsive.isMobile(context) ? 130 : 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow[600]),
                    width: Responsive.isMobile(context) ? 130 : 160,
                    child: InkWell(
                      splashColor: Colors.amber[700], // splash color
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => ScannerPage()));
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icons/qr-code-scan.png',
                              color: Colors.white,
                              height: Responsive.isMobile(context) ? 50 : 60),
                          SizedBox(
                              height: Responsive.isMobile(context)
                                  ? 5
                                  : 15), // icon
                          Text("Scan",
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 19,
                                  color: Colors.white)), // text
                        ],
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 250, maxWidth: 200),
                    padding: EdgeInsets.all(10),
                    height: Responsive.isMobile(context) ? 130 : 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow[600]),
                    width: Responsive.isMobile(context) ? 130 : 160,
                    child: InkWell(
                      splashColor: Colors.amber[700], // splash color
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => BookingSelect()));
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icons/online-booking.png',
                              color: Colors.white,
                              height: Responsive.isMobile(context) ? 60 : 60),
                          SizedBox(
                              height: Responsive.isMobile(context)
                                  ? 5
                                  : 15), // icon
                          Text("Book",
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 19,
                                  color: Colors.white)), // text
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
