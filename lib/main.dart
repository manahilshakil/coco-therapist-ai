import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'providers/gemini_provider.dart';
import 'screens/home_screen.dart';

const apiKey = 'AIzaSyC3XMBl2g3PwqqNw7RFsKWODSPvEBljjDA';

void main() {
  /// Initialize Gemini
  Gemini.init(apiKey: apiKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeminiProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Pookie Therapist',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
