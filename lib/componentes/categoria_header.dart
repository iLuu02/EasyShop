import 'package:flutter/material.dart';

class CategoriaHeader extends StatelessWidget {
  final String categoria;
  final Color color;

  const CategoriaHeader({super.key, required this.categoria, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: Text(
          categoria,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
