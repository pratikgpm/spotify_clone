import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/spotify_custom_field.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  final TextEditingController emailController;

  const SignupPage({super.key, required this.emailController});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
            showSnackBar(context, "AccountCreated Sucessfully", true);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          error: (error, st) {
            showSnackBar(context, error.toString(), false);
          },
          loading: () {});
    });
    //   print(val);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        title: const Text(
          "Create Account",
          style: TextStyle(
              fontSize: 16,
              color: Pallete.whiteColor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "What's your name?",
                        style: TextStyle(
                            height: 1.1,
                            color: Pallete.whiteColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      SpotifyCustomFields.SpotifyCustomFields(
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Create a password ",
                        style: TextStyle(
                            height: 1.1,
                            color: Pallete.whiteColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      SpotifyCustomFields.SpotifyCustomFields(
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 80,
                      ),

                      Center(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Pallete.whiteColor),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 36, vertical: 15)
                                )
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .singUpUser(
                                        name: nameController.text,
                                        email: widget.emailController.text,
                                        password: passwordController.text);
                              }
                            },
                            child: const Text(
                              "Create account",
                              style: TextStyle(
                                  color: Pallete.backgroundColor, fontSize: 16),
                            )),
                      ),
                      // AuthGradientButton(
                      //   buttonText: "Sign up",
                      //   onTap: () async {
                      //     if (formKey.currentState!.validate()) {
                      //       await ref
                      //           .read(authViewModelProvider.notifier)
                      //           .singUpUser(
                      //               name: nameController.text,
                      //               email: widget.userEmail,
                      //               password: passwordController.text);
                      //     }
                      //   },
                      // ),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      // RichText(
                      //     text: TextSpan(
                      //         text: "Already have an account?",
                      //         style: Theme.of(context).textTheme.titleMedium,
                      //         children: [
                      //       TextSpan(
                      //           text: ' Sign In',
                      //           style: const TextStyle(
                      //             color: Pallete.gradient2,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => LoginPage(),
                      //                   ));
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
