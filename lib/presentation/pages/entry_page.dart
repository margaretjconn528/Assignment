import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Logo - Blue Lottery Ball
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Color(0xFF6B9DF2), Color(0xFF0047AB)],
                      center: Alignment(-0.3, -0.5),
                      radius: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(top: 10, left: 16, child: _buildSpot()),
                      Positioned(top: 10, right: 16, child: _buildSpot()),
                      Positioned(bottom: 24, left: 6, child: _buildSpot()),
                      Positioned(bottom: 24, right: 6, child: _buildSpot()),
                      Positioned(bottom: 6, child: _buildSpot()),
                      // Inner white circle
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF0047AB), width: 4),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: const Alignment(0.4, -0.4),
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0047AB),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Welcome Text
              Text.rich(
                TextSpan(
                  style: GoogleFonts.openSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                  children: const [
                    TextSpan(text: 'Welcome to '),
                    TextSpan(
                      text: 'LuckyDraw',
                      style: TextStyle(color: Color(0xFF0056D2), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Input Fields
              _buildTextField(
                icon: Icons.person_rounded,
                hint: 'Phone or Email',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                icon: Icons.lock_rounded,
                hint: 'Password',
                isPassword: true,
              ),
              const SizedBox(height: 30),
              // Buttons
              _buildPrimaryButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildSecondaryButton(
                text: 'Register',
                onPressed: () {},
              ),
              const SizedBox(height: 26),
              // Forgot Password Section
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Forgot Password?',
                      style: GoogleFonts.openSans(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Guest Button
              _buildGuestButton(
                text: 'Continue as Guest',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpot() {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFF4A90E2).withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextField({required IconData icon, required String hint, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.openSans(color: Colors.grey[500], fontSize: 16),
          prefixIcon: Icon(icon, color: Colors.grey[400], size: 24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF1565C0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF002244),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF002244),
          ),
        ),
      ),
    );
  }
}
