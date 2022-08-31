import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/Loader.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';
import 'package:whatsapp_clone/widget/contacts_list.dart';

class SelectContact extends ConsumerWidget {
  static const String routeName = "/select-contact";
  const SelectContact({Key? key}) : super(key: key);
  void selectContact(
      BuildContext context, Contact selectedContact, WidgetRef ref) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Contacts"),
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: ref.watch(getContactProvider).when(
            data: (contactsLists) => ListView.builder(
                  itemCount: contactsLists.length,
                  itemBuilder: (context, index) {
                    final contact = contactsLists[index];
                    return InkWell(
                      onTap: () => selectContact(context, contact, ref),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(contact.displayName,
                              style: const TextStyle(fontSize: 18)),
                          leading: contact.photo == null
                              ? CircleAvatar(
                                  child: Text(contact.displayName[0]),
                                  backgroundColor: Colors.grey,
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: MemoryImage(contact.photo!),
                                ),
                        ),
                      ),
                    );
                  },
                ),
            error: (err, tracr) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => Loader()));
  }
}
