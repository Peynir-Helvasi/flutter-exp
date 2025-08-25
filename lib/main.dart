import 'package:demo/shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'controllers/nav_controller.dart';

void main() async{
  await dotenv.load(fileName: ".env");

  runApp(
    // all code under provider 
    MultiProvider(
      providers:  [ChangeNotifierProvider(create: (_) => NavController())],
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Film Rehberi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeShell(), 
    );
  }
}
