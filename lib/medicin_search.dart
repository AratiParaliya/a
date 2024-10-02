import 'package:a/add_to_cart_screen.dart';
import 'package:a/cart.dart';
import 'package:a/medicine_details_screen.dart';
import 'package:a/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

// Dummy pages for different tabs
class MedicinSearch extends StatefulWidget {
  const MedicinSearch({super.key});

  @override
  State<MedicinSearch> createState() => _MedicinSearchState();
}

enum _SelectedTab { home, cart, search, profile }

class _MedicinSearchState extends State<MedicinSearch> {
  _SelectedTab _selectedTab = _SelectedTab.search;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // Handle tab changes
  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  // Update the search query
  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase(); // Make it case-insensitive
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // IndexedStack to switch between different tabs/screens
            IndexedStack(
              index: _SelectedTab.values.indexOf(_selectedTab),
              children: [
                MedicinSearch(), // Home screen
                Cart(),
                Profilepage(), // Cart screen
                // Medicine Search screen (your original search UI)
                SafeArea(
                  child: Stack(
                    children: [
                      // Blue background container
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromARGB(255, 110, 102, 188),
                              Colors.white,
                            ],
                            radius: 2,
                            center: Alignment(2.8, -1.0),
                            tileMode: TileMode.clamp,
                          ),
                        ),
                      ),
                      // Positioned logo and text
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
                          const SizedBox(height: 100.0), // Adjust to match the blue container
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white,
                                    Color.fromARGB(255, 143, 133, 230), // Darker purple
                                  ],
                                  stops: [0.6, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    // Search bar
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged: _updateSearchQuery, // Update search query on text change
                                        decoration: const InputDecoration(
                                          hintText: 'Search...',
                                          border: InputBorder.none,
                                          icon: Icon(Icons.search),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // Product list integrated with dynamic navigation
                                    Expanded(
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('product').snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text('Error: ${snapshot.error}'));
                                          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                            return const Center(child: Text('No products found.'));
                                          } else {
                                            final medicines = snapshot.data!.docs.where((doc) {
                                              String medicineName = (doc['medicineName'] ?? '').toString().toLowerCase();
                                              return medicineName.contains(searchQuery);
                                            }).toList();

                                            return ListView.builder(
                                              padding: const EdgeInsets.only(bottom: 80),
                                              itemCount: medicines.length,
                                              itemBuilder: (context, index) {
                                                final medicine = medicines[index];
                                                String medicineName = medicine['medicineName'] ?? 'Unknown Medicine';
                                                String genericName = medicine['genericName'] ?? 'Unknown Generic Name';
                                                double price = (medicine['price'] is double)
                                                    ? medicine['price']
                                                    : (medicine['price'] is int) ? (medicine['price'] as int).toDouble() : 0.0;

                                                return GestureDetector(
                                                  onTap: () {
                                                    // Navigate to MedicineDetails page with dynamic documentId
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => MedicineDetails(
                                                          documentId: medicine.id,
                                                          medicineName: medicineName,
                                                          genericName: genericName,
                                                          price: price, // Pass the dynamic documentId
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.90,
                                                      margin: const EdgeInsets.only(bottom: 16),
                                                      padding: const EdgeInsets.all(16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(12),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.2),
                                                            spreadRadius: 2,
                                                            blurRadius: 7,
                                                            offset: const Offset(0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                medicineName,
                                                                style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Text(genericName),
                                                              Text('\$${price.toStringAsFixed(2)}'),
                                                            ],
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.add_shopping_cart,
                                                              color: Color.fromARGB(255, 143, 133, 230),
                                                              size: 30,
                                                            ),
                                                            onPressed: () {
                                                              // Navigate to the AddToCartScreen and pass the details
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => AddToCartScreen(
                                                                    medicineName: medicineName,
                                                                    genericName: genericName,
                                                                    price: price,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 // Profile screen
              ],
            ),                // DotNavigationBar for bottom navigation
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 143, 133, 230),
                    borderRadius: BorderRadius.only(
                     
                    ),
                  ),
                  child: DotNavigationBar(
                    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                    dotIndicatorColor: Color.fromARGB(255, 143, 133, 230),
                    unselectedItemColor: Colors.grey[300],
                    splashBorderRadius: 50,
                    onTap: _handleIndexChanged,
                    items: [
                      DotNavigationBarItem(
                        icon: const Icon(Icons.home),
                        selectedColor: const Color(0xff73544C),
                      ),
                      DotNavigationBarItem(
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        selectedColor: const Color(0xff73544C),
                      ),
                     
                      DotNavigationBarItem(
                        icon: const Icon(Icons.person),
                        selectedColor: const Color(0xff73544C),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          
        
      ),
    );
  }
}
