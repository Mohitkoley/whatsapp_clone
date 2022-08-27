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
        if (messages[index]["isMe"] == true) {
          //MyMessages
          return MyMessagesCard(
              message: messages[index]['text'].toString(),
              time: messages[index]['time'].toString());
        }
        return SenderMessagesCard(
            message: messages[index]['text'].toString(),
            time: messages[index]['time'].toString());
      },
    );
  }
}
