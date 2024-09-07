import 'package:flutter/material.dart';
import 'package:utopia_store/utils/constants.dart';
import 'package:utopia_store/web_view/screen/web_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utopia Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.mainColor),
        useMaterial3: true,
      ),
      home: const WebViewScreen(url: Constants.siteUrL),
    );
  }
}
