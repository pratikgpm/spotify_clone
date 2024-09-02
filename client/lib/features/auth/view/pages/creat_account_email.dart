import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../../../../core/theme/app_pallete.dart';

class CreatAccountEmail extends StatefulWidget {
  CreatAccountEmail({super.key});

  @override
  State<CreatAccountEmail> createState() => _CreatAccountEmailState();
}

class _CreatAccountEmailState extends State<CreatAccountEmail> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailValid = false;
  String email = "";

  void _validateEmail(String value) {
    setState(() {
      email = value;
      _isEmailValid = isEmail(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.transparentColor,
        title: const Text(
          "Create Account",
          style: TextStyle(
              fontSize: 16,
              color: Pallete.whiteColor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              const Text(
                "What's your email\n address?",
                style: TextStyle(
                    height: 1.1,
                    color: Pallete.whiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(color: Pallete.whiteColor),
                  cursorColor: Pallete.whiteColor,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      fillColor: Pallete.spotifySecondGrey,
                      filled: true,
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 0)),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 0))),
                  onChanged: (value) => _validateEmail(emailController.text),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "You'll need to confirm this email later.",
                style: TextStyle(color: Pallete.whiteColor, fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            _isEmailValid
                                ? Pallete.whiteColor
                                : Pallete.spotifySecondGrey),
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                                horizontal: 36, vertical: 15)
                        )
                    ),
                    onPressed: () {
                      _isEmailValid
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage(
                                      emailController: emailController,
                                  )
                              ))
                          : null;
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          color: Pallete.backgroundColor, fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
