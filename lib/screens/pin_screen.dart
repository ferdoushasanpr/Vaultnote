import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String inputPin = "";

  void _handleKeyPress(String value) {
    if (inputPin.length < 5) {
      setState(() => inputPin += value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ENTER PIN",
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFF00FFC8),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.all(8),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < inputPin.length
                      ? const Color(0xFF00FFC8)
                      : Colors.white12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildKeyboard() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 60),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index == 9) return const SizedBox();
        if (index == 11) {
          return IconButton(
            onPressed: () => setState(() => inputPin = ""),
            icon: const Icon(Icons.backspace_outlined, color: Colors.white54),
          );
        }
        String val = index == 10 ? "0" : "${index + 1}";
        return TextButton(
          onPressed: () => _handleKeyPress(val),
          child: Text(
            val,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
        );
      },
    );
  }
}
