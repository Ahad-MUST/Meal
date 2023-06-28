import 'package:flutter/material.dart';

class MealItemRow extends StatelessWidget {
  const MealItemRow({super.key, required this.icon, required this.label});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        )
      ],
    );
  }
}
