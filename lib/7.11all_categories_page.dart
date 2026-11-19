
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_queueless/9explore_page.dart';
import 'package:frontend_queueless/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllCategoriesPage extends StatefulWidget {
const AllCategoriesPage({super.key});

@override
State<AllCategoriesPage> createState() => AllCategoriesPageState();
}

class AllCategoriesPageState extends State<AllCategoriesPage> {

  static const Color primary = Color(0xFF6C4CF1);

  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  String? loadError;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  List<Map<String, dynamic>> get filteredCategories {
  String query = searchController.text.toLowerCase();
  return categories.where((category) {
    return (category['name'] ?? '').toString().toLowerCase().contains(query);
  }).toList();
  }

  Future<void> fetchCategories() async {
    if (mounted) {
      setState(() {
        isLoading = true;
        loadError = null;
      });
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt');
      final response = await http.get(
        ApiConfig.apiEndpoint('/api/categories'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch categories (${response.statusCode})');
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) throw const FormatException('Invalid categories response');
      if (!mounted) return;
      setState(() {
        categories = decoded
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .where((item) => item['active'] != false)
            .toList();
        isLoading = false;
        loadError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        loadError = 'Unable to load categories. Check your connection and try again.';
      });
    }
  }

  Widget categoryIcon(Map<String, dynamic> category) {
    final codePoint = category['iconCodePoint'];
    if (codePoint == null) {
      return const Icon(Icons.category_outlined, color: primary, size: 28);
    }
    return Icon(
      IconData(
        (codePoint as num).toInt(),
        fontFamily: category['iconFontFamily']?.toString() ?? 'MaterialIcons',
      ),
      color: primary,
      size: 28,
    );
  }

  void selectCategory(String category) {
    final selected = categories.firstWhere((item) => item['name'] == category);
    final id = (selected['id'] as num).toInt();
    Navigator.push(context, MaterialPageRoute(builder: (_) => ExplorePage(initialCategoryId: id)));
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


      body: SafeArea(
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [

                IconButton( onPressed: () {
                  Navigator.pop(context); },
                  icon: const Icon(Icons.arrow_back), ),

                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
                      SizedBox(height: 4),
                      Text('Find the right service for you', style: TextStyle(fontSize: 13, color: Colors.grey,),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
            TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {});
                },

              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Popular Categories', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,),),
            ),
          ),
          SizedBox(height: 15),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: isLoading || loadError != null
                  ? 1
                  : filteredCategories.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 18,
                childAspectRatio: 0.85,),

              itemBuilder: (context, index) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (loadError != null) {
                  return Center(
                    child: TextButton.icon(
                      onPressed: fetchCategories,
                      icon: const Icon(Icons.refresh),
                      label: Text(loadError!),
                    ),
                  );
                }
                final category = filteredCategories[index];

                return GestureDetector(
                  onTap: () {
                    selectCategory(category['name'].toString());
                    },

                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(18),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 55, width: 55,
                          decoration: BoxDecoration(color: const Color(0xFFECE7FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: categoryIcon(category),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4,),

                          child:
                          Text(category['name']?.toString() ?? 'Unnamed', textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, ),),
                        ),
                      ],
                    ),
                  ),
                );
},
),
),
        ],
        ),
      ),
    );
  }
}
