// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/Loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/model/message_model.dart';
import 'package:whatsapp_clone/widget/my_messages_card.dart';
import 'package:whatsapp_clone/widget/sender_message_card.dart';

class ChatList extends ConsumerWidget {
  String recieverUserId;
  ChatList({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref.watch(chatControllerProvider).chatStream(recieverUserId),
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
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            controller: ScrollController(),
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                //MyMessages
                return MyMessagesCard(
                    message: messageData.text, time: timeSent);
              }
              return SenderMessagesCard(
                  message: messageData.text, time: timeSent);
            },
          );
        });
  }
}
