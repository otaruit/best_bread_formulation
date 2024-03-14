import 'package:best_bread_formulation/common/loading_page.dart';
import 'package:best_bread_formulation/features/auth/controller/auth_controller.dart';
import 'package:best_bread_formulation/features/auth/view/signup_view.dart';
import 'package:best_bread_formulation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/view/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: '最強のパン配合',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (e, st) => const LoadingPage(),
            loading: () => const LoadingPage()));
  }
}
