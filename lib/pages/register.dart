import 'package:flutter/material.dart';
import 'package:sampahku_final/components/button.dart';
import 'package:sampahku_final/components/custom_form_field.dart';
import 'package:sampahku_final/pages/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void registerAction() {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Daftar'),
          content: Text('Fitur pendaftaran belum tersedia.'),
        ),
      );
    }

    void registerWithGoogle() {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Google'),
          content: Text('Fitur ini belum tersedia.'),
        ),
      );
    }

    void navigateToLoginPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),

                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: usernameController,
                    labelText: 'Username',
                    hintText: 'Masukan Username',
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Masukan Email',
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Masukan Password',
                    isPassword: true,
                  ),
                ),
                const SizedBox(height: 25),

                // Tombol Daftar
                customButton(
                  text: "Daftar",
                  onPressed: registerAction,
                ),
                const SizedBox(height: 20),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Daftar Menggunakan",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Google Icon
                GestureDetector(
                  onTap: registerWithGoogle,
                  child: Image.asset(
                    'lib/assets/images/google.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 25),

                // Sudah punya akun? Masuk
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah punya akun? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: navigateToLoginPage,
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
