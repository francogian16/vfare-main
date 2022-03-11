// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:typed_data';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_vfare_app/loading.dart';
import 'package:my_vfare_app/passenger/passenger_main.dart';
import 'package:my_vfare_app/responsive.dart';

class FullVerify extends StatefulWidget {
  @override
  _FullVerify createState() => _FullVerify();
}

class _FullVerify extends State<FullVerify> {
  late DateTime pickedDate;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String mobileNum = '';
  String name = '';
  String idNum = '';
  TextEditingController idNumTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    getNum();
  }

  getNum() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user!.uid)
        .child('Profile')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        mobileNum = snapshot.value['mobile number'];
        name = snapshot.value['first name'] + ' ' + snapshot.value['last name'];
      });
    });

    try {
      print('test');
      print(mobileNum);
      await FirebaseDatabase.instance
          .reference()
          .child('Upload')
          .child(mobileNum)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value['id'] == true && snapshot.value['face'] == true) {
          setState(() {
            check1 = true;
            check2 = true;
          });
        }
      });
    } catch (e) {}
  }

  final listID = ["Senior Citizen", "PWD"];

  String? id;

  String date = 'Input your Date of Birth';
  String error = '';
  String error2 = '';
  double progress1 = 0.0;
  double progress2 = 0.0;
  bool check1 = false;
  bool check2 = false;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Apply for Full Verification'),
        backgroundColor: Color(0xFF263238),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            //decoration: BoxDecoration(color: Colors.green),
            constraints:
                BoxConstraints(maxHeight: 650, maxWidth: 600, minHeight: 450),
            padding: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 20 : 40,
                right: Responsive.isMobile(context) ? 20 : 40),
            height: size.height * .8,
            width: size.width * 1,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Row(
                      children: [
                        Text('ID Type', style: TextStyle(fontSize: 16)),
                        Spacer(),
                        Container(
                          width: 180,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                            decoration: InputDecoration.collapsed(
                                hintText: "Select ID Type"),
                            validator: (value) => value == null
                                ? 'This field is required!'
                                : null,
                            value: id,
                            items: listID.map(buildMenuItem_5).toList(),
                            onChanged: (value) => setState(() => id = value),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 16),
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'This field is required!' : null,
                        controller: idNumTEC,
                        onChanged: (val) {
                          setState(() => idNum = val);
                        },
                        decoration: InputDecoration(
                          hintText: '123456789',
                          labelText: 'Enter ID No.',
                          labelStyle: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 16 : 18,
                              color: Colors.black),
                          border: OutlineInputBorder(),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(13.5),
                            child: Text(
                              'ID Number',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 18,
                                  color: Colors.black),
                            ),
                          ),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Row(
                      children: [
                        Text('Date of Birth: ',
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 16 : 16)),
                        Spacer(
                          flex: 5,
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 16 : 16),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        IconButton(
                            onPressed: _pickDate,
                            icon: Icon(Icons.calendar_today_outlined,
                                color: Colors.black54))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text('Please upload a clear copy of your ID',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 16)),
                  ),
                  Center(
                    child: Text('and a snapshot of your face.',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 16)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(
                        flex: 5,
                      ),
                      FutureBuilder<Widget>(
                          future:
                              _getImage(context, 'requests/validID$mobileNum'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                constraints: BoxConstraints(
                                    maxWidth: 130, maxHeight: 130),
                                width: size.width * .3,
                                height: size.height * .3,
                                child: snapshot.data,
                              );
                            }
                            return Image.asset('assets/icons/passenger.jpg',
                                height:
                                    Responsive.isMobile(context) ? 100 : 110);
                          }),
                      Spacer(
                        flex: 3,
                      ),
                      FutureBuilder<Widget>(
                          future:
                              _getImage(context, 'requests/userface$mobileNum'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                constraints: BoxConstraints(
                                    maxWidth: 130, maxHeight: 130),
                                width: size.width * .3,
                                height: size.height * .3,
                                child: snapshot.data,
                              );
                            }
                            return Image.asset('assets/icons/passenger.jpg',
                                height:
                                    Responsive.isMobile(context) ? 100 : 110);
                          }),
                      Spacer(
                        flex: 5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  !check1 || !check2
                      ? Row(
                          children: [
                            Spacer(
                              flex: 5,
                            ),
                            (progress1 == 0 || progress1 == 100)
                                ? SizedBox()
                                : Loading(),
                            Spacer(
                              flex: 8,
                            ),
                            (progress2 == 0 || progress2 == 100)
                                ? SizedBox()
                                : Loading(),
                            Spacer(
                              flex: 5,
                            )
                          ],
                        )
                      : SizedBox(),
                  check1 && check2
                      ? SizedBox()
                      : Center(
                          child: Text(
                            error2,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Spacer(
                        flex: 5,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: 150, maxHeight: 50),
                        width: size.width * .3,
                        height: size.height * .05,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber[700], // splash color
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              Uint8List? file = result.files.first.bytes;
                              String fileName = result.files.first.name;

                              UploadTask task = FirebaseStorage.instance
                                  .ref()
                                  .child('requests/validID$mobileNum')
                                  .putData(file!);
                              task.snapshotEvents.listen((event) {
                                setState(() {
                                  progress1 = ((event.bytesTransferred /
                                              event.totalBytes.toDouble()) *
                                          100)
                                      .roundToDouble();
                                  print(progress1);
                                  if (progress1 == 100) {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child('Upload')
                                        .child(mobileNum)
                                        .update({'id': true});
                                    setState(() {
                                      check1 = true;
                                      error2 = '';
                                      print(check1);
                                    });
                                  }
                                });
                              });
                            }
                          }, // button pressed
                          child: Center(
                            child: Text("Upload ID",
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 14 : 15,
                                    color: Colors.white)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber[600]),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: 150, maxHeight: 50),
                        width: size.width * .3,
                        height: size.height * .05,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber[700], // splash color
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              Uint8List? file = result.files.first.bytes;
                              String fileName = result.files.first.name;

                              UploadTask task = FirebaseStorage.instance
                                  .ref()
                                  .child('requests/userface$mobileNum')
                                  .putData(file!);
                              task.snapshotEvents.listen((event) {
                                setState(() {
                                  progress2 = ((event.bytesTransferred /
                                              event.totalBytes.toDouble()) *
                                          100)
                                      .roundToDouble();
                                  print(progress2);
                                  if (progress2 == 100) {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child('Upload')
                                        .child(mobileNum)
                                        .update({'face': true});
                                    setState(() {
                                      check2 = true;
                                      error2 = '';
                                    });
                                  }
                                });
                              });
                            }
                          }, // button pressed
                          child: Center(
                            child: Text("Upload Snapshot",
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isMobile(context) ? 14 : 15,
                                    color: Colors.white)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber[600]),
                      ),
                      Spacer(
                        flex: 5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                        'Note: Students will only be eligible for discounts if they ',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 12 : 14)),
                  ),
                  Center(
                    child: Text(
                        'will present their IDs to the conductor during transactions.',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 12 : 14)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.amber[600],
            onTap: () async {
              if (check1 == false || check2 == false) {
                setState(() {
                  error2 = 'Please upload your ID and Snapshot!';
                });
              }
              if (date == '') {
                setState(() {
                  error = 'Please input your birthdate!';
                });
              } else {
                setState(() {
                  error = '';
                });
              }
              if (_formKey.currentState!.validate() &&
                  date != '' &&
                  check1 == true &&
                  check2 == true) {
                await FirebaseDatabase.instance
                    .reference()
                    .child('Phone Numbers')
                    .child(mobileNum)
                    .update({
                  'status': false,
                  'date': date,
                  'account type': id,
                  'id number': idNum,
                  'verify': false
                });
                await FirebaseFirestore.instance
                    .collection('Requests')
                    .doc(mobileNum)
                    .set({
                  'number': mobileNum,
                  'name': name,
                  'date': date,
                  'id number': idNum,
                  'account type': id,
                  'status': false
                });

                showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return Center(
                        child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 800, maxHeight: 650),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            width: size.width * .95,
                            height: size.height * .3,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Text(
                                      'Request submitted! ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.none,
                                          fontSize: Responsive.isMobile(context)
                                              ? 16
                                              : 18),
                                    ),
                                    Image.asset('assets/icons/checked.png',
                                        height: Responsive.isMobile(context)
                                            ? 18
                                            : 20,
                                        color: Colors.black87),
                                    Spacer(
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text('Please wait 1-2 working days!.',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          decoration: TextDecoration.none,
                                          fontSize: Responsive.isMobile(context)
                                              ? 14
                                              : 16)),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => Passenger()));
                                    },
                                    child: Text('Done',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 16
                                                    : 16)),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.amber[600],
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 5),
                                    ))
                              ],
                            )),
                      );
                    });
              }
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: 280, maxHeight: 50),
              width: size.width * .7,
              height: size.height * .05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber[600]),
              child: Center(
                child: Text('Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.isMobile(context) ? 16 : 18)),
              ),
            ),
          )),
          Spacer(
            flex: 9,
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  _pickDate() async {
    DateTime? d = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 2));

    if (d != null) {
      setState(() {
        pickedDate = d;
        date = DateFormat.yMMMMd().format(pickedDate);
        print(DateFormat.yMMMMd().format(pickedDate));
      });
    }
  }

  DropdownMenuItem<String> buildMenuItem_5(String listID) => DropdownMenuItem(
        value: listID,
        child: Text(listID, style: TextStyle(color: Colors.black)),
      );
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
