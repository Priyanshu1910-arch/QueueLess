
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard> {
  static const Color primary = Color(0xFF6C4CF1);

  final String baseUrl = 'http://10.0.2.2:8080';

  int totalUsers = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  // REFRESH PAGE
  void refreshPage() {
    fetchDashboardData();
  }

  // FETCH TOTAL USERS
  Future<void> fetchDashboardData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt');

      if (token == null || token.isEmpty) {
        throw Exception('Admin token not found');
      }

      final response = await http.get( Uri.parse('$baseUrl/api/user/count'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (!mounted) return;

        setState(() {
          totalUsers = data.length;
          isLoading = false;
        });
      } else {
        throw Exception(
          'Failed to fetch users: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to fetch dashboard data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchDashboardData,
        
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(18),
        
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
        
              children: [
        
                // WELCOME SECTION
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
        
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8065F6),
                        Color(0xFF6043DD),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
        
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
        
                    children: [
        
                      Container(
                        padding: const EdgeInsets.all(12),
        
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
        
                        child: const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
        
                      const SizedBox(height: 18),
        
                      const Text(
                        'Welcome, Admin!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        
                      const SizedBox(height: 8),
        
                      const Text(
                        'Manage your QueueLess platform and '
                            'monitor everything from one place.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
        
                      const SizedBox(height: 15),
        
                      Row(
                        children: [
                          const Icon(
                            Icons.shield_outlined,
                            color: Colors.white70,
                            size: 16,
                          ),
        
                          const SizedBox(width: 6),
        
                          Text(
                            'Platform Administrator',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
        
                // PLATFORM OVERVIEW
                const Text(
                  'Platform Overview',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'A quick look at your platform performance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
        
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1.35,
        
                  children: [
        
                    const AdminStatCard(
                      title: 'Total Businesses',
                      value: '--',
                      icon: Icons.business,
                      color: Color(0xFF6C4CF1),
                    ),
        
                    const AdminStatCard(
                      title: 'Pending Businesses',
                      value: '--',
                      icon: Icons.pending_actions,
                      color: Color(0xFFE99A28),
                    ),
        
                    const AdminStatCard(
                      title: 'Approved Businesses',
                      value: '--',
                      icon: Icons.verified,
                      color: Color(0xFF26A269),
                    ),
        
                    AdminStatCard(
                      title: 'Total Users',
                      value: isLoading ? '...' : '$totalUsers',
                      icon: Icons.people_alt_outlined,
                      color: const Color(0xFF2696D8),
                    ),
                  ],
                ),
        
                const SizedBox(height: 28),
        
                // PLATFORM MANAGEMENT
        
                const Text(
                  'Platform Management',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
                const SizedBox(height: 14),
        
                Container(
                  padding: const EdgeInsets.all(17),
        
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                  ),
        
                  child: Column(
                    children: [
        
                      // USER MANAGEMENT
        
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
        
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'User Management screen will be added next',
                              ),
                            ),
                          );
                        },
        
                        child: Row(
                          children: [
        
                            Container(
                              padding: const EdgeInsets.all(11),
        
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF4FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
        
                              child: const Icon(
                                Icons.people_outline,
                                color: Color(0xFF2696D8),
                              ),
                            ),
        
                            const SizedBox(width: 13),
        
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
        
                                children: [
        
                                  Text(
                                    'User Management',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
        
                                  SizedBox(height: 4),
        
                                  Text(
                                    'Monitor registered accounts',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
        
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
        
                      const Divider(height: 25),
        
                      // PLATFORM ANALYTICS
        
                      Row(
                        children: [
        
                          Container(
                            padding: const EdgeInsets.all(11),
        
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9F8EF),
                              borderRadius: BorderRadius.circular(12),
                            ),
        
                            child: const Icon(
                              Icons.analytics_outlined,
                              color: Colors.green,
                            ),
                          ),
        
                          const SizedBox(width: 13),
        
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
        
                              children: [
        
                                Text(
                                  'Platform Analytics',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
        
                                SizedBox(height: 4),
        
                                Text(
                                  'Monitor platform growth and activity',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
        
                          const Icon(
                            Icons.lock_outline,
                            size: 17,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// STATISTICS CARD
// ======================================================

class AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const AdminStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Icon(
            icon,
            color: color,
            size: 27,
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
