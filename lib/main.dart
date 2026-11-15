import 'package:flutter/material.dart';

void main() {
  runApp(const TawssilaApp());
}

class TawssilaApp extends StatelessWidget {
  const TawssilaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tawssila',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFF6B00),
        scaffoldBackgroundColor: const Color(0xFF0F1115),
        fontFamily: 'Cairo',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181B22),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delivery_dining, color: Color(0xFFFF6B00)),
            SizedBox(width: 8),
            Text('توصيلة', style: TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF181B22), Color(0xFF0F1115)]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFF6B00)),
            ),
            child: const Column(
              children: [
                Text('شنو راك تحوس اليوم؟', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 10),
                Text('أطلب اللي تحب، نوصلوه لك', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('المحلات القريبة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildStoreCard('Fast Food Legend', 'وجبات سريعة', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500'),
          _buildStoreCard('Pizza House', 'بيتزا', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500'),
        ],
      ),
    );
  }

  Widget _buildStoreCard(String name, String category, String imageUrl) {
    return Card(
      color: const Color(0xFF181B22),
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(category, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
