
import 'package:flutter/material.dart';

class ExploreCategory extends StatefulWidget {
  final String selectedCategory;

  const ExploreCategory({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<ExploreCategory> createState() => ExploreCategoryState();
}

class ExploreCategoryState extends State<ExploreCategory> {

  static const Color primary = Color(0xFF6C4CF1);

  final TextEditingController searchController =
  TextEditingController();

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> businesses = [
    {
      'name': 'City Care Clinic',
      'type': 'General Physician',
      'rating': '4.8',
      'distance': '1.2 km',
      'available': true,
      'icon': Icons.local_hospital,
    },
    {
      'name': 'Health Plus Center',
      'type': 'Multi Speciality',
      'rating': '4.6',
      'distance': '2.5 km',
      'available': true,
      'icon': Icons.medical_services,
    },
    {
      'name': 'Wellness Care',
      'type': 'Healthcare',
      'rating': '4.5',
      'distance': '3.0 km',
      'available': false,
      'icon': Icons.health_and_safety,
    },
  ];

  List<Map<String, dynamic>> get filteredBusinesses {

    String query = searchController.text.toLowerCase().trim();

    return businesses.where((business) {

      bool matchesSearch =
      business['name'].toLowerCase().contains(query);

      bool matchesFilter = true;

      if (selectedFilter == 'Available Today') {
        matchesFilter = business['available'];
      }

      if (selectedFilter == 'Top Rated') {
        matchesFilter = double.parse(business['rating']) >= 4.7;
      }

      return matchesSearch && matchesFilter;

    }).toList();
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7FC),
        elevation: 0,
        title: Text(
          'Explore ${widget.selectedCategory}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Find the right place for you',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // Search bar
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText:
                  'Search ${widget.selectedCategory}...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Filters
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'All',
                    'Nearby',
                    'Top Rated',
                    'Available Today',
                  ].map((filter) {
                    bool isSelected =
                        selectedFilter == filter;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primary
                              : Colors.white,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 25),

              // Business heading
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Places',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${filteredBusinesses.length} results',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Business listing
              if (filteredBusinesses.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'No businesses found.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

              ...filteredBusinesses.map((business) {

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Column(
                    children: [

                      Row(
                        children: [

                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: const Color(0xFFECE7FF),
                              borderRadius:
                              BorderRadius.circular(15),
                            ),
                            child: Icon(
                              business['icon'],
                              color: primary,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  business['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  business['type'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      business['rating'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      business['distance'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            business['available']
                                ? 'Available Today'
                                : 'Currently Unavailable',
                            style: TextStyle(
                              color: business['available']
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              // Business details navigation
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('View Details'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
