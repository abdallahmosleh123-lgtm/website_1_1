// lib/pages/products_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ProductModel {
  final String name;
  final String price;
  final String type;
  final String description;
  final Color accentColor;

  const ProductModel({
    required this.name,
    required this.price,
    required this.type,
    required this.description,
    required this.accentColor,
  });
}

final List<ProductModel> products = [
  const ProductModel(
      name: 'Silk Serum',
      price: '450 EGP',
      type: 'Serum',
      description: 'Lightweight formula for radiant skin.',
      accentColor: AppTheme.pink),
  const ProductModel(
      name: 'Matte Lipstick',
      price: '250 EGP',
      type: 'Lip Care',
      description: 'Long-lasting finish with natural ingredients.',
      accentColor: AppTheme.lilac),
  const ProductModel(
      name: 'Glow Cream',
      price: '380 EGP',
      type: 'Moisturizer',
      description: 'Hydrating cream for a natural healthy glow.',
      accentColor: AppTheme.coral),
  const ProductModel(
      name: 'Gold Mask',
      price: '500 EGP',
      type: 'Treatment',
      description: 'Anti-aging treatment with 24k gold flakes.',
      accentColor: AppTheme.gold),
  const ProductModel(
      name: 'Daily Cleanser',
      price: '290 EGP',
      type: 'Cleanser',
      description: 'Gentle cleanser for all skin types.',
      accentColor: AppTheme.pink),
  const ProductModel(
      name: 'Night Repair',
      price: '600 EGP',
      type: 'Repair',
      description: 'Overnight serum for deep rejuvenation.',
      accentColor: AppTheme.lilac),
];

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 800;

    return Container(
      color: AppTheme.bgPage,
      padding: EdgeInsets.symmetric(horizontal: wide ? 80 : 28, vertical: 90),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('OUR PRODUCTS', style: AppTheme.labelTag),
        const SizedBox(height: 14),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Made to Make You\n', style: AppTheme.displayMedium),
            WidgetSpan(
                child: ShaderMask(
                    shaderCallback: (b) =>
                        AppTheme.brandGradient.createShader(b),
                    child: Text('Glow.',
                        style: AppTheme.displayMedium
                            .copyWith(color: Colors.white)))),
          ]),
        ),
        const SizedBox(height: 52),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: wide ? 3 : 1,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: wide ? 0.78 : 1.5,
          ),
          itemCount: products.length,
          itemBuilder: (_, i) => _ProductCard(product: products[i]),
        ),
      ]),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _h ? p.accentColor : Colors.transparent),
          boxShadow: [
            BoxShadow(
              // تم التعديل هنا لاستخدام لون رمادي ثابت بدل الشفافية
              color: _h ? p.accentColor : const Color(0xFFEAEAEA),
              blurRadius: _h ? 28 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                color: p.accentColor, // لون ثابت بدلاً من الشفافية
              ),
              child: Stack(children: [
                const Center(
                    child: Icon(Icons.spa_outlined,
                        size: 56, color: Colors.white)),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(p.type,
                        style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: p.accentColor)),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      style: AppTheme.headingMedium.copyWith(fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(p.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Row(children: [
                    Text(p.price,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: p.accentColor)),
                    const Spacer(),
                    _OrderNowBtn(color: p.accentColor),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderNowBtn extends StatelessWidget {
  final Color color;
  const _OrderNowBtn({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text('Order Now',
          style: GoogleFonts.dmSans(
              fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }
}
