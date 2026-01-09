import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/screens/log_in_screen.dart';
import 'presentation/screens/create_note_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool logIn = prefs.getBool('isLoggedIn') ?? false;
  runApp( MyApp(x:logIn));
  

}

class MyApp extends StatelessWidget {
  final bool x;
  const MyApp({super.key, required this.x});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
     home:x? HomeScreen(): LogInScreen());
  }
}  
