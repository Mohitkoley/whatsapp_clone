import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
        child: CircularProgressIndicator(
      color: primaryColor,
    ));
  }
}
