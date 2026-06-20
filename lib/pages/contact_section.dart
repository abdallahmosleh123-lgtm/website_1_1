// lib/pages/contact_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// TODO: put your real links here when ready
const String facebookLink = '';
const String instagramLink = '';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: AppTheme.bgSection,
      padding: EdgeInsets.symmetric(horizontal: wide ? 80 : 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('GET IN TOUCH', style: AppTheme.labelTag),
          const SizedBox(height: 14),
          Text('Contact Us',
              style: AppTheme.headingMedium.copyWith(fontSize: wide ? 32 : 24)),
          const SizedBox(height: 36),
          Wrap(
            spacing: 24,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _SocialRow(
                  icon: Icons.facebook, label: 'Facebook', link: facebookLink),
              _SocialRow(
                  icon: Icons.camera_alt_outlined,
                  label: 'Instagram',
                  link: instagramLink),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String link;
  const _SocialRow(
      {required this.icon, required this.label, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.pink, size: 22),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark)),
              Text(link.isEmpty ? 'Coming soon' : link,
                  style: GoogleFonts.dmSans(
                      fontSize: 12, color: AppTheme.textMid)),
            ],
          ),
        ],
      ),
    );
  }
}
