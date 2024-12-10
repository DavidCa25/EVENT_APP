import 'package:eventify/config/app_router.dart';
import 'package:eventify/domain/datasources/eventify_datasources.dart';
import 'package:eventify/domain/providers/eventify_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventifyProvider(datasource: EventifyDatasources()))
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: true,
        title: 'Material App',
        theme: ThemeData(fontFamily: "Poppins"),
      ),
    );
  }
}
