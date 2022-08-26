import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/widget/chat_list.dart';

class MobileChatScreen extends StatelessWidget {
  const MobileChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(info[0]['name'].toString()),
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
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: const [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                    ]),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.money,
                            color: Colors.grey,
                          ),
                        ]),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ]));
  }
}
