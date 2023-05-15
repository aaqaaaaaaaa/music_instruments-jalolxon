import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
        child: child,
      ),
    );
  }
}
