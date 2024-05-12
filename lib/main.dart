import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/pages/welcome_page.dart';
import 'package:sushi_app/provider/cart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sushi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color.fromARGB(255, 138, 60, 55),
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
      home: const WelcomePage(),
    );
  }
}
