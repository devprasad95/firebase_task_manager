import 'package:firebase_task_manager/service/auth_service.dart';
import 'package:firebase_task_manager/views/error_screen.dart';
import 'package:firebase_task_manager/views/home_screen.dart';
import 'package:firebase_task_manager/views/loading_screen.dart';
import 'package:firebase_task_manager/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthService().authStateChangesFromFirebase,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return const ErrorScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
