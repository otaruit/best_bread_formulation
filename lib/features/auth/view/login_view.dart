import 'package:best_bread_formulation/constants/ui_constants.dart';
import 'package:best_bread_formulation/features/auth/controller/auth_controller.dart';
import 'package:best_bread_formulation/features/auth/view/signup_view.dart';
import 'package:best_bread_formulation/features/auth/widgets/auth_field.dart';
import 'package:best_bread_formulation/features/formulation/widgets/formulation_list.dart';
import 'package:best_bread_formulation/features/home/view/home_view.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginView(),
      );
  LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final appbar = UIConstants.appBar();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref.read(authControllerProvider.notifier).login(
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
            child: Column(children: [
              AuthField(
                controller: emailController,
                hintText: 'メールアドレス',
              ),
              SizedBox(
                height: 20,
              ),
              AuthField(
                controller: passwordController,
                hintText: 'パスワード',
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text(
                  'ログイン',
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
                  text: '登録',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 17,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, SignUpView.route());
                    },
                )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                  text: 'ログアウト',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 17,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ref.read(authControllerProvider.notifier).logout(context);
                    },
                )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                    text: TextSpan(
                  text: 'ホーム',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 17,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      HomeView.route();
                    },
                )),
              )
            ]),
          )),
        ));
  }
}
