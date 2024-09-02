import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/spotify_custom_field.dart';
import 'package:client/features/auth/view/widgets/authSpotifyButton.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool buttonEnable = false;

  void _updateButtonSate(){
    setState(() {
      buttonEnable = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }
  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonSate);
    passwordController.addListener(_updateButtonSate);
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        authViewModelProvider.select((value) => value?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (_) => false);
          },
          error: (error, st) {
            showSnackBar(context, error.toString(), false);
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  // onChanged: (value) {
                  //
                  // },
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email or username",
                        style: spotifyHeadings,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SpotifyCustomFields.SpotifyCustomFields(
                        controller: emailController,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Password",
                        style: spotifyHeadings,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SpotifyCustomFields.SpotifyCustomFields(
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: AuthSpotifyButton(
                          isEnable: buttonEnable,
                          buttonText: "Login",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                            } else {
                              showSnackBar(context, "Missing fields!", false);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Pallete.greyColor.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Log in without password",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Pallete.whiteColor),
                          ),
                        ),
                      )
                      // RichText(
                      //     text: TextSpan(
                      //         text: "Don't have an account?",
                      //         style: Theme.of(context).textTheme.titleMedium,
                      //         children: [
                      //       TextSpan(
                      //           text: ' Sign Up',
                      //           style: TextStyle(
                      //             color: Pallete.gradient2,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               Navigator.pop(context);
                      //             }),
                      //     ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
