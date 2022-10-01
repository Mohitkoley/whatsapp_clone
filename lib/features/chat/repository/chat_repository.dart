// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message_model.dart';
import 'package:whatsapp_clone/model/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  debugPrint("chatRepositoryProvider called");
  return ChatRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getContacts() {
    return firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection("Users")
            .doc(chatContact.contactId)
            .get();

        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage));
      }
      return contacts;
    });
  }

  Stream<List<Message>> getChat(String recieverUserId) {
    return firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Chats")
        .doc(recieverUserId)
        .collection("Messages")
        .orderBy("timeSent")
        .snapshots()
        .asyncMap((messages) async {
      List<Message> chatMessages = [];
      for (var document in messages.docs) {
        var message = Message.fromMap(document.data());
        chatMessages.add(message);
      }
      return chatMessages;
    });
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String recieverUsername,
    required String senderUsername,
    required MessageEnum messageType,
  }) async {
    debugPrint("_saveMessageToMessageSubcollection called");
    try {
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    try {
      debugPrint("_saveDataToContactsSubcollection called");
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendTextmessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUserData,
  }) async {
    debugPrint("sendTextMessage called");
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
        messageType: MessageEnum.text,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
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
          senderUserData, recieverUserData, "GIF", timeSent, recieverUserId);

      var messageId = const Uuid().v1();

      _saveMessageToMessageSubcollection(
          recieverUserId: recieverUserId,
          text: gifUrl,
          timeSent: timeSent,
          messageId: messageId,
          recieverUsername: recieverUserData.name,
          senderUsername: senderUserData.name,
          messageType: MessageEnum.gif);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      String messageId = const Uuid().v1();

      String fileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            "Chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId",
            file,
          );
      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.text:
          contactMsg = "Sent a text message";
          break;
        case MessageEnum.image:
          contactMsg = "📷 Photo";
          // TODO: Handle this case.
          break;
        case MessageEnum.audio:
          contactMsg = "🎧 Audio";
          // TODO: Handle this case.
          break;
        case MessageEnum.video:
          contactMsg = "🎥 Video";
          // TODO: Handle this case.
          break;
        case MessageEnum.gif:
          contactMsg = "🎥 Gif";
          // TODO: Handle this case.
          break;
      }

      var userDataMap =
          await firestore.collection("Users").doc(recieverUserId).get();
      UserModel recieverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactsSubcollection(senderUserData, recieverUserData,
          contactMsg, timeSent, recieverUserId);

      _saveMessageToMessageSubcollection(
          recieverUserId: recieverUserId,
          text: fileUrl,
          timeSent: timeSent,
          messageId: messageId,
          recieverUsername: recieverUserData.name,
          senderUsername: senderUserData.name,
          messageType: messageEnum);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
