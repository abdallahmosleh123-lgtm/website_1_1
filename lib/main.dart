import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'pages/splash_screen.dart';
import 'pages/hero_section.dart';
import 'pages/products_section.dart';
import 'pages/about_section.dart';
import 'pages/order_section.dart';
import 'pages/contact_section.dart';
import 'widget/navbar.dart';

void main() {
  runApp(const EmysCosmeticsApp());
}

class EmysCosmeticsApp extends StatelessWidget {
  const EmysCosmeticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dr Emy's Cosmetics",
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
  final GlobalKey _orderKey = GlobalKey();
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
                  child: const AboutSection(),
                ),
                Container(
                  key: _orderKey,
                  child: const OrderSection(),
                ),
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
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
                orderKey: _orderKey,
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
