import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

  const ResponsiveLayout({super.key, required this.portrait, required this.landscape});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return portrait;
        }
        else {
          return landscape;
        }
      },
    );
  }
}