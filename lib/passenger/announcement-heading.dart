// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:my_vfare_app/passenger/announcement-all.dart';
import 'package:my_vfare_app/responsive.dart';

class AnnouncementHeading extends StatelessWidget {
  const AnnouncementHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       constraints: BoxConstraints(maxWidth: 520),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          Spacer(
            flex: 2,
          ),
          Text(
            'ANNOUNCEMENTS',
            style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.isMobile(context) ? 16 : 18),
          ),
          Spacer(
            flex: 9,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AllAnnouncement()));
              },
              child: Text(
                'View all',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.isMobile(context) ? 14 : 16),
              )),
          Spacer(
            flex: 2,
          ),
        ]),
      ),
    );
  }
}
