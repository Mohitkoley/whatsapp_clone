import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/Loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/features/chat/screen/mobile_chatscreen.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';

class ContactsLists extends ConsumerWidget {
  const ContactsLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("No Chats\nStart a conversation .",
                      style: TextStyle(fontSize: 20, color: greyColor)));
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  var chatContact = snapshot.data![index];
                  //Map<String, dynamic> infop = info[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MobileChatScreen.routeName,
                              arguments: {
                                "name": chatContact.name,
                                "uid": chatContact.contactId,
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(chatContact.name,
                                style: TextStyle(fontSize: 16)),
                            subtitle: Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text(chatContact.lastMessage,
                                    style: TextStyle(fontSize: 15))),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(chatContact.profilePic),
                            ),
                            trailing: Text(
                                DateFormat.Hm().format(chatContact.timeSent),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                          ),
                        ),
                      ),
                      const Divider(
                        color: dividerColor,
                        indent: 85,
                      )
                    ],
                  );
                }));
          }),
    );
  }
}
