import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left Side: Image with overlay and logo
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/dict_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight,
                      color: const Color(0xFF0C1D47).withOpacity(0.85),
                      child: Center(
                        child: Image.asset('assets/dict_logo.png', width: 200),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Side: Create Account Form
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xFF0C1D47),
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildTextField(
                            label: 'Email',
                            hint: 'Enter Username',
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Password',
                            hint: 'Enter Password',
                            obscure: true,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Confirm Password',
                            hint: 'Enter Password',
                            obscure: true,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3E68FF),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
