import 'package:flutter/material.dart';
import 'package:inventory_system_web/createAccount.dart';
import 'package:inventory_system_web/dashboard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left Side: Background image + dark overlay
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // Background image
                    Container(
                      height: constraints.maxHeight,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/dict_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Dark overlay
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

              // Right Side: Login form with fixed max width
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter Username',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardPage(),
                                  ),
                                );
                              },

                              child: const Text(
                                'Log In',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const CreateAccountPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Don't have an account? Register",
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
}
