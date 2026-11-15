import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
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
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. شاشة البداية (Splash Screen)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomePage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delivery_dining, size: 100, color: Color(0xFFFF6B00)),
                    const SizedBox(height: 20),
                    Text('توصيلة', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2)),
                    const SizedBox(height: 10),
                    Text('توصيل سريع في منطقتك', style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 2. الصفحة الرئيسية
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> restaurants = [
    {'name': 'Fast Food Legend', 'category': 'وجبات سريعة', 'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500', 'rating': 4.8},
    {'name': 'Pizza House', 'category': 'بيتزا', 'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500', 'rating': 4.5},
    {'name': 'Café El Djazair', 'category': 'مشروبات', 'image': 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=500', 'rating': 4.7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBar مخصص
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('صباح الخير،', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('شنو راك تحوس اليوم؟', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181B22),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2A2F3D)),
                      ),
                      child: const Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // خانة البحث
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF181B22),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF2A2F3D)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('ابحث عن مطعم، وجبة...', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),

            // تصنيفات (Categories)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip('الكل', Icons.apps, true),
                      _buildCategoryChip('أكل سريع', Icons.fastfood, false),
                      _buildCategoryChip('حلويات', Icons.cake, false),
                      _buildCategoryChip('مشروبات', Icons.local_cafe, false),
                    ],
                  ),
                ),
              ),
            ),

            // عنوان المحلات
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text('المحلات القريبة', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),

            // شبكة المحلات
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final r = restaurants[index];
                    return _buildStoreCard(r['name'], r['category'], r['image'], r['rating']);
                  },
                  childCount: restaurants.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF181B22),
          border: Border(top: BorderSide(color: Color(0xFF2A2F3D))),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFFF6B00),
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFF181B22),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFF2A2F3D)),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.grey, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStoreCard(String name, String category, String imageUrl, double rating) {
    return GestureDetector(
      onTap: () {
        // أنيميشن عند الضغط
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF181B22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2A2F3D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(category, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(rating.toString(), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
