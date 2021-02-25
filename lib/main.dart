import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perial/DataLayer/Providers/UserProvider.dart';
import 'package:perial/DataLayer/Providers/feedback_position_provider.dart';
import 'package:perial/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
//import 'package:riverpod/riverpod.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackPositionProvider())
      ],
      child: MyApp(),
    ),
  );
  /* ProviderScope(child: MyApp())); */
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
