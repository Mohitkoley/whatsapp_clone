import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';

class MyMessagesCard extends StatelessWidget {
  String message;
  String time;
  MyMessagesCard({Key? key, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minHeight: MediaQuery.of(context).size.height - 560,
          //maxHeight: MediaQuery.of(context).size.height - 5
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: messageColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 30, top: 5, bottom: 20),
                child: Text(message),
              ),
              Positioned(
                bottom: 4,
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
