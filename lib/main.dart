import 'package:flutter/material.dart';
import 'package:gemtest/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'providers/gemini_provider.dart';
import 'screens/home_screen.dart';

const apiKey = 'your-api-key';

void main() {
  /// Initialize Gemini
  Gemini.init(apiKey: apiKey);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeminiProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CocoAI',
      themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 185, 151, 193)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(color: Color(0xFF2C2C2E)),
      ),
      home: HomeScreen(),
    );
  }
}
