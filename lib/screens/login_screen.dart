// security could be higher

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> _submit(bool isSignup) async {
    setState(() { loading = true; error = null; });
    try {
      if (isSignup) {
        await authService.signUp(emailCtrl.text.trim(), passCtrl.text.trim());
      } else {
        await authService.signIn(emailCtrl.text.trim(), passCtrl.text.trim());
      }
    } on FirebaseAuthException catch (e) {
      setState(() => error = e.message);
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Giriş Yap / Kayıt Ol', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 12),
                TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Şifre'), obscureText: true),
                const SizedBox(height: 16),
                if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                if (loading) const CircularProgressIndicator() else Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(onPressed: () => _submit(false), child: const Text('Giriş')),
                    OutlinedButton(onPressed: () => _submit(true), child: const Text('Kayıt Ol')),
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
