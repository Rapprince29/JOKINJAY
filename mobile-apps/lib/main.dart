import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyC1ygc1ZEdguOX7pRfVRgcTCemIDt0AH7k',
    appId: '1:558656482475:web:c0864205937402898d5bee',
    messagingSenderId: '558656482475',
    projectId: 'jokinjay-8e750',
    storageBucket: 'jokinjay-8e750.firebasestorage.app',
    authDomain: 'jokinjay-8e750.firebaseapp.com',
  );

  try {
    await Firebase.initializeApp(
      options: (ThemeData().platform == TargetPlatform.android || ThemeData().platform == TargetPlatform.iOS) 
        ? null : firebaseOptions,
    );
  } catch (e) {
    debugPrint("Firebase Init Error: $e");
  }
  
  runApp(const JokinjayApp());
}

class JokinjayApp extends StatelessWidget {
  const JokinjayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOKINJAY // PREMIUM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0F1D), // Dark slate/blue premium base
        primaryColor: const Color(0xFF00E5FF), // Cyan neon primary
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF6366F1), // Indigo secondary
          surface: Color(0xFF131B2E),
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ── 1. PREMIUM & FRIENDLY SPLASH SCREEN ──
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentPhraseIndex = 0;
  final List<String> _loadingPhrases = [
    "Menghubungkan ke server aman JOKINJAY...",
    "Memuat layanan akademis & pemrograman...",
    "Mempersiapkan antarmuka premium Anda...",
    "Sistem siap! Selamat datang di JOKINJAY.",
  ];

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  void _startSequence() async {
    // Cycle through friendly loading phrases
    for (int i = 1; i < _loadingPhrases.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1100));
      if (mounted) {
        setState(() {
          _currentPhraseIndex = i;
        });
      }
    }
    
    await Future.delayed(const Duration(milliseconds: 600));
    
    if (mounted) {
      final user = FirebaseAuth.instance.currentUser;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, anim, secAnim) => user != null ? const MainWrapper() : const LoginScreen(),
          transitionsBuilder: (context, anim, secAnim, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundGradient(),
          
          // Floating Particles for premium depth
          ...List.generate(24, (index) => _FloatingParticle(index: index)),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Logo with Soft Shimmer
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withOpacity(0.3),
                        blurRadius: 35,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: _GlassContainer(
                    width: 140,
                    height: 140,
                    borderRadius: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.asset('assets/logo.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                ).animate()
                 .scale(duration: 1200.ms, curve: Curves.elasticOut)
                 .shimmer(delay: 1500.ms, duration: 2000.ms),

                const SizedBox(height: 40),

                // Responsive & Clean Typography
                Column(
                  children: [
                    Text(
                      "JOKINJAY",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                    const SizedBox(height: 6),
                    Text(
                      "ASISTEN AKADEMIK & PROGRAMMING TERPERCAYA",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        letterSpacing: 2,
                        color: const Color(0xFF00E5FF).withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                  ],
                ),

                const SizedBox(height: 70),

                // Elegant Smooth Loading Indicator
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 3,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(0.08),
                            color: const Color(0xFF00E5FF),
                          ),
                        ),
                      ).animate().shimmer(duration: 2000.ms),
                      const SizedBox(height: 20),
                      
                      // Dynamic Phrase Display with Animated Key
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _loadingPhrases[_currentPhraseIndex],
                          key: ValueKey<int>(_currentPhraseIndex),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── 2. INCLUSIVE & CLEAN LOGIN SCREEN ──
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final googleSignIn = GoogleSignIn(
        serverClientId: '558656482475-72e07ftjqn48n4me8omrj44l34ib2j1l.apps.googleusercontent.com',
      );
      final user = await googleSignIn.signIn();
      if (user != null) {
        final auth = await user.authentication;
        final cred = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
        await FirebaseAuth.instance.signInWithCredential(cred);
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainWrapper()));
        }
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal masuk dengan Google. Silakan coba kembali.", style: GoogleFonts.plusJakartaSans()),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleStandardLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate quick secure connection
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainWrapper()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundGradient(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Premium Centered Branding
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00E5FF).withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: _GlassContainer(
                              width: 80,
                              height: 80,
                              borderRadius: 24,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset('assets/logo.jpeg'),
                              ),
                            ),
                          ).animate().scale(duration: 500.ms).rotate(begin: -0.05, end: 0),
                          const SizedBox(height: 25),
                          Text(
                            "AKSES APLIKASI", 
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10, 
                              letterSpacing: 4, 
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00E5FF),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "JOKINJAY", 
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 36, 
                              fontWeight: FontWeight.w900, 
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Solusi Pintar untuk Berbagai Kebutuhan Akademik",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 45),

                      // Premium Login Card
                      _GlassContainer(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CustomTextField(
                              controller: _usernameController,
                              label: "EMAIL / NAMA PENGGUNA",
                              hint: "contoh@email.com atau nama_anda", 
                              icon: Icons.person_outline,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Harap masukkan email atau nama pengguna Anda";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _CustomTextField(
                              controller: _passwordController,
                              label: "KATA SANDI / PASSWORD",
                              hint: "Masukkan kata sandi Anda", 
                              icon: Icons.lock_outline, 
                              isPassword: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Harap masukkan kata sandi Anda";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 35),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleStandardLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00E5FF),
                                  foregroundColor: const Color(0xFF0A0F1D),
                                  disabledBackgroundColor: const Color(0xFF00E5FF).withOpacity(0.4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                ),
                                child: _isLoading 
                                  ? const SizedBox(
                                      width: 20, 
                                      height: 20, 
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF0A0F1D)),
                                    )
                                  : Text(
                                      "MASUK SEKARANG", 
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w800, 
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.05),

                      const SizedBox(height: 30),

                      // Google Gateway
                      if (!_isLoading)
                        InkWell(
                          onTap: _handleGoogleSignIn,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              border: Border.all(color: Colors.white.withOpacity(0.08)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const FaIcon(FontAwesomeIcons.google, size: 16, color: Colors.white),
                                const SizedBox(width: 12),
                                Text(
                                  "Masuk Lebih Cepat dengan Google", 
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: 300.ms),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 3. MAIN WRAPPER (ELEGANT FLOATING DOCK) ──
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const DashboardScreen(),
    const ServicesScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  String _getHeaderTitle() {
    switch (_currentIndex) {
      case 0: return "Dashboard Utama";
      case 1: return "Pesan Jasa Joki";
      case 2: return "Riwayat Pesanan";
      case 3: return "Profil Pengguna";
      default: return "JOKINJAY";
    }
  }

  String _getSubHeader() {
    switch (_currentIndex) {
      case 0: return "SELAMAT DATANG KEMBALI";
      case 1: return "PILIH LAYANAN PROFESIONAL";
      case 2: return "PELACAKAN STATUS REAL-TIME";
      case 3: return "PENGATURAN AKUN AKTIF";
      default: return "JOKINJAY PREMIUM";
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const _BackgroundGradient(),
          
          // Pages with smooth cross-fade animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.02),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(_currentIndex), 
              child: _pages[_currentIndex],
            ),
          ),

          // Custom Elegant Global Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: _GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              borderRadius: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getSubHeader(), 
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 8, 
                            letterSpacing: 2, 
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00E5FF),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _getHeaderTitle(), 
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => setState(() => _currentIndex = 3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3), width: 1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: user?.photoURL != null
                            ? Image.network(user!.photoURL!, fit: BoxFit.cover)
                            : const CircleAvatar(
                                backgroundColor: Colors.white10,
                                child: Icon(Icons.person, color: Colors.white54, size: 20),
                              ),
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
      bottomNavigationBar: _FloatingDock(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// ── 4. DASHBOARD (INCLUSIVE BENTO GRID & SECURE WALLET) ──
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 110, 20, 115),
        children: [
          const SizedBox(height: 10),

          // Premium Redesigned Wallet Card
          _GlassContainer(
            padding: const EdgeInsets.all(22),
            borderRadius: 24,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E5FF).withOpacity(0.12), 
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF00E5FF), size: 22),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SALDO DOMPET JOKINJAY", 
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9, 
                          color: Colors.white.withOpacity(0.4), 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp 2.450.000", 
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 22, 
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Fitur Topup Saldo segera hadir secara otomatis!", style: GoogleFonts.plusJakartaSans()),
                        backgroundColor: const Color(0xFF00E5FF),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.15), 
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Color(0xFF10B981), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          "ISI SALDO", 
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9, 
                            fontWeight: FontWeight.w800, 
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.05),

          const SizedBox(height: 20),

          // Bento Grid with High-contrast Rounded Borders & Friendly Names
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: [
              const _BentoTile(
                title: "Total Pesanan", 
                value: "24", 
                icon: Icons.assignment_outlined, 
                color: Color(0xFF6366F1), // Indigo
              ),
              const _BentoTile(
                title: "Sedang Berjalan", 
                value: "04", 
                icon: Icons.pending_actions_outlined, 
                color: Color(0xFF00E5FF), // Cyan
              ),
              const _BentoTile(
                title: "Telah Selesai", 
                value: "20", 
                icon: Icons.check_circle_outline_rounded, 
                color: Color(0xFF10B981), // Emerald Green
              ),
              _BentoTile(
                title: "Tingkat Sukses", 
                value: "100%", 
                icon: Icons.stars_outlined, 
                color: const Color(0xFFF59E0B), // Golden Amber
              ),
            ],
          ).animate(delay: 150.ms).fadeIn(),
          
          const SizedBox(height: 20),
          
          // Real-time Recent Activity with Indonesian Copywriting
          _GlassContainer(
            padding: const EdgeInsets.all(22),
            borderRadius: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AKTIVITAS TERBARU", 
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 1.5,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const Icon(Icons.sync, size: 14, color: Colors.white30),
                  ],
                ),
                const SizedBox(height: 20),
                const _ActivityItem(
                  title: "Joki ahli telah ditugaskan untuk Tugas #9922", 
                  time: "Baru saja", 
                  color: Color(0xFF00E5FF),
                ),
                const Divider(color: Colors.white10, height: 25),
                const _ActivityItem(
                  title: "Pembayaran terkonfirmasi untuk Pesanan #9923", 
                  time: "15 menit lalu", 
                  color: Color(0xFF10B981),
                ),
              ],
            ),
          ).animate(delay: 300.ms).fadeIn(),
        ],
      ),
    );
  }
}

// ── 5. SERVICES SCREEN (CLEAN, FRIENDLY ORDER FORM) ──
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {"title": "Skripsi / Thesis", "icon": Icons.school, "price": "Mulai Rp 5jt", "time": "14-30 Hari", "desc": "Penelitian komprehensif, analisis data, metodologi lengkap, dan bab pembahasan akademik."},
    {"title": "Kode Program", "icon": Icons.code, "price": "Mulai Rp 1jt", "time": "2-7 Hari", "desc": "Pembuatan program Android/iOS, Web Fullstack, Script Python/R, database, dan perbaikan bug (fixing)."},
    {"title": "Makalah / Essay", "icon": Icons.description, "price": "Mulai Rp 200rb", "time": "1-3 Hari", "desc": "Penulisan makalah, paper, essay, tugas rangkuman jurnal berstandar tinggi dan bebas plagiasi."},
    {"title": "Laporan Praktikum", "icon": Icons.assignment, "price": "Mulai Rp 300rb", "time": "1-2 Hari", "desc": "Penyusunan laporan laboratorium, pengolahan data praktikum teknik/sains lengkap dengan grafik analisis."},
    {"title": "Presentasi PPT", "icon": Icons.slideshow, "price": "Mulai Rp 150rb", "time": "1 Hari", "desc": "Pembuatan file presentasi PowerPoint yang dinamis, interaktif, rapi, dan mudah dipahami untuk ujian."},
    {"title": "Kuis / Ujian Online", "icon": Icons.timer, "price": "Mulai Rp 100rb", "time": "Real-time", "desc": "Bantuan pengerjaan kuis mingguan, ujian online terstruktur secara cepat dengan hasil memuaskan."},
    {"title": "Terjemahan Bahasa", "icon": Icons.translate, "price": "Mulai Rp 50rb", "time": "1 Hari", "desc": "Penerjemahan dokumen akademik/formal Indonesia - Inggris - Mandarin yang terpercaya secara tata bahasa."},
    {"title": "Desain UI / Grafis", "icon": Icons.palette, "price": "Mulai Rp 100rb", "time": "1-3 Hari", "desc": "Pembuatan mockup aplikasi di Figma, editing aset grafis, presentasi infografis, dan desain Canva."},
  ];

  void _showServiceDetail(BuildContext context, Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _GlassContainer(
        borderRadius: 30,
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 45, 
                  height: 4, 
                  decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(service['icon'], color: const Color(0xFF00E5FF), size: 28),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      service['title'], 
                      style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "DESKRIPSI LAYANAN", 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.white30, 
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                service['desc'], 
                style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.5, color: Colors.white.withOpacity(0.85)),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DetailMiniBox(label: "ESTIMASI BIAYA", value: service['price']),
                  _DetailMiniBox(label: "DURASI PENGERJAAN", value: service['time']),
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF131B2E),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Color(0xFF10B981)),
                            const SizedBox(width: 10),
                            Text("Pesanan Terkirim", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: Text(
                          "Pemesanan joki untuk '${service['title']}' sedang diproses. Konsultan kami akan menghubungi Anda sesaat lagi melalui WhatsApp/Email terdaftar.",
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "SIAP", 
                              style: GoogleFonts.plusJakartaSans(color: const Color(0xFF00E5FF), fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF), 
                    foregroundColor: const Color(0xFF0A0F1D), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    "PESAN SEKARANG & KONSULTASI", 
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 110, 20, 115),
      children: [
        Text(
          "PILIH JENIS TUGAS ANDA", 
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9, 
            letterSpacing: 2, 
            fontWeight: FontWeight.bold,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final s = services[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => _showServiceDetail(context, s),
                borderRadius: BorderRadius.circular(20),
                child: _GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  borderRadius: 20,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(s['icon'], color: const Color(0xFF00E5FF), size: 22),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['title'], style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 3),
                            Text(
                              "${s['price']} • Pengerjaan: ${s['time']}", 
                              style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white24),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: (index * 40).ms).slideX(begin: 0.05);
          },
        ),
      ],
    );
  }
}

class _DetailMiniBox extends StatelessWidget {
  final String label, value;
  const _DetailMiniBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: GoogleFonts.plusJakartaSans(fontSize: 8, color: Colors.white30, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value, 
          style: GoogleFonts.jetBrainsMono(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF)),
        ),
      ],
    );
  }
}

// ── 6. HISTORY SCREEN (WITH BEAUTIFUL STEPPED TRACKER) ──
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 110, 20, 115),
      children: [
        Text(
          "PROGRES PESANAN AKTIF", 
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9, 
            letterSpacing: 2, 
            fontWeight: FontWeight.bold,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 12),
        
        // Active Order Stepped Tracker Card (Extremely Premium)
        _GlassContainer(
          padding: const EdgeInsets.all(22),
          borderRadius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pesanan #9922", 
                    style: GoogleFonts.jetBrainsMono(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white54),
                  ),
                  _StatusChip(status: "SEDANG DIKERJAKAN"),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Pemrograman Web: Kalkulus Lanjut", 
                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              
              // Stepped Progress Indicator
              _StepProgressItem(
                stepNum: "1",
                title: "Pembayaran Diterima",
                subtitle: "Saldo dompet sukses dipotong & diverifikasi",
                isCompleted: true,
                isLast: false,
              ),
              _StepProgressItem(
                stepNum: "2",
                title: "Proses Pengerjaan Joki",
                subtitle: "Programmer sedang menulis script kalkulus",
                isCurrent: true,
                isCompleted: false,
                isLast: false,
              ),
              _StepProgressItem(
                stepNum: "3",
                title: "Verifikasi & Quality Check",
                subtitle: "Pemeriksaan fungsionalitas dan kerapian kode",
                isCompleted: false,
                isLast: false,
              ),
              _StepProgressItem(
                stepNum: "4",
                title: "Penyerahan Berkas",
                subtitle: "Kode siap diunduh di dashboard",
                isCompleted: false,
                isLast: true,
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: 0.05),
        
        const SizedBox(height: 25),
        Text(
          "RIWAYAT PENGERJAAN SEBELUMNYA", 
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9, 
            letterSpacing: 2, 
            fontWeight: FontWeight.bold,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 12),
        
        // Past Orders
        _GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: 24,
          child: Column(
            children: [
              _HistoryItem(id: "Pesanan #9921", title: "Makalah Manajemen Strategis", status: "SELESAI", date: "12 Mei 2026"),
              const Divider(color: Colors.white10, height: 35),
              _HistoryItem(id: "Pesanan #9920", title: "Pembuatan Presentasi PPT Kimia", status: "SELESAI", date: "10 Mei 2026"),
              const Divider(color: Colors.white10, height: 35),
              _HistoryItem(id: "Pesanan #9919", title: "Kuis Online Aljabar Linear", status: "MENUNGGU PEMBAYARAN", date: "Baru Saja"),
            ],
          ),
        ).animate(delay: 200.ms).fadeIn(),
      ],
    );
  }
}

class _StepProgressItem extends StatelessWidget {
  final String stepNum;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _StepProgressItem({
    required this.stepNum,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isCurrent = false,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    Color stepColor = isCompleted 
        ? const Color(0xFF10B981) 
        : isCurrent 
            ? const Color(0xFF00E5FF) 
            : Colors.white10;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: stepColor.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: stepColor,
                  width: isCurrent ? 2 : 1,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Color(0xFF10B981))
                  : Text(
                      stepNum, 
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10, 
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? const Color(0xFF00E5FF) : Colors.white30,
                      ),
                    ),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: 38,
                color: isCompleted ? const Color(0xFF10B981).withOpacity(0.6) : Colors.white10,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, 
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? const Color(0xFF00E5FF) : isCompleted ? Colors.white : Colors.white38,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle, 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, 
                  color: Colors.white38,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String id, title, status, date;
  const _HistoryItem({required this.id, required this.title, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3, 
          height: 38, 
          decoration: BoxDecoration(
            color: status == "SELESAI" 
                ? const Color(0xFF10B981) 
                : status == "SEDANG DIKERJAKAN" 
                    ? const Color(0xFF00E5FF) 
                    : const Color(0xFFF59E0B),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(id, style: GoogleFonts.jetBrainsMono(fontSize: 9, color: Colors.white30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text(date, style: GoogleFonts.plusJakartaSans(fontSize: 9, color: Colors.white24)),
            ],
          ),
        ),
        _StatusChip(status: status),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color c = status == "SELESAI" 
        ? const Color(0xFF10B981) 
        : status == "SEDANG DIKERJAKAN" 
            ? const Color(0xFF00E5FF) 
            : const Color(0xFFF59E0B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withOpacity(0.08), 
        borderRadius: BorderRadius.circular(8), 
        border: Border.all(color: c.withOpacity(0.25)),
      ),
      child: Text(
        status, 
        style: GoogleFonts.jetBrainsMono(fontSize: 8, fontWeight: FontWeight.bold, color: c),
      ),
    );
  }
}

// ── 7. PROFILE SCREEN (PROFILE OPERATOR JOKINJAY) ──
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  String _displayName = "";

  @override
  void initState() {
    super.initState();
    _displayName = FirebaseAuth.instance.currentUser?.displayName ?? "Pengguna JOKINJAY";
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  void _showEditName() {
    final controller = TextEditingController(text: _displayName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "UBAH NAMA PROFIL", 
          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF)),
        ),
        content: TextField(
          controller: controller,
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Masukkan nama baru Anda",
            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white24, fontSize: 13),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("BATAL", style: GoogleFonts.plusJakartaSans(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _displayName = controller.text);
              }
              Navigator.pop(context);
            },
            child: Text("PERBARUI", style: GoogleFonts.plusJakartaSans(color: const Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "KELUAR AKUN?", 
          style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
        content: Text(
          "Apakah Anda yakin ingin memutus koneksi dan keluar dari aplikasi JOKINJAY?", 
          style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white70, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("TETAP MASUK", style: GoogleFonts.plusJakartaSans(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(this.context);
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: Text("KELUAR", style: GoogleFonts.plusJakartaSans(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showProfileDetail(String title, List<Widget> children) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _GlassContainer(
        borderRadius: 30,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 25),
            Text(
              title, 
              style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF)),
            ),
            const SizedBox(height: 6),
            Text(
              "INFORMASI TRANSAKSI DAN KEAMANAN SECURE CLOUD", 
              style: GoogleFonts.jetBrainsMono(fontSize: 8, color: Colors.white30, letterSpacing: 1.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            ...children,
            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10, 
                  foregroundColor: Colors.white, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text("TUTUP", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 110, 20, 115),
        children: [
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3), width: 2),
                        ),
                        child: _GlassContainer(
                          width: 110, 
                          height: 110, 
                          borderRadius: 55,
                          child: Padding(
                            padding: const EdgeInsets.all(4), 
                            child: CircleAvatar(
                              radius: 50, 
                              backgroundImage: _image != null 
                                  ? FileImage(_image!) 
                                  : (user?.photoURL != null ? NetworkImage(user!.photoURL!) : null) as ImageProvider?, 
                              backgroundColor: Colors.white10, 
                              child: (_image == null && user?.photoURL == null) 
                                  ? const Icon(Icons.person, size: 40, color: Colors.white30) 
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0, 
                        right: 4, 
                        child: Container(
                          padding: const EdgeInsets.all(6), 
                          decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle), 
                          child: const Icon(Icons.camera_alt_outlined, size: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showEditName,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            _displayName, 
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w900),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit_note, size: 18, color: Color(0xFF00E5FF)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user?.email ?? "pengguna@jokinjay.com", 
                  style: GoogleFonts.jetBrainsMono(fontSize: 10, color: Colors.white30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Operator Stats Row with JetBrains Mono numbers
          Row(
            children: [
              Expanded(child: _ProfileStatCard(label: "PESANAN", value: "24", icon: Icons.shopping_bag_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _ProfileStatCard(label: "LEVEL", value: "ELITE", icon: Icons.workspace_premium_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _ProfileStatCard(label: "POIN XP", value: "2.8K", icon: Icons.bolt)),
            ],
          ),
          const SizedBox(height: 25),
          
          // Profile Action List
          _GlassContainer(
            padding: const EdgeInsets.symmetric(vertical: 8),
            borderRadius: 24,
            child: Column(
              children: [
                _ProfileActionTile(
                  title: "Riwayat Transaksi", 
                  icon: Icons.receipt_long_outlined, 
                  color: const Color(0xFF6366F1),
                  onTap: () => _showProfileDetail("RIWAYAT TRANSAKSI", [
                    _DetailRow(label: "Pembayaran Tugas #9922", value: "-Rp 250.000", color: Colors.redAccent),
                    const Divider(color: Colors.white10, height: 30),
                    _DetailRow(label: "Isi Saldo Dompet", value: "+Rp 1.000.000", color: Colors.greenAccent),
                    const Divider(color: Colors.white10, height: 30),
                    _DetailRow(label: "Pembayaran Tugas #9921", value: "-Rp 150.000", color: Colors.redAccent),
                  ]),
                ),
                const Divider(color: Colors.white10, indent: 60),
                _ProfileActionTile(
                  title: "Keamanan & Privasi", 
                  icon: Icons.shield_outlined, 
                  color: const Color(0xFF10B981),
                  onTap: () => _showProfileDetail("KEAMANAN & PRIVASI", [
                    _DetailRow(label: "Status Enkripsi Data", value: "AES-256 AKTIF", color: Colors.greenAccent),
                    const Divider(color: Colors.white10, height: 30),
                    _DetailRow(label: "Verifikasi Sesi Akun", styleValue: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, color: Colors.greenAccent), value: "AMAN", color: Colors.greenAccent),
                    const Divider(color: Colors.white10, height: 30),
                    _DetailRow(label: "Autentikasi 2 Arah", value: "NONAKTIF", color: Colors.orangeAccent),
                  ]),
                ),
                const Divider(color: Colors.white10, indent: 60),
                _ProfileActionTile(
                  title: "Akun Terhubung", 
                  icon: Icons.supervised_user_circle_outlined, 
                  color: const Color(0xFFF59E0B),
                  onTap: () => _showProfileDetail("AKUN TERHUBUNG", [
                    _DetailRow(label: "Google Authentication", value: "TERHUBUNG", color: Colors.greenAccent),
                    const Divider(color: Colors.white10, height: 30),
                    _DetailRow(label: "Sinkronisasi Cloud Sync", value: "AKTIF", color: Colors.greenAccent),
                  ]),
                ),
                const Divider(color: Colors.white10, indent: 60),
                _ProfileActionTile(
                  title: "Keluar dari Akun", 
                  icon: Icons.logout_rounded, 
                  color: Colors.redAccent, 
                  onTap: _showLogoutConfirm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _ProfileStatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      borderRadius: 18,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF00E5FF)),
          const SizedBox(height: 8),
          Text(
            value, 
            style: GoogleFonts.jetBrainsMono(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            label, 
            style: GoogleFonts.plusJakartaSans(fontSize: 8, color: Colors.white30, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final TextStyle? styleValue;
  
  const _DetailRow({
    required this.label, 
    required this.value, 
    required this.color,
    this.styleValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white.withOpacity(0.7))),
        Text(
          value, 
          style: styleValue ?? GoogleFonts.jetBrainsMono(fontSize: 12, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _ProfileActionTile({required this.title, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        title, 
        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 16),
    );
  }
}

// ── 8. CUSTOM STUNNING GLASS UI COMPONENTS ──

class _FloatingDock extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _FloatingDock({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding > 0 ? bottomPadding + 4 : 20),
      height: 70,
      child: _GlassContainer(
        borderRadius: 35,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _DockIcon(icon: Icons.grid_view_rounded, index: 0, currentIndex: currentIndex, onTap: onTap),
            _DockIcon(icon: Icons.explore_outlined, index: 1, currentIndex: currentIndex, onTap: onTap),
            _DockIcon(icon: Icons.history_edu_rounded, index: 2, currentIndex: currentIndex, onTap: onTap),
            _DockIcon(icon: Icons.settings_outlined, index: 3, currentIndex: currentIndex, onTap: onTap),
          ],
        ),
      ),
    ).animate().slideY(begin: 1.0, duration: 600.ms, curve: Curves.easeOutBack);
  }
}

class _DockIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _DockIcon({required this.icon, required this.index, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
              ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
            Icon(
              icon, 
              color: isSelected ? const Color(0xFF00E5FF) : Colors.white.withOpacity(0.4), 
              size: 24,
            ),
            if (isSelected)
              Positioned(
                bottom: 8,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                ),
              ).animate().fadeIn(),
          ],
        ),
      ),
    );
  }
}

class _BentoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _BentoTile({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value, 
                style: GoogleFonts.jetBrainsMono(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              const SizedBox(height: 2),
              Text(
                title, 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, 
                  color: Colors.white.withOpacity(0.4), 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsets? padding;

  const _GlassContainer({
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 28.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (height == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            width: width ?? double.infinity,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.0),
              color: Colors.white.withOpacity(0.04),
            ),
            child: child,
          ),
        ),
      );
    }
    return GlassmorphicContainer(
      width: width ?? double.infinity,
      height: height!,
      borderRadius: borderRadius,
      blur: 16,
      alignment: Alignment.center,
      border: 1.0,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.04),
          Colors.white.withOpacity(0.02),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.12),
          Colors.white.withOpacity(0.03),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.hint,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            style: GoogleFonts.plusJakartaSans(fontSize: 14),
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.24), fontSize: 12),
              prefixIcon: Icon(icon, size: 18, color: const Color(0xFF00E5FF).withOpacity(0.6)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  const _ActivityItem({required this.title, required this.time, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8, 
            height: 8, 
            decoration: BoxDecoration(
              color: color, 
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 6,
                  spreadRadius: 1,
                )
              ]
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title, 
              style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9)),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time, 
            style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white24),
          ),
        ],
      ),
    );
  }
}

class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFF070B16)), // Deeper dark slate/black
        Positioned(
          top: -150,
          right: -80,
          child: _BlurCircle(color: const Color(0xFF00E5FF).withOpacity(0.08), size: 400),
        ),
        Positioned(
          bottom: -100,
          left: -80,
          child: _BlurCircle(color: const Color(0xFF6366F1).withOpacity(0.08), size: 400),
        ),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _BlurCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90), child: Container(color: Colors.transparent)),
    );
  }
}

class _FloatingParticle extends StatelessWidget {
  final int index;
  const _FloatingParticle({required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: (index * 41) % size.width,
      top: (index * 79) % size.height,
      child: Container(
        width: (index % 3) + 1.2,
        height: (index % 3) + 1.2,
        decoration: BoxDecoration(
          color: const Color(0xFF00E5FF).withOpacity(index % 2 == 0 ? 0.4 : 0.15),
          shape: BoxShape.circle,
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true))
       .move(
          begin: const Offset(0, 0),
          end: Offset((index % 5 - 2) * 25.0, (index % 4 - 2) * 35.0),
          duration: (2500 + index * 250).ms,
          curve: Curves.easeInOutSine,
        ),
    );
  }
}
