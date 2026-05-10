import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        scaffoldBackgroundColor: const Color(0xFF050505),
        primaryColor: const Color(0xFF00E5FF),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ── NEW CYBER SPLASH SCREEN ──
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  final List<String> _bootLogs = [
    "[ OK ] KERNEL_INITIALIZED",
    "[ OK ] SECURITY_PROTOCOL_ALPHA",
    "[ OK ] FIREBASE_SYNC_COMPLETE",
    "[ OK ] INTERFACE_READY",
    "[ OK ] ACCESSING_NEURAL_LINK",
  ];
  int _logIndex = 0;

  @override
  void initState() {
    super.initState();
    _startBootSequence();
  }

  void _startBootSequence() async {
    // Simulasi loading progresif
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() {
          _progress = i / 100;
          if (i % 20 == 0 && _logIndex < _bootLogs.length - 1) {
            _logIndex++;
          }
        });
      }
    }

    if (mounted) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(context, _createRoute(const DashboardScreen()));
      } else {
        Navigator.pushReplacement(context, _createRoute(const LoginScreen()));
      }
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: 800.ms,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background Grid
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://www.transparenttextures.com/patterns/carbon-fibre.png"),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo with Glitch Effect
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00E5FF).withAlpha(30)),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withAlpha(20),
                        blurRadius: 50,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix([-1,0,0,0,255, 0,-1,0,0,255, 0,0,-1,0,255, 0,0,0,1,0]),
                    child: Image.asset('assets/logo.jpeg', width: 120, height: 120),
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .shimmer(duration: 2.seconds, color: const Color(0xFF00E5FF).withAlpha(50))
                 .shake(hz: 2, curve: Curves.easeInOutCubic),
                
                const SizedBox(height: 60),
                
                // Progress Bar
                Container(
                  width: size.width * 0.7,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.white.withAlpha(20)),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: size.width * 0.7 * _progress,
                        color: const Color(0xFF00E5FF),
                      ).animate(onPlay: (c) => c.repeat())
                       .shimmer(color: Colors.white),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Boot Logs
                SizedBox(
                  height: 20,
                  child: Text(
                    _bootLogs[_logIndex],
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: const Color(0xFF00E5FF).withAlpha(180),
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2),
                ),
              ],
            ),
          ),
          // Version Tag
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "v2.0.4_STABLE_BUILD",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 8,
                  color: Colors.white.withAlpha(50),
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── ENHANCED LOGIN SCREEN ──
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: '558656482475-72e07ftjqn48n4me8omrj44l34ib2j1l.apps.googleusercontent.com',
  );

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.withAlpha(200),
            content: Text('// ACCESS_DENIED: ${e.toString()}', style: GoogleFonts.jetBrainsMono(color: Colors.white)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          // Cyber Grid Background
          Opacity(
            opacity: 0.03,
            child: GridPaper(
              color: const Color(0xFF00E5FF),
              divisions: 1,
              subdivisions: 1,
              interval: 100,
              child: Container(width: size.width, height: size.height),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.08),
                    // Small Logo
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF00E5FF).withAlpha(50)),
                      ),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.matrix([-1,0,0,0,255, 0,-1,0,0,255, 0,0,-1,0,255, 0,0,0,1,0]),
                        child: Image.asset('assets/logo.jpeg', width: 35, height: 35),
                      ),
                    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                    
                    const SizedBox(height: 30),
                    
                    Text('CORE_INTERFACE', 
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10, 
                        letterSpacing: 4, 
                        color: const Color(0xFF00E5FF).withAlpha(150)
                      )
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 10),
                    
                    Text('JOKIN\nJAY_', 
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: size.width * 0.15, 
                        fontWeight: FontWeight.w900, 
                        height: 0.9, 
                        letterSpacing: -4
                      )
                    ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
                    
                    const SizedBox(height: 50),
                    
                    const CyberTextField(label: 'AUTH_IDENTIFIER', hint: 'Enter Email'),
                    const SizedBox(height: 25),
                    const CyberTextField(label: 'ENCRYPTED_KEY', hint: 'Enter Password', isPassword: true),
                    
                    const SizedBox(height: 40),
                    
                    // Primary Action
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E5FF),
                          foregroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          elevation: 0,
                        ),
                        child: Text('[ ESTABLISH_LINK ]', 
                          style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, letterSpacing: 2)
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                    
                    const SizedBox(height: 25),
                    
                    // Google Sign In
                    Center(
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Color(0xFF00E5FF))
                        : InkWell(
                            onTap: _signInWithGoogle,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '// OR_USE_GOOGLE_GATEWAY',
                                style: GoogleFonts.jetBrainsMono(
                                  color: Colors.white.withAlpha(100), 
                                  fontSize: 10, 
                                  letterSpacing: 2,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                    ).animate().fadeIn(delay: 800.ms),
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

// ── DASHBOARD SCREEN (SMOOTH) ──
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text('SYS.ADMIN_PANEL', style: GoogleFonts.jetBrainsMono(fontSize: 10, letterSpacing: 4, color: const Color(0xFF00E5FF))),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.redAccent, size: 20),
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (user?.photoURL != null)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF00E5FF), width: 1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(radius: 35, backgroundImage: NetworkImage(user!.photoURL!)),
                  ).animate().scale(curve: Curves.easeOutBack),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('USER_AUTHORIZED', style: GoogleFonts.jetBrainsMono(fontSize: 9, color: Colors.grey)),
                      const SizedBox(height: 5),
                      Text(user?.displayName?.toUpperCase() ?? "UNKNOWN_ENTITY", 
                        style: GoogleFonts.jetBrainsMono(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Example Grid Item
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildCyberTile("ACTIVE_SESSIONS", "12"),
                  _buildCyberTile("NETWORK_LATENCY", "24ms"),
                  _buildCyberTile("ENCRYPTION_LVL", "AES_256"),
                  _buildCyberTile("UPLINK_STATUS", "OPTIMAL"),
                ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.2, curve: Curves.easeOutCubic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCyberTile(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: Colors.white.withAlpha(10)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.jetBrainsMono(fontSize: 8, color: Colors.grey)),
          Text(value, style: GoogleFonts.jetBrainsMono(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF))),
        ],
      ),
    );
  }
}

class CyberTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  const CyberTextField({super.key, required this.label, required this.hint, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.jetBrainsMono(fontSize: 9, color: Colors.grey[700], letterSpacing: 2)),
        const SizedBox(height: 10),
        TextField(
          obscureText: isPassword,
          cursorColor: const Color(0xFF00E5FF),
          style: GoogleFonts.jetBrainsMono(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.jetBrainsMono(color: Colors.white.withAlpha(20), fontSize: 11),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1A1A1A)), borderRadius: BorderRadius.zero),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF)), borderRadius: BorderRadius.zero),
            filled: true,
            fillColor: const Color(0xFF0D0D0D),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ],
    );
  }
}
