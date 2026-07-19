import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstCtrl  = TextEditingController();
  final _lastCtrl   = TextEditingController();
  final _idCtrl     = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _emailCtrl  = TextEditingController();
  final _pwdCtrl    = TextEditingController();
  bool _obscure  = true;
  bool _loading  = false;
  String? _idFileName;

  @override
  void dispose() {
    for (final c in [_firstCtrl,_lastCtrl,_idCtrl,_phoneCtrl,_emailCtrl,_pwdCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickId() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) setState(() => _idFileName = result.files.single.name);
  }

  Future<void> _register() async {
    setState(() => _loading = true);
    // TODO: wire up Supabase auth + storage
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: isWide
        ? Row(children: [Expanded(child: _brandPanel()), Expanded(child: _formPanel())])
        : SingleChildScrollView(padding: const EdgeInsets.all(24), child: _formPanel()),
    );
  }

  Widget _brandPanel() => Container(
    color: AppTheme.maroon,
    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Buuk-Luuz', style: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 8),
      Text('THE COMPENDIUM', style: TextStyle(fontSize: 11, letterSpacing: 4, color: Colors.white.withOpacity(0.5))),
      const SizedBox(height: 24),
      Text('Join thousands of chamas\nmanaging money smarter.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.65), height: 1.8)),
    ])),
  );

  Widget _formPanel() => Container(
    color: const Color(0xFFFDF8F8),
    padding: const EdgeInsets.all(40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Create account', style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.maroon)),
        const SizedBox(height: 24),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _label('First Name'), const SizedBox(height: 6),
            TextFormField(controller: _firstCtrl, decoration: const InputDecoration(hintText: 'Jane')),
          ])),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _label('Surname'), const SizedBox(height: 6),
            TextFormField(controller: _lastCtrl, decoration: const InputDecoration(hintText: 'Wanjiku')),
          ])),
        ]),
        const SizedBox(height: 16),
        _label('National ID Number'), const SizedBox(height: 6),
        TextFormField(controller: _idCtrl, keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 12345678')),
        const SizedBox(height: 16),
        _label('Upload ID Photo'), const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickId,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(children: [
              const Icon(Icons.upload_file_outlined, color: AppTheme.maroon, size: 18),
              const SizedBox(width: 8),
              Text(_idFileName ?? 'Choose file (front of ID)',
                style: TextStyle(fontSize: 13, color: _idFileName != null ? AppTheme.dark : const Color(0xFFAAAAAA))),
            ]),
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _label('Mobile'), const SizedBox(height: 6),
            TextFormField(controller: _phoneCtrl, keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: '+254 7XX XXX XXX')),
          ])),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _label('Email'), const SizedBox(height: 6),
            TextFormField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'jane@email.com')),
          ])),
        ]),
        const SizedBox(height: 16),
        _label('Password'), const SizedBox(height: 6),
        TextFormField(
          controller: _pwdCtrl, obscureText: _obscure,
          decoration: InputDecoration(
            hintText: 'Choose a strong password',
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _loading ? null : _register,
          child: _loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Text('Create Account'),
        ),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Already a member? ', style: TextStyle(fontSize: 12)),
          GestureDetector(onTap: () => context.go('/login'),
            child: const Text('Sign In', style: TextStyle(fontSize: 12, color: AppTheme.maroon, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 8),
        TextButton(onPressed: () => context.go('/'),
          child: const Text('← Back to home', style: TextStyle(color: AppTheme.grey400, fontSize: 12))),
      ],
    ),
  );

  Widget _label(String text) => Text(text.toUpperCase(),
    style: const TextStyle(fontSize: 11, letterSpacing: 0.5, color: Color(0xFF888888), fontWeight: FontWeight.w500));
}