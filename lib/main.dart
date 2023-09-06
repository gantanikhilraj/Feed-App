import 'package:flutter/material.dart';
import 'package:myfeedapp/screens/display_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myfeedapp/screens/input_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DisplayData(),
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        DisplayData.id: (context) => const DisplayData(),
      },
    );
  }
}
