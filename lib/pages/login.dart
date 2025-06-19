import 'package:flutter/material.dart';
import 'package:sampahku_final/components/button.dart';
import 'package:sampahku_final/components/custom_form_field.dart';
import 'package:sampahku_final/pages/home_page.dart';
import 'package:sampahku_final/pages/register.dart'; // Pastikan Anda memiliki halaman RegisterPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void loginButton() {
    Navigator.pushReplacement(
      context,    
      MaterialPageRoute(builder: (context) => const SampahKuHomePage()),
    );
  }

  void loginWithGoogle() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login dengan Google'),
          content: const Text('Fitur ini juga belum tersedia.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void navigateToRegisterPage() {
    // Di sini Anda akan menempatkan logika untuk pindah halaman
    Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
    // print("Navigasi ke halaman Daftar...");
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("Fitur pendaftaran belum dihubungkan.")),
    // );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Menggunakan SafeArea agar tidak terlalu mepet ke atas
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/logo.png', width: 200, height: 200),
                const SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Masukan Username Anda',
                  ),
                ),
                const SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Masukan Password Anda',
                    isPassword: true,
                  ),
                ),
                const SizedBox(height: 25),
                
                customButton(
                  text: "Masuk",
                  onPressed: loginButton,
                ),
                const SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Masuk Menggunakan", style: TextStyle(color: Colors.grey[700])),
                      ),
                      const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                
                GestureDetector(
                  onTap: loginWithGoogle,
                  child: Image.asset(
                    'lib/assets/images/google.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 25), // Jarak tambahan

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum Punya Akun ? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: navigateToRegisterPage, // Panggil fungsi navigasi
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}