// import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/colors.dart';
import "dart:io";
import "package:flutter_dotenv/flutter_dotenv.dart";

Future load() async {
  await dotenv.load(fileName: ".env");
}

showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      backgroundColor: tabColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Text(content, style: const TextStyle(color: Colors.white))));
}

Future<File?> pickImagefromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideofromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

// Future<GiphyGif?> pickGif(BuildContext context) async {
//   GiphyGif? gif;
//   //yrZP6TYNUYQthZJ27RQitFXzFuvXF3Qj
//   try {
//     String apiKey = "yrZP6TYNUYQthZJ27RQitFXzFuvXF3Qj";
//     gif = await Giphy.getGif(context: context, apiKey: apiKey);
//   } catch (e) {
//     showSnackBar(context: context, content: e.toString());
//   }
//   return gif;
// }

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    load();
    //String apiKey = dotenv.env['GIPHY_API_KEY'];
    gif = await GiphyGet.getGif(
        context: context,
        apiKey: "yrZP6TYNUYQthZJ27RQitFXzFuvXF3Qj", //apiKey
        lang: GiphyLanguage.english);
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}
