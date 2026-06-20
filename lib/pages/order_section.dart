// lib/pages/order_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// TODO: put your InstaPay number / link here when ready
const String instaPayInfo = '';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: AppTheme.bgPage,
      padding: EdgeInsets.symmetric(horizontal: wide ? 80 : 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('HOW TO ORDER', style: AppTheme.labelTag),
          const SizedBox(height: 14),
          Text('Order Now',
              style: AppTheme.headingMedium.copyWith(fontSize: wide ? 32 : 24)),
          const SizedBox(height: 28),
          Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
            decoration: BoxDecoration(
              gradient: AppTheme.brandGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text('InstaPay',
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Text(
                  instaPayInfo.isEmpty ? 'Details coming soon' : instaPayInfo,
                  style: GoogleFonts.dmSans(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
