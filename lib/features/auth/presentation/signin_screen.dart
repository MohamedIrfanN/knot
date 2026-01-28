import 'package:flutter/material.dart';
import 'package:knot/features/auth/presentation/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _privateKeyController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF000000),
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [Color(0xFF1A1A2E), Color(0xFF000000)],
            stops: [0.0, 0.7],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 40),

                  // Logo
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.2),
                            blurRadius: 80,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/knot_glow.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Title
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF4FACFE),
                          Color(0xFF00F2FE),
                          Color(0xFFD57EEB),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Sign in with your private key',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Private Key Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Private Key',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _privateKeyController,
                        obscureText: _obscureText,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'nsec1...',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF8B5CF6),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your private key';
                          }
                          if (!value.startsWith('nsec1')) {
                            return 'Private key must start with nsec1';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Sign In Button
                  _buildGradientButton(
                    text: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Implement signin logic
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Create Account Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to nostr? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFF6366F1),
                                Color(0xFF8B5CF6),
                                Color(0xFFD946EF),
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFD946EF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
