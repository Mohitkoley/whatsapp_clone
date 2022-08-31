import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const routeName = "/user-information-screen";
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
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

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref
          .read(AuthControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
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
                child: IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 25,
                    onPressed: selectImage)),
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
              IconButton(icon: Icon(Icons.done), onPressed: storeUserData),
            ],
          )
        ]),
      )),
    );
  }
}
