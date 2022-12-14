// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/model/user_model.dart';
import 'package:whatsapp_clone/features/chat/screen/mobile_chatscreen.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      bool isFound = false;
      QuerySnapshot<Map<String, dynamic>> userCollection =
          await FirebaseFirestore.instance.collection("Users").get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in userCollection.docs) {
        UserModel userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
            "name": userData.name,
            "uid": userData.uid,
          });
        }
      }
      if (!isFound) {
        showSnackBar(context: context, content: "User not found");
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
