import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String? uid;
  String? mobileNum;
  DatabaseService({this.uid, this.mobileNum});

  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Passenger');

  final database = FirebaseDatabase.instance.reference();

  Future<String> addUserProfile(
    String mobileNumm,
    String firstName,
    String lastName,
    String role,
  ) async {
    try {
      final data = {
        'mobile number': '0' + mobileNumm,
        'first name': firstName,
        'last name': lastName,
        'role': role
      };

      await database.child('Users').child(uid!).child('Profile').set(data);
      //await userCollection.doc(uid).set(data);
      await database.child('Phone Numbers').child('0' + mobileNumm).set({
        'value': '0' + mobileNumm,
        'credits': 100,
        'name': firstName + ' ' + lastName,
        'status': true,
        'verify': false,
        'account type': 'none',
        'date': 'none',
      });

      await database.child('Upload').child(mobileNumm).set({
        'face': false,
        'id': false,
      });

      return 'User added';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addTransactionUser(
      String time,
      String date,
      String route,
      String destination,
      String busName,
      String busID,
      String seatID,
      String conductor,
      String driver,
      int amount,
      int number,
      String type,
      int ref,
      String name,
      String label) async {
    try {
      final data = {
        'reference number': ref,
        'ticket number': number,
        'date': date,
        'time': time,
        'fare': amount,
        'route': route,
        'destination': destination,
        'seat id': seatID,
        'company': busName,
        'bus id': busID,
        'driver': driver,
        'conductor': conductor,
        'activity': 'Purchased from',
        'timestamp': DateTime.now(),
        'refund': true,
        'name': name,
        'type': type
      };

      final data2 = {
        'reference number': ref,
        'ticket number': number,
        'date': date,
        'time': time,
        'amount': amount,
        'route': route,
        'destination': destination,
        'seat id': seatID,
        'company': busName,
        'activity': 'Received payment from',
        'mobile number': mobileNum,
        'timestamp': DateTime.now(),
        'name': name,
        'type': type
      };

      final data3 = {
        'seat id': seatID,
        'ticket number': number,
        'name': name,
        'label': label
      };

      await FirebaseFirestore.instance
          .collection(busName)
          .doc('Holder')
          .collection('Passenger Manifest')
          .doc(busID)
          .collection(date)
          .doc(number.toString())
          .set(data3);

      await FirebaseFirestore.instance
          .collection(busName)
          .doc('Holder')
          .collection('Passenger Manifest')
          .doc('Holder')
          .collection(busID)
          .doc(date)
          .set({'value': date});

      await dbCollection
          .doc(mobileNum)
          .collection('Transaction')
          .doc(ref.toString())
          .set(data);
      await FirebaseFirestore.instance
          .collection('Bus')
          .doc(busID)
          .collection('Transaction')
          .doc(ref.toString())
          .set(data2);
      //await userCollection.doc(uid).set(data);

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addTransactionUserBooking(
      String time,
      String date,
      String route,
      String destination,
      String busName,
      String busID,
      String seatID,
      int amount,
      int number,
      int ref,
      String plateNo,
      String type,
      String name) async {
    try {
      final data = {
        'reference number': ref,
        'ticket number': number,
        'plate number': plateNo,
        'date': date,
        'time': time,
        'fare': amount,
        'route': route,
        'destination': destination,
        'seat id': seatID,
        'company': busName,
        'bus id': busID,
        'activity': 'Booked from',
        'type': type,
        'timestamp': DateTime.now(),
        'refund': true,
        'name': name
      };
      final data2 = {
        'reference number': ref,
        'ticket number': number,
        'date': date,
        'time': time,
        'amount': amount,
        'route': route,
        'destination': destination,
        'seat id': seatID,
        'company': busName,
        'bus id': busID,
        'mobile number': mobileNum,
        'activity': 'Received booking from',
        'timestamp': DateTime.now(),
        'name': name
      };

      final data3 = {
        'seat id': seatID,
        'ticket number': number,
        'name': name,
      };

      await FirebaseFirestore.instance
          .collection(busName)
          .doc('Holder')
          .collection('Passenger Manifest')
          .doc(busID)
          .collection(date)
          .doc(number.toString())
          .set(data3);

      await FirebaseFirestore.instance
          .collection(busName)
          .doc('Holder')
          .collection('Passenger Manifest')
          .doc('Holder')
          .collection(busID)
          .doc(date)
          .set({'value': date});

      await dbCollection
          .doc(mobileNum)
          .collection('Transaction')
          .doc(ref.toString())
          .set(data);
      await FirebaseFirestore.instance
          .collection('Bus')
          .doc(busID)
          .collection('Transaction')
          .doc(ref.toString())
          .set(data2);
      //await userCollection.doc(uid).set(data);

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
