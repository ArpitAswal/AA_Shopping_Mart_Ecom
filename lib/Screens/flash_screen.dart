import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_screen.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Speed of the animation
      vsync: this,
    );

    // Start the animation with repeat in reverse (back and forth)
    _controller.repeat(reverse: true);

    // Delay navigation by 5 seconds (animation + buffer time)
    Future.delayed(const Duration(seconds: 6), () async {
      // Stop the animation after 6 seconds (if needed)
      _controller.stop();
      // Trigger navigation by checking auth state
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => InitialScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: h,
          width: w,
          color: Colors.white,
          child: AnimatedBuilder(
            animation: _controller,
            child: Image.asset("assets/AA_Wings.jpg"),
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: 1 + _controller.value * 0.5, // Scale animation
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // User is signed in
            return const HomePage();
          } else {
            return const LogInScreen();
          }
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
