
import 'package:flutter/material.dart';
import 'package:frontend_queueless/3check_user.dart';
import 'package:frontend_queueless/5login_page.dart';
import 'package:frontend_queueless/4signup_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  double textSize = 20;

  @override
  void initState() {
    super.initState();

    // Text animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      setState(() {
        textSize = 36;
      });
    });

    // Navigate to LoginPage after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Checkuser(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4930B5),
              Color(0xFF6C4CF1),
              Color(0xFF8B72FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -70,
                right: -60,
                child: _buildCircle(220),
              ),
              Positioned(
                bottom: -80,
                left: -100,
                child: _buildCircle(250),
              ),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container( width: 105, height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.hourglass_top_rounded,
                        size: 55,
                        color: Color(0xFF6C4CF1),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Animated app name
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                      style: TextStyle(
                        fontSize: textSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                      child: const Text('QueueLess'),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Your time. Your turn. Your way.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.85),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 55),

                    const SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'MADE FOR YOUR TIME',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.07),
      ),
    );
  }
}
