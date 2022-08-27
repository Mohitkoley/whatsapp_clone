import "package:flutter/material.dart";
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  navigateToLoginScreen(BuildContext context) {
    return Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Center(
          child: Text("Welcome to WhatsApp",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: Size.height / 9),
        Image.asset("assets/bg.png", height: 340, width: 340, color: tabColor),
        SizedBox(height: Size.height / 9),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            textAlign: TextAlign.center,
            "Read our Privacy and policy. tap Agree and continue to accept the terms of Service.",
            style: TextStyle(color: greyColor),
          ),
        ),
        SizedBox(
            width: Size.width * 0.75,
            child: CustomButton(
                text: "AGREE AND CONTINUE",
                onPressed: () => navigateToLoginScreen(context)))
      ],
    )));
  }
}
