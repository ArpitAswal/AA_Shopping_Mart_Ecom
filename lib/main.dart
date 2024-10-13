import 'dart:ui';

import 'package:aa_shopping_mart/ProvidersClass/drawer_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ProvidersClass/category_provider.dart';
import 'ProvidersClass/login_provider.dart';
import 'ProvidersClass/products_provider.dart';
import 'Screens/flash_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //This line ensures that the Flutter framework is initialized before the rest of the code runs. It prepares the environment for building your Flutter UI.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          //This line initializes the Firebase app using the provided configuration options. I've included placeholders for actual configuration values (replace them with my project's Firebase project details
          apiKey: "AIzaSyDmMFQTwPlSsz95sUodtFPHvB3A7NiRPrc",
          authDomain: "aa-shopping-mart.firebaseapp.com",
          databaseURL: "https://aa-shopping-mart-default-rtdb.firebaseio.com",
          projectId: "aa-shopping-mart",
          storageBucket: "aa-shopping-mart.appspot.com",
          messagingSenderId: "373015458581",
          appId: "1:373015458581:web:99d8f02636172666c36f1c"));
  await FirebaseAuth.instance.setPersistence(Persistence
      .LOCAL); //This line sets the persistence behavior for Firebase Authentication. Here, Persistence.LOCAL is used, which stores authentication data locally on the device.
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => DrawerProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'AA Shopping Mart',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.deepPurpleAccent,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
          elevation: 5,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.blue,
        ),
        brightness: Brightness.light,
      ),
      home: const FlashScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
