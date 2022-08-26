import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';

class WebChatAppBar extends StatelessWidget {
  const WebChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.077,
      padding: EdgeInsets.all(8),
      color: webAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "https://images4.alphacoders.com/116/thumb-1920-1160235.jpg"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(info[0]['name'].toString(), style: TextStyle(fontSize: 18)),
          ]),
          Row(children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ])
        ],
      ),
    );
  }
}
