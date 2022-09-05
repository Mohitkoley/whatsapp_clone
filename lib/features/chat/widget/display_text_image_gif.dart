// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import "package:cached_network_image/cached_network_image.dart";

class DisplayTextImageGif extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGif({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(message, style: TextStyle(fontSize: 20, color: Colors.white))
        : CachedNetworkImage(imageUrl: message);
  }
}
