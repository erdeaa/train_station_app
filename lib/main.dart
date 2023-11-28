import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_station_app/models/list.dart';
import 'package:train_station_app/screens/auth.dart';
import 'package:train_station_app/widgets/bottom_nav.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListModelAdapter());
  await Hive.openBox<ListModel>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Station App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 5,
            backgroundColor: Color.fromARGB(255, 98, 74, 155),
            foregroundColor: Colors.white),
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 110, 43, 173),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 98, 74, 155)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data == true ? BottomNav() : AuthScreen();
          }
        },
      ),
    );
  }

  Future<bool> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
