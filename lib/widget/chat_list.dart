import "package:flutter/material.dart";
import "package:whatsapp_clone/info.dart";
import 'package:whatsapp_clone/widget/my_messages_card.dart';
import 'package:whatsapp_clone/widget/sender_message_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      controller: ScrollController(),
      itemBuilder: (context, index) {
        final Map<String, dynamic> message = messages[index];
        if (message["isMe"] == true) {
          //MyMessages
          return MyMessagesCard(
              message: message['text'].toString(),
              time: message['time'].toString());
        }
        return SenderMessagesCard(
            message: message['text'].toString(),
            time: message['time'].toString());
      },
    );
  }
}
