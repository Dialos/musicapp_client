import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp_client/core/theme/color_palette.dart';
import 'package:musicapp_client/core/widgets/loader.dart';
import 'package:musicapp_client/core/widgets/utils.dart';
import 'package:musicapp_client/features/auth/view/pages/login_page.dart';
import 'package:musicapp_client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:musicapp_client/features/auth/view/widgets/custom_field.dart';
import 'package:musicapp_client/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;

    ref.listen(
      authViewmodelProvider,
      (_, next) {
        next?.when(
            data: (data) {
              showSnackBar(
                context,
                'Account created successfully! Please login.',
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            error: (error, st) {
              showSnackBar(
                context,
                error.toString(),
              );
            },
            loading: () {});
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up.",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomField(
                      hintText: "Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomField(
                      hintText: "Password",
                      controller: pwController,
                      isObscuredText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      buttonText: "Sign up",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewmodelProvider.notifier)
                              .signUpUser(
                                  email: emailController.text,
                                  password: pwController.text,
                                  name: nameController.text);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: Palette.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
