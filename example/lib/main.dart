import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/new.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Accessibly()..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Accessibly>(
      builder: (context, accessibilitySettings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Accessibly Features',
          themeMode: accessibilitySettings.systemMode
              ? ThemeMode.system
              : (accessibilitySettings.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light),
          darkTheme: accessibilitySettings.darkTheme,
          theme: accessibilitySettings.lightTheme,
          home: const MyWidget(),
        );
      },
    );
  }
}
