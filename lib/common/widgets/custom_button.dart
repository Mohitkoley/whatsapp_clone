// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp_clone/colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  final VoidCallback onPressed;
  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(text, style: TextStyle()),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: tabColor,
          minimumSize: Size(double.infinity, 50),
        ));
  }
}
