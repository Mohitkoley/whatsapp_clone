// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/model/user_model.dart';
import 'package:whatsapp_clone/screens/mobilescreen_layout.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  final auth1 = FirebaseAuth.instance;

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (String verificationId, int? token) async {
            await Navigator.pushNamed(context, OTPScreen.routeName,
                arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (String VerificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required ProviderRef ref,
      required File? profilePic,
      required BuildContext context}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      String photoUrl = "https://images8.alphacoders.com/665/665330.png";

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase("ProfitePic/$uid", profilePic);
      }

      final user = UserModel(
        name: name,
        isOnline: true,
        profilePic: photoUrl,
        uid: uid,
        phoneNumber: auth.currentUser!.phoneNumber.toString(),
        groupId: <String>[],
      );
      firestore.collection('Users').doc(uid).set(user.toMap());

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MobileScreenLayout()),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection("Users").doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }

    return user;
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection("Users")
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void setUserState(bool isOnline) async {
    await firestore.collection("Users").doc(auth.currentUser?.uid).update({
      "isOnline": isOnline,
    });
  }
}
