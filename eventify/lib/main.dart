import 'package:eventify/config/app_router.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: true,
      title: 'Material App',
      theme: ThemeData(fontFamily: "Poppins"),
    );
  }
}
