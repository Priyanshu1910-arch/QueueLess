
import 'package:flutter/material.dart';
import 'package:frontend_queueless/7home_page.dart';
import 'package:frontend_queueless/8booking_page.dart';
import 'package:frontend_queueless/9explore_page.dart';
import 'package:frontend_queueless/10profile_page.dart';

// Global keys to access page methods
final GlobalKey<HomePageState> homeKey = GlobalKey<HomePageState>();
final GlobalKey<ExplorePageState> exploreKey = GlobalKey<ExplorePageState>();
final GlobalKey<BookingPageState> bookingsKey = GlobalKey<BookingPageState>();
final GlobalKey<ProfilePageState> profileKey = GlobalKey<ProfilePageState>();

class BottomNavigator extends StatefulWidget {
const BottomNavigator({super.key});

@override
State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
int selectedIndex = 0;

   final PageController pageController = PageController();
   static const Color primary = Color(0xFF6C4CF1);

  void onTapped(int index) {
   pageController.animateToPage( index, duration: const Duration(milliseconds: 300),
   curve: Curves.easeInOut,
    );
  }

// Global methods to access page functionality
   void refreshHome() {
   homeKey.currentState?.refreshPage();
   }

   void refreshExplore() {
   exploreKey.currentState?.refreshPage();
   }

   void refreshBookings() {
   bookingsKey.currentState?.refreshPage();
   }

   void refreshProfile() {
   profileKey.currentState?.refreshPage();
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
   HomePage(key: homeKey),
   ExplorePage(key: exploreKey),
   BookingPage(key: bookingsKey),
   ProfilePage(key: profileKey),
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
   icon: Icon(Icons.home_outlined),
   activeIcon: Icon(Icons.home_rounded),
   label: 'Home',
   ),

   BottomNavigationBarItem(
   icon: Icon(Icons.explore_outlined),
   activeIcon: Icon(Icons.explore_rounded),
   label: 'Explore',
   ),

   BottomNavigationBarItem(
   icon: Icon(Icons.calendar_month_outlined),
   activeIcon: Icon(Icons.calendar_month_rounded),
   label: 'Bookings',
   ),

   BottomNavigationBarItem(
   icon: Icon(Icons.person_outline_rounded),
   activeIcon: Icon(Icons.person_rounded),
   label: 'Profile',
   ),
   ],

  ),
  );


}
}
