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
        textTheme: GoogleFonts.jetbrainsMonoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  
                  // Logo & Header
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        color: const Color(0xFF00E5FF),
                      ).animate(onPlay: (controller) => controller.repeat())
                       .pulse(duration: 1000.ms),
                      const SizedBox(width: 15),
                      Text(
                        'SYSTEM_ACCESS_v2.0',
                        style: GoogleFonts.jetbrainsMono(
                          fontSize: 10,
                          letterSpacing: 4,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'JOKIN\nJAY_',
                    style: GoogleFonts.jetbrainsMono(
                      fontSize: 60,
                      fontWeight: FontWeight.black,
                      height: 0.9,
                      letterSpacing: -5,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                  
                  const SizedBox(height: 60),
                  
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
                        style: GoogleFonts.jetbrainsMono(
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
                        style: GoogleFonts.jetbrainsMono(
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
          style: GoogleFonts.jetbrainsMono(
            fontSize: 9,
            color: Colors.grey[700],
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          cursorColor: const Color(0xFF00E5FF),
          style: GoogleFonts.jetbrainsMono(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.jetbrainsMono(color: Colors.grey[800], fontSize: 12),
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
