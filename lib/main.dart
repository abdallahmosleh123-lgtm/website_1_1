import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'pages/splash_screen.dart';
import 'pages/hero_section.dart';
import 'pages/products_section.dart';
import 'widget/navbar.dart'; // was 'widgets/navbar.dart'

void main() {
  runApp(const EmysCosmeticsApp());
}

class EmysCosmeticsApp extends StatelessWidget {
  const EmysCosmeticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Emy's Cosmetics",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.bgPage,
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.pink),
        useMaterial3: true,
      ),
      home: const MainWebsiteLayout(),
    );
  }
}

class MainWebsiteLayout extends StatefulWidget {
  const MainWebsiteLayout({super.key});

  @override
  State<MainWebsiteLayout> createState() => _MainWebsiteLayoutState();
}

class _MainWebsiteLayoutState extends State<MainWebsiteLayout> {
  bool _showSplash = true;
  final ScrollController _scrollCtrl = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              children: [
                HeroSection(visible: !_showSplash),
                Container(
                  key: _productsKey,
                  child: const ProductsSection(),
                ),
                Container(
                  key: _aboutKey,
                  height: 400,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "About Us Section\n(Build this next!)",
                    textAlign: TextAlign.center,
                    style: AppTheme.headingMedium
                        .copyWith(color: AppTheme.textMid),
                  ),
                ),
                Container(
                  key: _contactKey,
                  height: 300,
                  color: AppTheme.bgSection,
                  alignment: Alignment.center,
                  child: Text(
                    "Footer & Contact Info",
                    style: AppTheme.headingMedium
                        .copyWith(color: AppTheme.textMid),
                  ),
                ),
              ],
            ),
          ),
          if (!_showSplash)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                scrollCtrl: _scrollCtrl,
                productsKey: _productsKey,
                aboutKey: _aboutKey,
                contactKey: _contactKey,
              ),
            ),
          if (_showSplash)
            Positioned.fill(
              child: SplashScreen(
                onDone: () {
                  setState(() {
                    _showSplash = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
