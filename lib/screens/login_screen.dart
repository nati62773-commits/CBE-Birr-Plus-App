import 'package:flutter/material.dart';
import 'package:cbe/screens/login_auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _goToPin() {
    if (_phoneController.text.length >= 9) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginAuthScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid phone number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Stack(
          children: [
            // Wavy purple background
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(143, 39, 143, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Language Selector
                  Row(
                    children: const [
                      Text(
                        "English",
                        style: TextStyle(
                          color: Color.fromRGBO(143, 39, 143, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Color.fromRGBO(143, 39, 143, 1)),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.account_balance, size: 100, color: Colors.purple);
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  const Center(
                    child: Text(
                      "Welcome to CBE app!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(143, 39, 143, 1)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(143, 39, 143, 1)),
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Phone Number Field
                  const Text("Phone number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Container(
                        width: 70,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(143, 39, 143, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "+251",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "986925302",
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _goToPin,
                      child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Footer Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ", style: TextStyle(fontSize: 13)),
                      Text(
                        "Create Account",
                        style: TextStyle(color: const Color.fromRGBO(143, 39, 143, 1), fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have any question? ", style: TextStyle(fontSize: 13)),
                      Icon(Icons.chat, color: const Color.fromRGBO(143, 39, 143, 1), size: 16),
                      const SizedBox(width: 5),
                      Text(
                        "Chatbot",
                        style: TextStyle(color: const Color.fromRGBO(143, 39, 143, 1), fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Bottom Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomButton(Icons.shield, "USSD - OFFLINE"),
                      _buildBottomButton(Icons.currency_exchange, "Exchange rate"),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "© 2026 Commercial Bank of Ethiopia, All Rights Reserved 7.0.0 version.",
                      style: TextStyle(color: Colors.grey[600], fontSize: 9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(193, 142, 98, 1), // Brownish color
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
