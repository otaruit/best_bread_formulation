import 'package:best_bread_formulation/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'features/home/view/home_view.dart';

void main() {
  runApp(
  MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '最強のパン配合',
      theme: AppTheme.theme,
      home: 
            const HomeView()
          
    );
  }
}