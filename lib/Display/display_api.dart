import 'package:flutter/material.dart';
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(
          "$label: ${value}",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
