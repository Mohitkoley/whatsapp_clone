import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';

class SenderMessagesCard extends StatelessWidget {
  String message;
  String time;
  SenderMessagesCard({Key? key, required this.message, required this.time})
      : super(key: key);

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
                  child: Text(message),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 30,
                    top: 5,
                    bottom: 20,
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
