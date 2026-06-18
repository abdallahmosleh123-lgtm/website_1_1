// lib/widgets/e_logo.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ELogoWidget extends StatelessWidget {
  final double size;
  final bool showText;

  const ELogoWidget({super.key, this.size = 80, this.showText = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: _ELogoPainter()),
        ),
        if (showText) ...[
          const SizedBox(width: 14),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
                child: Text(
                  "emy's",
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: size * 0.45,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                'COSMETICS',
                style: TextStyle(
                  fontSize: size * 0.14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textLight,
                  letterSpacing: size * 0.04,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ELogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.46;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // ── Gradient circle background ──────────────────────────────────────────
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF2D78), Color(0xFFC77DFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawCircle(Offset(cx, cy), r, bgPaint);

    // ── Soft inner glow ─────────────────────────────────────────────────────
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.18),
          Colors.transparent,
        ],
        radius: 0.7,
      ).createShader(rect);
    canvas.drawCircle(Offset(cx, cy * 0.7), r * 0.6, glowPaint);

    // ── Geometric E ─────────────────────────────────────────────────────────
    final ePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final sw = size.width * 0.07; // stroke/bar thickness
    final left = cx - size.width * 0.18;
    final right = cx + size.width * 0.16;
    final top = cy - size.height * 0.26;
    final bottom = cy + size.height * 0.26;
    final midY = cy - size.height * 0.01;
    final midRight = cx + size.width * 0.09; // middle bar is shorter

    // Vertical spine
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, sw, bottom - top),
        const Radius.circular(2),
      ),
      ePaint,
    );
    // Top bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, right - left, sw),
        const Radius.circular(2),
      ),
      ePaint,
    );
    // Middle bar (slightly shorter)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, midY - sw / 2, midRight - left, sw),
        const Radius.circular(2),
      ),
      ePaint,
    );
    // Bottom bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, bottom - sw, right - left, sw),
        const Radius.circular(2),
      ),
      ePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
