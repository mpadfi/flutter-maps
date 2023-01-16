import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  //
  final int minutes;
  final String destination;

  StartMarkerPainter({
    required this.minutes,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    //* dibujar una caja blanca
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    //* sombra
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, whitePaint);

    //* caja negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    //* Textos
    //* Minutos Duración
    final textSpan = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '$minutes',
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minutesPainter.paint(canvas, const Offset(40, 35));

    //* Min Text
    const minutesText = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      text: 'Min',
    );

    final minPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );
    minPainter.paint(canvas, const Offset(40, 68));

    //* Descripción

    final locationText = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
      text: destination,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );

    final double offsetY = (destination.length > 20) ? 35 : 48;

    locationPainter.paint(canvas, Offset(120, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
