// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message_model.dart';
import 'package:whatsapp_clone/model/user_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String recieverUsername,
    required String senderUsername,
    required MessageEnum messageType,
  }) async {
    final message = Message(
        senderId: auth.currentUser!.uid,
        recieverId: recieverUserId,
        text: text,
        type: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);
    //user -> sender id -> reciever id -> message -> message id -> store message
    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Chats")
        .doc(recieverUserId)
        .collection("Messages")
        .doc(messageId)
        .set(message.toMap());
    //user -> reciever id -> sender id -> message -> message id -> store message
    await firestore
        .collection("Users")
        .doc(recieverUserId)
        .collection("Chats")
        .doc(auth.currentUser!.uid)
        .collection("Messages")
        .doc(messageId)
        .set(message.toMap());
  }

  void _saveDataToContactsSubcollection(
      UserModel senderUserData,
      UserModel recieverUserData,
      String text,
      DateTime timeSent,
      String recieverUserId) async {
    //users -> reciever user id ->chat id -> current user id -> set data
    ChatContact recieverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);
    await firestore
        .collection("Users")
        .doc(recieverUserId)
        .collection("Chats")
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());
    //users -> current user idc ->chat id -> reciever user id -> set data
    ChatContact senderChatContact = ChatContact(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text);
    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Chats")
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void sendTextmessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUserData,
  }) async {
    //user -> sender id -> reciever id -> message -> message id -> store message
    try {
      DateTime timeSent = DateTime.now();
      UserModel recieverUserData;
      DocumentSnapshot<Map<String, dynamic>> userDataMap =
          await firestore.collection("Users").doc(recieverUserId).get();

      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactsSubcollection(
          senderUserData, recieverUserData, text, timeSent, recieverUserId);

      var messageId = const Uuid().v1();

      _saveMessageToMessageSubcollection(
          recieverUserId: recieverUserId,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          recieverUsername: recieverUserData.name,
          senderUsername: senderUserData.name,
          messageType: MessageEnum.text);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
