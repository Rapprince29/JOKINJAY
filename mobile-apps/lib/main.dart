import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const JokinjayApp());
}

class JokinjayApp extends StatelessWidget {
  const JokinjayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOKINJAY // MOBILE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFF00E5FF),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ── SPLASH SCREEN ──
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah ke Login setelah 3 detik
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image with Animation
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2)),
                color: const Color(0xFF111111),
              ),
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  -1, 0, 0, 0, 255,
                  0, -1, 0, 0, 255,
                  0, 0, -1, 0, 255,
                  0, 0, 0, 1, 0,
                ]), // Invert effect to make black logo white
                child: Image.asset(
                  'assets/logo.jpeg',
                  width: 100,
                  height: 100,
                ),
              ),
            ).animate()
             .fadeIn(duration: 1.seconds)
             .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack)
             .shimmer(delay: 1.5.seconds, color: const Color(0xFF00E5FF).withOpacity(0.5)),

            const SizedBox(height: 30),
            
            // Loading Text
            Text(
              'INITIALIZING_SYSTEM...',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                letterSpacing: 5,
                color: const Color(0xFF00E5FF),
              ),
            ).animate(onPlay: (c) => c.repeat())
             .fade(duration: 800.ms),
          ],
        ),
      ),
    );
  }
}

// ── LOGIN SCREEN ──
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scanline background effect
          Opacity(
            opacity: 0.05,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: List.generate(
                    100,
                    (index) => index % 2 == 0 ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    
                    // Logo Image in Login
                    ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        -1, 0, 0, 0, 255,
                        0, -1, 0, 0, 255,
                        0, 0, -1, 0, 255,
                        0, 0, 0, 1, 0,
                      ]), // Invert effect
                      child: Image.asset('assets/logo.jpeg', width: 40, height: 40),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          color: const Color(0xFF00E5FF),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                         .fade(duration: 500.ms),
                        const SizedBox(width: 12),
                        Text(
                          'SYSTEM_ACCESS_v2.0',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 10,
                            letterSpacing: 4,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 15),
                    
                    Text(
                      'JOKIN\nJAY_',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        height: 0.9,
                        letterSpacing: -5,
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                    
                    const SizedBox(height: 50),
                    
                    // Login Form
                    const CyberTextField(label: 'USER_ID', hint: 'Email or Username'),
                    const SizedBox(height: 20),
                    const CyberTextField(label: 'SECRET_KEY', hint: 'Password', isPassword: true),
                    
                    const SizedBox(height: 40),
                    
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E5FF),
                          foregroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          '[ INITIATE_SESSION ]',
                          style: GoogleFonts.jetBrainsMono(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ).animate().shimmer(delay: 2.seconds, duration: 1.seconds),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '// CONTINUE WITH GOOGLE',
                          style: GoogleFonts.jetBrainsMono(
                            color: Colors.grey[500],
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CyberTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;

  const CyberTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 9,
            color: Colors.grey[700],
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          cursorColor: const Color(0xFF00E5FF),
          style: GoogleFonts.jetBrainsMono(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.jetBrainsMono(color: Colors.grey[800], fontSize: 12),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF222222)),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00E5FF)),
              borderRadius: BorderRadius.zero,
            ),
            filled: true,
            fillColor: const Color(0xFF111111),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
      ],
    );
  }
}
