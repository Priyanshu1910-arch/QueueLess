
import 'package:flutter/material.dart';
import 'package:frontend_queueless/14.0admin_home.dart';
import 'package:frontend_queueless/14.1admin_business.dart';
import 'package:frontend_queueless/14.2admin_categories.dart';
import 'package:frontend_queueless/14.3admin_request.dart';

// Global keys to access page methods

final GlobalKey<AdminDashboardState> adminHomeKey =
GlobalKey<AdminDashboardState>();

final GlobalKey<AdminBusinessesState> adminBusinessesKey =
GlobalKey<AdminBusinessesState>();

final GlobalKey<AdminCategoriesState> adminCategoriesKey =
GlobalKey<AdminCategoriesState>();

final GlobalKey<AdminRequestsState> adminRequestsKey =
GlobalKey<AdminRequestsState>();

class AdminBottomNavigator extends StatefulWidget {
  const AdminBottomNavigator({super.key});

  @override
  State<AdminBottomNavigator> createState() =>
      _AdminBottomNavigatorState();
}

class _AdminBottomNavigatorState extends State<AdminBottomNavigator> {

  int selectedIndex = 0;

  final PageController pageController = PageController();

  static const Color primary = Color(0xFF6C4CF1);

  // Navigate between pages
  void onTapped(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Global methods to access page functionality

  void refreshHome() {
    adminHomeKey.currentState?.refreshPage();
  }

  void refreshBusinesses() {
    adminBusinessesKey.currentState?.refreshPage();
  }

  void refreshCategories() {
    adminCategoriesKey.currentState?.refreshPage();
  }

  void refreshRequests() {
    adminRequestsKey.currentState?.refreshPage();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: PageView(
        controller: pageController,

        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        children: [

          AdminDashboard(key: adminHomeKey),

          AdminBusinesses(key: adminBusinessesKey),

          AdminCategories(key: adminCategoriesKey),

          AdminRequests(key: adminRequestsKey),

        ],
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: selectedIndex,

        onTap: onTapped,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: primary,

        unselectedItemColor: Colors.grey,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            activeIcon: Icon(Icons.business_rounded),
            label: 'Businesses',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category_rounded),
            label: 'Categories',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_outlined),
            activeIcon: Icon(Icons.pending_actions_rounded),
            label: 'Requests',
          ),

        ],
      ),
    );
  }
}
