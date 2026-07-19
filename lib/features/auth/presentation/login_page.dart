import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idCtrl  = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() { _idCtrl.dispose(); _pwdCtrl.dispose(); super.dispose(); }

  Future<void> _login() async {
    setState(() => _loading = true);
    // TODO: wire up Supabase auth
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: isWide ? _wideLayout() : _mobileLayout(),
    );
  }

  Widget _wideLayout() => Row(children: [Expanded(child: _brandPanel()), Expanded(child: _formPanel())]);
  Widget _mobileLayout() => SingleChildScrollView(padding: const EdgeInsets.all(24), child: _formPanel());

  Widget _brandPanel() => Container(
    color: AppTheme.maroon,
    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Buuk-Luuz', style: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 8),
      Text('THE COMPENDIUM', style: TextStyle(fontSize: 11, letterSpacing: 4, color: Colors.white.withOpacity(0.5))),
    ])),
  );

  Widget _formPanel() => Container(
    color: const Color(0xFFFDF8F8),
    padding: const EdgeInsets.all(48),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Sign in', style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.maroon)),
        const SizedBox(height: 32),
        _label('National ID Number'), const SizedBox(height: 6),
        TextFormField(controller: _idCtrl, keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 12345678')),
        const SizedBox(height: 16),
        _label('Password'), const SizedBox(height: 6),
        TextFormField(
          controller: _pwdCtrl, obscureText: _obscure,
          decoration: InputDecoration(
            hintText: '••••••••',
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerRight,
          child: TextButton(onPressed: () {},
            child: const Text('Forgot password?', style: TextStyle(color: AppTheme.maroon, fontSize: 12)))),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _loading ? null : _login,
          child: _loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Text('Sign In'),
        ),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Don't have an account? ", style: TextStyle(fontSize: 12)),
          GestureDetector(onTap: () => context.go('/register'),
            child: const Text('Register', style: TextStyle(fontSize: 12, color: AppTheme.maroon, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 12),
        TextButton(onPressed: () => context.go('/'),
          child: const Text('← Back to home', style: TextStyle(color: AppTheme.grey400, fontSize: 12))),
      ],
    ),
  );

  Widget _label(String text) => Text(text.toUpperCase(),
    style: const TextStyle(fontSize: 11, letterSpacing: 0.5, color: Color(0xFF888888), fontWeight: FontWeight.w500));
}