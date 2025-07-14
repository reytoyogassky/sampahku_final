import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sampahku_final/components/button.dart';
import 'package:sampahku_final/components/custom_form_field.dart';
import 'package:sampahku_final/pages/login.dart';
import 'package:sampahku_final/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  void registerAction() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final namaLengkap = usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || namaLengkap.isEmpty) {
      _showMessage("Semua kolom wajib diisi");
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(userCredential.user!.uid)
          .set({
        'nama_lengkap': namaLengkap,
        'email': email,
        'password': '***',
        'tanggal_dibuat': FieldValue.serverTimestamp(),
      });

      _showMessage("Akun berhasil dibuat! Silakan login.");
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

  void registerWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        _showMessage("Login dibatalkan.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      final userDoc = await FirebaseFirestore.instance
          .collection('pengguna')
          .doc(user!.uid)
          .get();

      if (!userDoc.exists) {
        await FirebaseFirestore.instance
            .collection('pengguna')
            .doc(user.uid)
            .set({
          'nama_lengkap': user.displayName ?? '',
          'email': user.email ?? '',
          'password': '-',
          'tanggal_dibuat': FieldValue.serverTimestamp(),
        });
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SampahKUHomePage()),
      );
    } catch (e) {
      _showMessage("Login Google gagal: ${e.toString()}");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
                Image.asset('lib/assets/images/logo.png',
                    width: 200, height: 200),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: usernameController,
                    labelText: 'Username',
                    hintText: 'Masukan Username',
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomFormField(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Masukan Email',
                  ),
                ),
                const SizedBox(height: 20),
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
                _isLoading
                    ? const CircularProgressIndicator()
                    : customButton(
                        text: "Daftar",
                        onPressed: registerAction,
                      ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    children: [
                      const Expanded(
                          child:
                              Divider(thickness: 1, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Daftar Menggunakan",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const Expanded(
                          child:
                              Divider(thickness: 1, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: registerWithGoogle,
                  child: Image.asset(
                    'lib/assets/images/google.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 25),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
