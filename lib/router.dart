import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/features/select_contacts/screen/select_contact_screen.dart';
import 'package:whatsapp_clone/features/chat/screen/mobile_chatscreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OTPScreen.routeName:
      final VerificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => OTPScreen(
                verificationID: VerificationId,
              ));
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());
    case SelectContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => SelectContactScreen());
    case MobileChatScreen.routeName:
      final userData = settings.arguments as Map<String, dynamic>;
      String name = userData['name'];
      String uid = userData["uid"];
      return MaterialPageRoute(
          builder: (context) => MobileChatScreen(name: name, uid: uid));
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: ErrorScreen(error: "No such Screen"),
              ));
  }
}
