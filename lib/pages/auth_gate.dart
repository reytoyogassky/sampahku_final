import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampahku_final/pages/home_page.dart';
import 'package:sampahku_final/pages/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Sudah login
        if (snapshot.hasData && snapshot.data != null) {
          return const SampahKUHomePage();
        }

        // Belum login
        return const LoginPage();
      },
    );
  }
}
