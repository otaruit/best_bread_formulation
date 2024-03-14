import 'package:best_bread_formulation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/view/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext yacontext) {
    return MaterialApp(
      title: '最強のパン配合',
      theme: AppTheme.theme,
      home: 
            const HomeView()
          
    );
  }
}