// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  TextEditingController _messageController = TextEditingController();
  bool isShow = false;

  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) async {
    ref
        .read(chatControllerProvider)
        .sendFileMessage(context, file, widget.recieverUserId, messageEnum);
  }

  void selectImage() async {
    File? image = await pickImagefromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void sendTextMessage() async {
    debugPrint("sendTextMessage called");
    if (isShow) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
          );
      setState(() {
        _messageController.clear();
        // isShow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messageController,
            onChanged: (val) {
              if (val.isNotEmpty) {
                setState(() {
                  isShow = true;
                });
              } else {
                setState(() {
                  isShow = false;
                });
              }
            },
            decoration: InputDecoration(
              hintText: "Message",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: isShow
                  ? IconButton(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: 100,
                        child: Row(children: [
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.gif,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                        ]),
                      ),
                    ),
              suffixIcon: isShow
                  ? IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    )
                  : SizedBox(
                      width: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: selectImage,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ]),
                    ),
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            right: 2,
            left: 2,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF128C73),
            radius: 25,
            child: IconButton(
              onPressed: sendTextMessage,
              icon: Icon(
                isShow ? Icons.send : Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
