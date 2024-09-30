import 'package:flutter/material.dart';

class Ascreen extends StatefulWidget {
  const Ascreen({super.key});

  @override
  State<Ascreen> createState() => _AscreenState();
}

class _AscreenState extends State<Ascreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue background container
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 110, 102, 188), // Darker purple
                  Colors.white, // Light center
                ],
                radius: 2,
                center: Alignment(2.8, -1.0),
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          // Logo and text positioned on top of the container
          Positioned(
            top: 30,
            left: 20,
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png', // Replace with your logo asset path
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 10),
                const Text(
                  'MBA International Pharma',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 110, 102, 188),
                  ),
                ),
              ],
            ),
          ),
          // Grey container with rounded corners at the top
          Column(
            children: [
              const SizedBox(
                height: 120.0, // This height should be slightly less than the blue container's height
              ),
              Expanded(
                child: Container(
                  width: double.infinity, // Make it full width
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white, // Light color
                        Color.fromARGB(255, 143, 133, 230), // Darker purple
                      ],
                      stops: [0.6, 1.0], // Adjust stops to control color spread
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        buildCard(Icons.shopping_cart, 'Orders'),
                        buildCard(Icons.list, 'Order List'),
                        buildCard(Icons.approval, 'Order Approval'),
                        buildCard(Icons.download, 'Download Invoice'),
                        buildCard(Icons.money, 'Pending Bills'),
                        buildCard(Icons.book, 'Ledger'),
                        buildCard(Icons.person, 'My Profile'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A function to build each card with increased size
  Widget buildCard(IconData icon, String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10.0), // Vertical spacing between cards
      child: Container(
        height: 80, // Increase the height of each card
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align the contents to the left
          crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
          children: [
            Icon(
              icon,
              color: Color.fromARGB(255, 110, 102, 188),
              size: 40, // Increase icon size
            ),
            const SizedBox(width: 15), // Space between icon and text
            Text(
              title,
              style: const TextStyle(
                fontSize: 20, // Increase text size
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 110, 102, 188),
              ),
            ),
            const Spacer(), // Push the trailing icon to the far right
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 110, 102, 188),
              size: 25, // Increase the trailing icon size
            ),
          ],
        ),
      ),
    );
  }
}
