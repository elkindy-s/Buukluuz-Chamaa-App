import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Timer _timer;
  String _time = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 3));
    final days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    setState(() {
      _time = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}';
      _date = '${days[now.weekday-1]}, ${now.day} ${months[now.month-1]} ${now.year} — EAT';
    });
  }

  @override
  void dispose() { _timer.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE0D0D0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Buuk-Luuz',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22, fontWeight: FontWeight.w700,
                    color: AppTheme.maroon,
                  )),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(_time, style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500,
                    color: AppTheme.maroon, letterSpacing: 1,
                    fontFeatures: [FontFeature.tabularFigures()],
                  )),
                  Text(_date, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
                ]),
              ],
            ),
          ),
          Expanded(child: isWide ? _wideLayout(context) : _narrowLayout(context)),
          _featuresStrip(),
        ],
      ),
    );
  }

  Widget _wideLayout(BuildContext context) => Row(
    children: [Expanded(child: _heroLeft()), Expanded(child: _heroRight(context))],
  );

  Widget _narrowLayout(BuildContext context) => SingleChildScrollView(
    child: Column(children: [_heroLeft(), _heroRight(context)]),
  );

  Widget _heroLeft() => Container(
    color: AppTheme.maroon,
    padding: const EdgeInsets.all(40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('CHAMA MANAGEMENT', style: TextStyle(fontSize: 10, letterSpacing: 3, color: Colors.white.withOpacity(0.5))),
        const SizedBox(height: 12),
        Text.rich(TextSpan(children: [
          TextSpan(text: 'Your chama,\n', style: GoogleFonts.playfairDisplay(fontSize: 42, fontWeight: FontWeight.w700, color: Colors.white)),
          TextSpan(text: 'organised.', style: GoogleFonts.playfairDisplay(fontSize: 42, fontWeight: FontWeight.w700, color: const Color(0xFFF5C6C6))),
        ])),
        const SizedBox(height: 8),
        Text('THE COMPENDIUM', style: TextStyle(fontSize: 12, letterSpacing: 4, color: Colors.white.withOpacity(0.5))),
        const SizedBox(height: 20),
        Text('Manage contributions, loans, meetings\nand members — all in one place.',
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.75), height: 1.8)),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.05),
  );

  Widget _heroRight(BuildContext context) => Container(
    color: const Color(0xFFFDF8F8),
    padding: const EdgeInsets.all(40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Welcome back', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.maroon)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: () => context.go('/login'), child: const Text('Sign In')),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.go('/register'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.maroon,
            side: const BorderSide(color: AppTheme.maroon),
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Create Account'),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
  );

  Widget _featuresStrip() => Container(
    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF0E8E8)))),
    child: Row(children: [
      _feature(Icons.group_outlined, 'Public & Private Chamas', 'Open groups or invite-only circles'),
      Container(width: 0.5, height: 80, color: const Color(0xFFF0E8E8)),
      _feature(Icons.phone_android_outlined, 'M-Pesa Integrated', 'Contributions via M-Pesa'),
      Container(width: 0.5, height: 80, color: const Color(0xFFF0E8E8)),
      _feature(Icons.bar_chart_outlined, 'Full Financial Records', 'Statements & audit trails'),
    ]),
  );

  Widget _feature(IconData icon, String title, String desc) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppTheme.maroon, size: 22),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
      ]),
    ),
  );
}