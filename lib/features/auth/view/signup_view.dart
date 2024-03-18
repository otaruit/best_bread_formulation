import 'package:best_bread_formulation/constants/ui_constants.dart';
import 'package:best_bread_formulation/features/auth/controller/auth_controller.dart';
import 'package:best_bread_formulation/features/auth/view/login_view.dart';
import 'package:best_bread_formulation/features/auth/widgets/auth_field.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final appbar = UIConstants.appBar();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: 'メールアドレス',
                ),
                SizedBox(height: 20),
                AuthField(
                  controller: passwordController,
                  hintText: 'パスワード',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signUp,
                  child: const Text(
                    '登録',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.redColor,
                    foregroundColor: Pallete.backgroundColor,
                    shape: const StadiumBorder(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'ログイン',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 17,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, LoginView.route());
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
