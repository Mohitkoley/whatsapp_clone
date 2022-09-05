import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/select_contacts/screen/select_contact_screen.dart';
import 'package:whatsapp_clone/widget/contacts_list.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(AuthControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.read(AuthControllerProvider).setUserState(false);
        break;
    }
  }

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
              Navigator.pushNamed(context, SelectContactScreen.routeName);
            },
            child: Icon(Icons.comment, color: Colors.white),
            backgroundColor: tabColor,
          ),
        ));
  }
}
