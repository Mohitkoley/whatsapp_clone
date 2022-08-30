import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';

class UserInformationScreen extends StatefulWidget {
  static const routeName = "/user-information-screen";
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImagefromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Stack(children: [
            image == null
                ? const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://images8.alphacoders.com/665/665330.png"),
                  )
                : CircleAvatar(
                    radius: 64,
                    backgroundImage: FileImage(image!),
                  ),
            const SizedBox(height: 10),
            Positioned(
                bottom: -10,
                left: 80,
                child:
                    IconButton(icon: const Icon(Icons.add), onPressed: () {})),
          ]),
          Row(
            children: [
              Container(
                  width: Size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: "Enter your name"),
                  )),
              IconButton(icon: Icon(Icons.done), onPressed: selectImage),
            ],
          )
        ]),
      )),
    );
  }
}
