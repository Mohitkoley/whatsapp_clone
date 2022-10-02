import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/provider/message_reply_provider.dart';
import 'package:whatsapp_clone/features/chat/widget/display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);

    return Container(
      decoration: const BoxDecoration(
          color: senderMessageColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      width: 350,
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Text(
                messageReply!.isMe ? "Me" : "Opposite",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.close,
                size: 16,
              ),
              onTap: () => cancelReply(ref),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        DisplayTextImageGif(
            message: messageReply.message, type: messageReply.messageEnum),
      ]),
    );
  }
}
