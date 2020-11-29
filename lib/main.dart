import 'package:chat/src/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'src/auth/android_auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthProvider().initialize();
//  FirebaseFirestore
  runApp(MyApp());
}
