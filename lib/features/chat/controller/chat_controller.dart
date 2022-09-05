// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message_model.dart';

final chatControllerProvider = Provider((ref) {
  debugPrint("chatControllerProvider called");
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(ref: ref, chatRepository: chatRepository);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChat(recieverUserId);
  }

  sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    debugPrint("sendTextMessage called");
    ref.read(userDataAuthProvider).when(
          data: (userData) {
            if (userData != null) {
              chatRepository.sendTextmessage(
                  context: context,
                  text: text,
                  recieverUserId: recieverUserId,
                  senderUserData: userData);
            } else {
              showSnackBar(context: context, content: "userData is null");
            }
          },
          loading: () => showSnackBar(context: context, content: "loading"),
          error: (error, stackTrace) => showSnackBar(
              context: context, content: "error: $error, $stackTrace"),
        );
  }

  sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
  ) {
    debugPrint("sendTextMessage called");
    ref.read(userDataAuthProvider).when(
          data: (userData) {
            if (userData != null) {
              chatRepository.sendFileMessage(
                context: context,
                file: file,
                recieverUserId: recieverUserId,
                senderUserData: userData,
                messageEnum: messageEnum,
                ref: ref,
              );
            } else {
              showSnackBar(context: context, content: "userData is null");
            }
          },
          loading: () => showSnackBar(context: context, content: "loading"),
          error: (error, stackTrace) => showSnackBar(
              context: context, content: "error: $error, $stackTrace"),
        );
  }
}
