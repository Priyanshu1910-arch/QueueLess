
import 'package:flutter/material.dart';
import 'package:frontend_queueless/7.11all_categories_page.dart';
import 'package:frontend_queueless/7.0category_data.dart';
import 'package:frontend_queueless/7.1explore_categories.dart';
import 'package:frontend_queueless/9explore_page.dart';


class HomePage extends StatefulWidget {
const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
   }

 class HomePageState extends State<HomePage> {

   final TextEditingController searchController = TextEditingController();
   final List<Map<String, dynamic>> categories = [
     {'name': 'Clinic', 'icon': Icons.local_hospital_outlined},
     {'name': 'Salon', 'icon': Icons.content_cut},
     {'name': 'Lab', 'icon': Icons.science_outlined},
     {'name': 'More', 'icon': Icons.more_horiz_rounded}
   ];
   List<Map<String, dynamic>> get filteredCategories {
     String query = searchController.text.toLowerCase().trim();

     if (query.isEmpty) {
       return allCategories.take(3).toList();
     }
     return allCategories.where((category) {
       return category['name'].toLowerCase().contains(query);
     }).toList();
   }

   @override
   void dispose() {
     searchController.dispose();
     super.dispose();
   }

   // For Time(Greeting)i
   String getGreeting() {
     int hour = DateTime.now().hour;

     if (hour < 12) {
       return 'Good Morning 👋';
     } else if (hour < 17) {
       return 'Good Afternoon 👋';
     } else {
       return 'Good Evening 👋';
     }
   }

  static const Color primary = Color(0xFF6C4CF1);



  final List<Map<String, dynamic>> businesses = [
    {
   'name': 'City Care Clinic',
   'type': 'Healthcare',
   'rating': '4.8',
   'icon': Icons.local_hospital,
   },

   {
   'name': 'Style Studio',
   'type': 'Salon',
   'rating': '4.6',
   'icon': Icons.content_cut,
   },

   {
   'name': 'Health Diagnostics',
   'type': 'Diagnostic Lab',
   'rating': '4.9',
   'icon': Icons.science,
   },
  ];

   void refreshPage() {
  setState(() {});
   }

   @override
   Widget build(BuildContext context) {
   return Scaffold(
   backgroundColor: const Color(0xFFF8F7FC),

   body: SafeArea(
   child: SingleChildScrollView(
   padding: const EdgeInsets.all(20),

   child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [

     Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: [
   Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Text( getGreeting(),  style: TextStyle( fontSize: 15, color: Colors.grey,), ),
     SizedBox(height: 5),
     Text( 'Welcome to QueueLess', style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold,),),
   ],
),
   CircleAvatar( radius: 25, backgroundColor: const Color(0xFFECE7FF),
     child: Icon( Icons.person, color: primary, size: 28,),
   ),
   ],

   ),

     SizedBox(height: 25),
     TextField(

       controller: searchController,

       onChanged: (value) {
         setState(() {});
       },

       decoration: InputDecoration(hintText: 'Search clinics, salons, labs...',
       prefixIcon: const Icon(Icons.search),
       suffixIcon: const Icon(Icons.tune),
       filled: true, fillColor: Colors.white,

         contentPadding: const EdgeInsets.symmetric(vertical: 16,),

         border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide: BorderSide.none, ), ),
     ),
     SizedBox(height: 28),

     Text('Explore Categories', style: TextStyle( fontSize: 19, fontWeight: FontWeight.bold,),),
     SizedBox(height: 15),


     SingleChildScrollView(
       scrollDirection: Axis.horizontal,
       child: Row(
         children: [
           ...filteredCategories.map((category) {
             return SizedBox(
               width: 95,
               child: GestureDetector(
                 onTap: () {

                   if (category['name'] == 'More') {
                     Navigator.push(context, MaterialPageRoute(
                       builder: (context) => const AllCategoriesPage(),
                     ),
                     );
                   }
                   else{

                     Navigator.push( context, MaterialPageRoute(builder: (context) =>
                         ExploreCategory( selectedCategory: category['name'],),
                     ),);
                   }
                 },
                 child: Column(
                   children: [
                     Container(height: 60, width: 60,
                       decoration: BoxDecoration(
                         color: const Color(0xFFECE7FF),
                         borderRadius: BorderRadius.circular(18),
                       ),
                       child: Icon(category['icon'], color: primary, size: 28,),
                     ),
                     const SizedBox(height: 8),
                     Text(category['name']),
                   ],
                 ),
               ),
             );
           }),

           // More icon
           if (searchController.text.isEmpty)
             SizedBox(
               width: 95,
               child: GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const AllCategoriesPage(),
                     ),
                   );
                 },
                 child: Column(
                   children: [
                     Container(
                       height: 60,
                       width: 60,
                       decoration: BoxDecoration(
                         color: const Color(0xFFECE7FF),
                         borderRadius: BorderRadius.circular(18),
                       ),
                       child: Icon(
                         Icons.more_horiz_rounded,
                         color: primary,
                         size: 28,
                       ),
                     ),
                     const SizedBox(height: 8),
                     const Text('More'),
                   ],
                 ),
               ),
             ),
         ],
       ),
     ),

     SizedBox(height: 28),
     Text( 'Your Next Appointment', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,),),
     SizedBox(height: 15),

     Container( width: double.infinity,

       padding: const EdgeInsets.all(18),
       decoration: BoxDecoration(
         gradient: const LinearGradient(
      colors: [ Color(0xFF8065F6), Color(0xFF6043DD), ],
      ),
       borderRadius: BorderRadius.circular(20),
     ),

     child: Column( crossAxisAlignment: CrossAxisAlignment.start,

       children: [
         Text( 'CONFIRMED', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold,),),
         SizedBox(height: 12),
         Text('City Care Clinic', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),),
         SizedBox(height: 5),
         Text('General Consultation', style: TextStyle(color: Colors.white70,),),
         SizedBox(height: 18),

         Row(
           children: [
             Icon( Icons.calendar_today, color: Colors.white, size: 17,),
             SizedBox(width: 8),
             Text('02 Nov 2026', style: TextStyle(color: Colors.white),),
             SizedBox(width: 20),
             Icon(Icons.access_time, color: Colors.white, size: 17,),
             SizedBox(width: 8),
             Text('10:30 AM', style: TextStyle(color: Colors.white),),
            ],
           ),

         SizedBox(height: 18),

        SizedBox( width: double.infinity,

        child: ElevatedButton( onPressed: () {},
          style: ElevatedButton.styleFrom( backgroundColor: Colors.white, foregroundColor: primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
          ),

       child: const Text('View Appointment'),),
        ),
        ],
      ),
     ),
     SizedBox(height: 28),

     Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,

       children: [
         Text( 'Popular Businesses', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,),),
         TextButton( onPressed: () {},
           child: Text( 'See All',  style: TextStyle(color: primary), ), ),
       ],
     ),
     SizedBox(height: 10),

...businesses.map((business) {

  return
    Container( margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),),

     child: Row(

    children: [

      Container( height: 55, width: 55, decoration: BoxDecoration(color: const Color(0xFFECE7FF), borderRadius: BorderRadius.circular(15),),
      child: Icon(business['icon'], color: primary, size: 28,),
     ),
      SizedBox(width: 14),

      Expanded( // business name can be longer
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( business['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),),
          SizedBox(height: 5),
          Text( business['type'], style: const TextStyle( color: Colors.grey, fontSize: 13,),),
        ],
      ),
    ),

      Icon(Icons.star, color: Colors.amber, size: 18),
      SizedBox(width: 4),
      Text(business['rating'], style: const TextStyle(fontWeight: FontWeight.bold,),),
      ],
    ),
    );
    }),

     SizedBox(height: 15),

    ],
    ),
   ),
   ),
  );
}
}


