import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:self/Login info/login.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(home: Login(),
        debugShowCheckedModeBanner: false,
));
}