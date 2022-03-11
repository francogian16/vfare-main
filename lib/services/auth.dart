import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_vfare_app/services/database.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getCode(String mobileNum) async {
    await auth.signInWithPhoneNumber('+63 $mobileNum');
    return 'Success';
  }

  Future<String> loginCode(String mobileNum, String code) async {
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber('+63 $mobileNum');
    await confirmationResult.confirm(code);

    return 'Success';
  }

  Future<String> verifyCode(String mobileNum, String code, String firstName,
      String lastName, BuildContext context) async {
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber('+63 $mobileNum');
    UserCredential userCredential = await confirmationResult.confirm(code);
    User? user = userCredential.user;
    await DatabaseService(uid: user!.uid)
        .addUserProfile(mobileNum, firstName, lastName, 'passenger')
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    });

    return 'Success';
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);

    return 'Success';
  }

  Future<String> logout() async {
    auth.signOut();

    return "Success";
  }

  Future<String> registerWithEmailAndPassword(
      String email,
      String password,
      String mobileNum,
      String firstName,
      String lastName,
      BuildContext context) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // await DatabaseService(uid: user!.uid)
      //  .addUserProfile(email, mobileNum, firstName, lastName, 'passenger')
      // .then((value) {
      // ScaffoldMessenger.of(context)
      // .showSnackBar(SnackBar(content: Text(value)));
      //});

      //await DbHelper2(uid: user!.uid).addUserData(firstName, lastName, role);
      return 'Success';
    } catch (e) {
      return 'Fail';
    }
  }
}
