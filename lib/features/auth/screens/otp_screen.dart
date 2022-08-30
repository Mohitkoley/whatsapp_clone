import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  final String verificationID;
  static const String routeName = "/otp-screen";
  const OTPScreen({Key? key, required this.verificationID}) : super(key: key);

  void verifyOTP(BuildContext context, String userOTP, WidgetRef ref) {
    ref
        .read(AuthControllerProvider)
        .verifyOTP(context, verificationID, userOTP);
  }

  Widget build(BuildContext context, WidgetRef ref) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Verifying Number"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: Size.width * 0.8,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('Enter WhatsApp OTP'),
              SizedBox(
                height: Size.height * 0.5,
                child: TextField(
                  onChanged: (val) {
                    if (val.length == 6) {
                      verifyOTP(context, val.trim(), ref);
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "- - - - - -",
                      hintStyle: TextStyle(fontSize: 30)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
