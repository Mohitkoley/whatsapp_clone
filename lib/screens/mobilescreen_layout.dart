import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/select_contacts/screen/select_contact_screen.dart';
import 'package:whatsapp_clone/widget/contacts_list.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              title: const Text(
                "WhatsApp",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.grey,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  color: Colors.grey,
                  onPressed: () {},
                )
              ],
              bottom: const TabBar(
                indicatorColor: tabColor,
                unselectedLabelColor: Colors.grey,
                labelColor: tabColor,
                indicatorWeight: 4,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Chats"),
                  Tab(text: "Status"),
                  Tab(text: "Calls")
                ],
              )),
          body: ContactsLists(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, SelectContact.routeName);
            },
            child: Icon(Icons.comment, color: Colors.white),
            backgroundColor: tabColor,
          ),
        ));
  }
}
