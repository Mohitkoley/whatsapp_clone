import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/colors.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.077,
        width: MediaQuery.of(context).size.width * 0.25,
        padding: EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: webAppBarColor,
            border: Border(right: BorderSide(color: dividerColor))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images4.alphacoders.com/116/thumb-1920-1160235.jpg")),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {},
              ),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
            ],
          )
        ]));
  }
}
