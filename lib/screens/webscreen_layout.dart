import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/widget/chat_list.dart';
import 'package:whatsapp_clone/widget/contacts_list.dart';
import 'package:whatsapp_clone/widget/web_profilebar.dart';
import 'package:whatsapp_clone/widget/web_search_bar.dart';
import 'package:whatsapp_clone/widget/webchat_appbar.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              const WebProfileBar(),
              WebSearchBar(),
              const ContactsLists(),
            ]),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/backgroundImage.png"))),
            child: Column(
              children: [
                const WebChatAppBar(),
                const Expanded(child: ChatList()),
                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: chatBarMessage,
                        border:
                            Border(bottom: BorderSide(color: dividerColor))),
                    child: Row(
                      children: [
                        IconButton(
                            color: Colors.grey,
                            icon: Icon(Icons.emoji_emotions_outlined),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.attach_file),
                            color: Colors.grey,
                            onPressed: () {}),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 15),
                              child: TextField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: searchBarColor,
                                      hintText: "Type a message"))),
                        ),
                        IconButton(icon: Icon(Icons.mic), onPressed: () {}),
                      ],
                    )),
              ],
            ))
      ],
    ));
  }
}
