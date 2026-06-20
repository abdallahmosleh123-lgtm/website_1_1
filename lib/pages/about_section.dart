// lib/pages/about_section.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: wide ? 80 : 28, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ABOUT US', style: AppTheme.labelTag),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Our ', style: AppTheme.displayMedium),
              WidgetSpan(
                child: ShaderMask(
                  shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
                  child: Text('Story',
                      style:
                          AppTheme.displayMedium.copyWith(color: Colors.white)),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 28),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: wide ? 720 : double.infinity),
            child: Text(
              "Welcome to my exclusive collection. We are committed to bringing you 100% safe, high-quality cosmetic products that you can trust. Elevate your beauty routine with confidence—try our products today, and discover the quality you deserve.",
              style: AppTheme.bodyLarge
                  .copyWith(fontSize: wide ? 17 : 15, height: 1.7),
            ),
          ),
        ],
      ),
    );
  }
}
