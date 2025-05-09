import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_system_web/dashboard.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFF061A38),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/dict_logo.png', height: 50),
                  const SizedBox(width: 10),
                  const Text(
                    'All Items',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) => _onProfileSelected(context, value),
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    itemBuilder:
                        (context) => const [
                          PopupMenuItem(
                            value: 'profile',
                            child: Text('Profile'),
                          ),
                          PopupMenuItem(
                            value: 'settings',
                            child: Text('Settings'),
                          ),
                          PopupMenuItem(value: 'help', child: Text('Help')),
                          PopupMenuItem(value: 'logout', child: Text('Logout')),
                        ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSearchBar(),
              const SizedBox(height: 12),
              _buildTable(context),
              const SizedBox(height: 12),
              _buildStatusAndButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  void _onProfileSelected(BuildContext context, String value) {
    switch (value) {
      case 'profile':
        // Navigate to profile screen
        break;
      case 'settings':
        // Navigate to settings screen
        break;
      case 'help':
        // Show help or navigate to help screen
        break;
      case 'logout':
        // Implement logout functionality
        break;
    }
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        DropdownButton<String>(
          value: 'Sort by',
          dropdownColor: const Color(0xFF061A38),
          items: const [
            DropdownMenuItem(
              value: 'Sort by',
              child: Text('Sort by', style: TextStyle(color: Colors.white)),
            ),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type here...',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF183B65),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            const Divider(color: Colors.white70),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance.ref('scanned_items').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error loading data',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData ||
                      snapshot.data!.snapshot.value == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final raw = snapshot.data!.snapshot.value;

                  // Safely cast the raw data to a usable Map
                  final Map<String, dynamic> data;
                  try {
                    data = Map<String, dynamic>.from(raw as Map);
                  } catch (e) {
                    return const Center(
                      child: Text(
                        'Unexpected data format.',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final items =
                      data.entries.toList()..sort((a, b) {
                        final aTime = (a.value['timestamp'] ?? 0) as int;
                        final bTime = (b.value['timestamp'] ?? 0) as int;
                        return bTime.compareTo(aTime);
                      });

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final itemMap = Map<String, dynamic>.from(
                        items[index].value,
                      );
                      return _buildTableRow(index + 1, itemMap);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: const [
        Expanded(flex: 1, child: Text('No.', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Item/Brand/Model', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Property Number', style: _headerStyle)),
        Expanded(
          flex: 2,
          child: Text('Asset Classification', style: _headerStyle),
        ),
        Expanded(flex: 2, child: Text('Acquisition Date', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Location', style: _headerStyle)),
        Expanded(flex: 2, child: Text('Serial Number', style: _headerStyle)),
        Expanded(
          flex: 2,
          child: Text('Person Accountable', style: _headerStyle),
        ),
        Expanded(flex: 2, child: Text('Acquisition Cost', style: _headerStyle)),
        Icon(Icons.check_box_outline_blank, color: Colors.white),
      ],
    );
  }

  Widget _buildTableRow(int number, Map item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('$number', style: _rowStyle)),
          Expanded(
            flex: 2,
            child: Text(item['Brand_Model'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Property_Number'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Asset_Classification'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Acquisition_Date'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Location'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Serial_Number'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Person_Accountable'] ?? '-', style: _rowStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(item['Acquisition_Cost'] ?? '-', style: _rowStyle),
          ),
          const Icon(Icons.check_box_outline_blank, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildStatusAndButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF183B65),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.topLeft,
            child: const Text(
              'STATUS',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildButton(
                "Print",
                Icons.print,
                Colors.white,
                Colors.black,
                onPressed: _printReport,
              ),
              const SizedBox(height: 10),
              _buildButton(
                "Add",
                Icons.add,
                Colors.teal,
                Colors.white,
                onPressed: () {
                  _showAddItemDialog(context);
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                "Update",
                Icons.update,
                Colors.blue,
                Colors.white,
                onPressed: _updateItem,
              ),
              const SizedBox(height: 10),
              _buildButton(
                "Delete",
                Icons.delete,
                Colors.red,
                Colors.white,
                onPressed: _deleteItem,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    String label,
    IconData icon,
    Color bgColor,
    Color textColor, {
    required void Function() onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, color: textColor),
        label: Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Item Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(hintText: 'Item Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the item to the database or perform an action
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _printReport() {
    // Implement print functionality
    print('Printing report...');
  }

  void _updateItem() {
    // Implement item update functionality
    print('Updating item...');
  }

  void _deleteItem() {
    // Implement item deletion functionality
    print('Deleting item...');
  }

  static const TextStyle _headerStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _rowStyle = TextStyle(color: Colors.white);
}

// Drawer Widget
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.insert_chart_outlined),
            title: const Text('Report & Export'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ReportScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
