import 'package:flutter/material.dart';
import 'package:cbe/screens/main_screen.dart';

class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({super.key});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  String _pin = "";

  void _onKeyPress(String value) {
    if (_pin.length < 4) {
      setState(() {
        _pin += value;
      });
      
      // If they entered 4 digits, go to the Home Screen
      if (_pin.length == 4) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Login Authentication",
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          
          // Instruction Text
          const Text(
            "Please enter valid PIN to continue the process",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          
          const SizedBox(height: 30),
          
          // The 4 PIN Boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 50,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _pin.length > index ? const Color.fromRGBO(143, 39, 143, 1) : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: _pin.length > index
                      ? const Icon(Icons.circle, size: 15, color: Colors.black) // Shows a dot when typed
                      : const SizedBox(),
                ),
              );
            }),
          ),
          
          const Spacer(),
          
          // Custom Numeric Keypad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                _buildKeypadRow(["1", "2", "3"]),
                const SizedBox(height: 15),
                _buildKeypadRow(["4", "5", "6"]),
                const SizedBox(height: 15),
                _buildKeypadRow(["7", "8", "9"]),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 80), // Empty space on the left
                    _buildKeyButton("0"),
                    // The Purple Backspace Button
                    GestureDetector(
                      onTap: _onBackspace,
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(143, 39, 143, 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.backspace_outlined, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => _buildKeyButton(key)).toList(),
    );
  }

  Widget _buildKeyButton(String value) {
    return GestureDetector(
      onTap: () => _onKeyPress(value),
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
