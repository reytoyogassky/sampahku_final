// lib/components/custom_form_field.dart

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword, // Akan menyembunyikan teks jika isPassword true
      decoration: InputDecoration(
        // labelText adalah teks yang akan "mengambang" di atas
        labelText: labelText,

        // hintText adalah teks placeholder di dalam field
        hintText: hintText,

        // Properti ini adalah kunci untuk membuat label selalu di atas border
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // Atur warna hint text agar sedikit pudar
        hintStyle: TextStyle(color: Colors.grey[500]),

        // Definisikan border saat tidak di-fokus
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),

        // Definisikan border saat di-fokus (misalnya, warna primary)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
      ),
    );
  }
}