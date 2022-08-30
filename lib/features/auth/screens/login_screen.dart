import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  Country? _country;

  pickCountry() {
    return showCountryPicker(
        context: context,
        onSelect: (country) {
          setState(() {
            _country = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isNotEmpty && _country != null) {
      if (phoneNumber.length < 9) {
        showSnackBar(
          context: context,
          content: "Phone number must be at least 9 digits",
        );
      } else {
        ref
            .read(AuthControllerProvider)
            .signInwithPhone(context, "+${_country!.phoneCode}$phoneNumber");
      }
    } else {
      showSnackBar(context: context, content: "Fill out all the fields");
    }
  }

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    final Size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          centerTitle: true,
          title: Text("Enter your phone number"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("WhatsApp will need to verify your number"),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: tabColor,
                    ),
                    onPressed: pickCountry,
                    child: const Text(
                      "pick country",
                    )),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (_country != null)
                      Text(
                        "+${_country!.phoneCode}",
                        style: const TextStyle(color: tabColor),
                      ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: Size.width * 0.7,
                      child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          decoration:
                              const InputDecoration(hintText: "Phone Number")),
                    ),
                  ],
                ),
                isKeyBoard
                    ? SizedBox(
                        height: Size.height * 0.2,
                      )
                    : SizedBox(height: Size.height * 0.6),
                SizedBox(
                    width: 90,
                    child:
                        CustomButton(text: "next", onPressed: sendPhoneNumber))
              ],
            ),
          ),
        ));
  }
}
