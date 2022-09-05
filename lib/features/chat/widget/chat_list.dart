// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/Loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/features/chat/widget/my_messages_card.dart';
import 'package:whatsapp_clone/features/chat/widget/sender_message_card.dart';
import 'package:whatsapp_clone/model/message_model.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({
    required this.recieverUserId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final messageController = ScrollController();

  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream:
            ref.watch(chatControllerProvider).chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.data == null) {
            const Center(
              child: Text(
                "Send hi !",
                style: TextStyle(fontSize: 25, color: messageColor),
              ),
            );
          }
          //as far it can scroll ,just scroll it
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            controller: messageController,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                //MyMessages
                return MyMessagesCard(
                    message: messageData.text,
                    time: timeSent,
                    type: messageData.type);
              }
              return SenderMessagesCard(
                  message: messageData.text,
                  time: timeSent,
                  type: messageData.type);
            },
          );
        });
  }
}
