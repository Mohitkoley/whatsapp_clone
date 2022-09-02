// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/widget/bottom_chat_field.dart';
import 'package:whatsapp_clone/model/user_model.dart';
import 'package:whatsapp_clone/widget/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  final String name;
  final String uid;
  static const String routeName = "/mobile-chat-screen";
  MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<UserModel>(
              stream: ref.read(AuthControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Column(children: [
                  Text(name),
                  Text(snapshot.data!.isOnline ? "Online" : "offline",
                      style: const TextStyle(fontSize: 13))
                ]);
              }),
          centerTitle: false,
          actions: [
            IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: Column(children: [
          const Expanded(child: ChatList()),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: BottomChatField(recieverUserId: uid),
          ),
        ]));
  }
}
