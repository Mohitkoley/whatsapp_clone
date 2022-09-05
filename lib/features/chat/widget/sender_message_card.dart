// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widget/display_text_image_gif.dart';

class SenderMessagesCard extends StatelessWidget {
  String message;
  String time;
  MessageEnum type;
  SenderMessagesCard({
    Key? key,
    required this.message,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: MediaQuery.of(context).size.width - 45,
          // minHeight: MediaQuery.of(context).size.height - 560,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: senderMessageColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                  child: DisplayTextImageGif(message: message, type: type),
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 5,
                          bottom: 25,
                        )),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(children: [
                  Text(time,
                      style: TextStyle(fontSize: 13, color: Colors.white60)),
                  const SizedBox(width: 5),
                  const Icon(Icons.done_all, size: 20, color: Colors.white)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
