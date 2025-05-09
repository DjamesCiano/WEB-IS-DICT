import 'package:flutter/material.dart';
import 'package:inventory_system_web/login.dart';
import 'package:inventory_system_web/report.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onProfileSelected(String value) {
    switch (value) {
      case 'logout':
        // Navigate back to LoginPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          // Header with background image and overlay
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dict_region1_card.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(height: 150, color: Colors.black.withOpacity(0.4)),
              Positioned(
                left: 16,
                top: 40,
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              ),
              Positioned(
                right: 16,
                top: 40,
                child: PopupMenuButton<String>(
                  onSelected: _onProfileSelected,
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  itemBuilder:
                      (context) => const [
                        PopupMenuItem(value: 'profile', child: Text('Profile')),
                        PopupMenuItem(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                        PopupMenuItem(value: 'help', child: Text('Help')),
                        PopupMenuItem(value: 'logout', child: Text('Logout')),
                      ],
                ),
              ),
            ],
          ),

          // Body section
          Expanded(
            child: Stack(
              children: [
                // Dark background
                Container(color: const Color(0xFF0C1D47)),

                // Big DICT logo as watermark
                Center(
                  child: Opacity(
                    opacity: 0.04,
                    child: Image.asset(
                      'assets/dict_logo.png',
                      width: 800, // adjust size if needed
                    ),
                  ),
                ),

                // Overlay content
                Container(
                  color: const Color(0xFF0C1D47).withOpacity(0.2),
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column with text
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Mission'),
                              _buildBulletList([
                                "Use ICT to make the Philippines a knowledgeable and networked society",
                                "Bring government closer to the people through improved service delivery",
                                "Ensure the use of affordable and appropriate digital technologies",
                                "Improve the experience of government services",
                                "Improve skills within and outside of government",
                              ]),
                              const SizedBox(height: 24),
                              _buildSectionTitle('Vision'),
                              _buildBulletList([
                                "Create a safe, happy, and innovative nation",
                                "Thrive through and be enabled by ICT",
                                "Push the country's development and transition towards a world-class digital economy",
                                "Build progress through partnerships, shared goals, and a commitment to a brighter future",
                              ]),
                              const SizedBox(height: 24),
                              _buildSectionTitle('Mandate'),
                              _buildBulletList([
                                "Plan, develop, and promote the national ICT development agenda",
                                "Provide policies, plans, programs, and coordinating and implementing mechanisms to promote the Philippine ICT agenda",
                              ]),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),

                      // Right column with DICT card image
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/dict_region1_card.png',
                              width: 400,
                            ),
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0C1D47)),
            child: Text(
              'DICT Drawer',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          ListTile(
            leading: const Icon(Icons.insert_chart_outlined),
            title: const Text('Report & Export'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(color: Colors.white)),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
