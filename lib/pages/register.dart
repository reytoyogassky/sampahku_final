import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampahku_final/components/button.dart';
import 'package:sampahku_final/components/custom_form_field.dart';
import 'package:sampahku_final/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController(); // masih bisa dipakai simpan di Firestore nanti
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  void registerAction() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email dan password tidak boleh kosong");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showMessage("Akun berhasil dibuat! Silakan login.");

      // Kembali ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Pendaftaran gagal";
      if (e.code == 'email-already-in-use') {
        message = 'Email sudah terdaftar';
      } else if (e.code == 'weak-password') {
        message = 'Password terlalu lemah';
      }
      _showMessage(message);
    } catch (e) {
      _showMessage("Terjadi kesalahan saat daftar");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                _isLoading
                    ? const CircularProgressIndicator()
                    : customButton(
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
