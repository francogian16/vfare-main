// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/responsive.dart';

class AllAnnouncement extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Announcement')
      .orderBy('time', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Announcement'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF263238),
      body: ListView(
        children: [
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: _usersStream,
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return AllAnnouncementDetails(
                        company: data['title'],
                        preview: data['preview'],
                        whole: data['body'],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllAnnouncementDetails extends StatelessWidget {
  const AllAnnouncementDetails(
      {required this.company, required this.preview, required this.whole});

  final String company;
  final String preview;
  final String whole;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
          maxWidth: 650, maxHeight: 150, minHeight: 130, minWidth: 230),
      padding:
          EdgeInsets.only(left: size.height * .015, right: size.height * .015),
      height: size.height * .15,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      width: size.width * 1,
      child: Center(
        child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext, Animation animation,
                    Animation secondaryAnimation) {
                  return Center(
                    child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 800, maxHeight: 650, minHeight: 200),
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
                                  '$company ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      decoration: TextDecoration.none,
                                      fontSize: Responsive.isMobile(context)
                                          ? 16
                                          : 18),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Responsive.isMobile(context) ? 350 : 600,
                              child: Text('$whole',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      decoration: TextDecoration.none,
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 16)),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Text('Done',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Responsive.isMobile(context)
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
                }),
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: 150, minHeight: 110, minWidth: 200, maxWidth: 350),
              padding: EdgeInsets.only(
                  left: size.height * .015, right: size.height * .015),
              height: size.height * .1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              width: size.width * .95,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * .015,
                  ),
                  Text("$company",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 17 : 20,
                          color: Colors.yellow[700])),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Color(0xFF263238),
                    height: size.height * .0005,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text(
                    "$preview",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 13 : 15),
                    textAlign: TextAlign.center,
                  )),
                  // text
                ],
              ),
            )),
      ),
    );
  }
}
