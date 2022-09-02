import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/features/chat/screen/mobile_chatscreen.dart';

class ContactsLists extends StatelessWidget {
  const ContactsLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: info.length,
          itemBuilder: ((context, index) {
            Map<String, dynamic> infop = info[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MobileChatScreen(name: "Mohit", uid: "2333")));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(infop['name'].toString(),
                          style: TextStyle(fontSize: 16)),
                      subtitle: Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(infop['message'].toString(),
                              style: TextStyle(fontSize: 15))),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(infop['profilePic'].toString()),
                      ),
                      trailing: Text(infop['time'].toString(),
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ),
                  ),
                ),
                const Divider(
                  color: dividerColor,
                  indent: 85,
                )
              ],
            );
          })),
    );
  }
}
