import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0E6FF), // Light purple background matching the design
      body: Column(
        children: [
          // Header Section with Logo and Title
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            color: Color(0xFF8A56AC), // Purple background color for the header
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png', // Replace with your logo asset path
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Text(
                  'MBA International Pharma',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              children: [
                buildMenuItem(
                  icon: Icons.shopping_cart,
                  text: 'Orders',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.format_list_numbered,
                  text: 'Order List',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.check_box,
                  text: 'Order Approval',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.cloud_download,
                  text: 'Download Invoice',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.attach_money,
                  text: 'Pending Bills',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.book,
                  text: 'Ledger',
                  onTap: () {},
                ),
                buildMenuItem(
                  icon: Icons.person,
                  text: 'My Profile',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build each menu item
  Widget buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6), // Space between items
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.deepPurple),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.deepPurple,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
        onTap: onTap,
      ),
    );
  }
}


