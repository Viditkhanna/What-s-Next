import 'package:flutter/material.dart';
import 'package:whats_next/resources/theme.dart';
import 'package:whats_next/ui/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: HomePage(),
    );
  }
}
