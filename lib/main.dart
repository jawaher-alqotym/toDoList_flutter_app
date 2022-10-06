import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:first_flutter_app/controller_bindings.dart';
import "package:first_flutter_app/screens/Home.dart";



Future<void> main() async {
  // FirBase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Home(),
      initialBinding: ControllerBindings(),
    );
  }
}
