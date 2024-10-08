import 'package:a/contactdetail_screen.dart';
import 'package:flutter/material.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key, required String medicineName, required String genericName, required double price});

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
                height: 100.0, // This height should be slightly less than the blue container's height
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Color.fromARGB(255, 143, 133, 230), // Darker purple
                      ],
                      stops: [0.6, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Add Medicine Company Name and Medicine Name in the center
                        const Text(
                          'Medicine Company Name and Medicine Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:  Color.fromARGB(255, 143, 133, 230), 
                          ),
                        ),
                       
                        const SizedBox(height: 20),

                        _buildSectionTitle('Product Details'),
                        _buildDetailRow('Medicine Name', 'Paracetamol 500mg'),
                        _buildDetailRow('Generic Name', 'Paracetamol'),
                        _buildDetailRow('Brand', 'XYZ Pharmaceuticals'),
                        _buildDetailRow('Type', 'Tablet'),
                        _buildDetailRow('Size', '500mg'),
                        _buildDetailRow('Price', '\$10.00'),
                        const SizedBox(height: 30),

                        // Add to Cart button
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactdetailScreen()),);
                                  // Handle Add to Cart functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor:  Color.fromARGB(255, 143, 133, 230),  // Purple color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Buy Now button
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle Buy Now functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor:  Color.fromARGB(255, 143, 133, 230),  // Purple color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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

  // Helper method to build a section title (e.g., "Product Details")
  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color.fromARGB(255, 143, 133, 230), 
        ),
      ),
    );
  }

  // Helper method to build each detail row (label and value pair)
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Label (left side)
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 143, 133, 230), 
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Value (right side)
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color:  Color.fromARGB(255, 143, 133, 230), 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
