// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/passenger_fullverify.dart';
import 'package:my_vfare_app/responsive.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../loading.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  String name = '';
  String mobileNum = '';
  String dateBirth = '';
  String accType = '';
  String regID = '';
  bool check = false;
  bool validate = false;
  User? user = FirebaseAuth.instance.currentUser;
  double progress = 0.0;

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

  getProfile() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value['first name'] + ' ' + snapshot.value['last name'];
        mobileNum = snapshot.value['mobile number'];
 

        FirebaseDatabase.instance
            .reference()
            .child('Phone Numbers')
            .child(mobileNum)
            .once()
            .then((DataSnapshot snap) {
          setState(() {
            check = snap.value['status'];
            validate = snap.value['verify'];

            if (validate) {
              dateBirth = snap.value['date'];
              regID = snap.value['account type'];
              accType = regID.substring(0, regID.lastIndexOf('ID'));
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
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              // decoration: BoxDecoration(color: Colors.green),
              constraints: BoxConstraints(maxHeight: 250, minHeight: 180),
              height: size.height * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: FutureBuilder<Widget>(
                        future:
                            _getImage(context, 'image/${user!.uid.toString()}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: Responsive.isMobile(context) ? 100 : 110,
                              height: Responsive.isMobile(context) ? 100 : 110,
                              child: snapshot.data,
                            );
                          }
                          return Image.asset('assets/icons/passenger.jpg',
                              height: Responsive.isMobile(context) ? 100 : 110);
                        }),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            Uint8List? file = result.files.first.bytes;
                            String fileName = result.files.first.name;
      
                            UploadTask task = FirebaseStorage.instance
                                .ref()
                                .child('image/${user!.uid.toString()}')
                                .putData(file!);
                            task.snapshotEvents.listen((event) {
                              setState(() {
                                progress = ((event.bytesTransferred /
                                            event.totalBytes.toDouble()) *
                                        100)
                                    .roundToDouble();
                                print(progress);
                              });
                            });
                          }
                        },
                        child: Text('Change Photo',
                            style: TextStyle(
                                fontSize: Responsive.isMobile(context) ? 16 : 16,
                                color: Colors.yellow[600]))),
                  ),
                  (progress == 0 || progress == 100) ? SizedBox() : Loading()
                  /*Container(
                    height: 100,
                    width: 100,
                    child: LiquidCircularProgressIndicator(
                      value: progress / 100,
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                      backgroundColor: Colors.white,
                      direction: Axis.vertical,
                      center: Text('$progress%'),
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints:
                  BoxConstraints(maxHeight: 600, maxWidth: 500, minHeight: 300),
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context) ? 30 : 40,
                  right: Responsive.isMobile(context) ? 30 : 40,
                  top: Responsive.isMobile(context) ? 20 : 25,
                  bottom: Responsive.isMobile(context) ? 20 : 25),
              height: size.height * .4,
              width: size.width * .95,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Name',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(name,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Mobile Number',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(mobileNum,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Date of Birth',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(dateBirth,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Account Type',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(accType,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Registered ID',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(regID,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 16)),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            check
                ? Center(
                    child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => FullVerify()));
                    },
                    child: Text('Register ID',
                        style: TextStyle(
                            color: Colors.yellow[600],
                            fontSize: Responsive.isMobile(context) ? 16 : 16)),
                  ))
                : SizedBox()
          ],
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
