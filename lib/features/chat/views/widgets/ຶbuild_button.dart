import 'package:flutter/material.dart';

Widget buildButton({
  required BuildContext context,
  required String text,
  required bool isPrimary,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      gradient: isPrimary
          ? LinearGradient(colors: [Colors.red.shade400, Colors.red.shade600])
          : null,
      color: isPrimary ? null : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: isPrimary
          ? null
          : Border.all(color: Colors.grey.shade300, width: 1),
      boxShadow: isPrimary
          ? [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : Colors.grey.shade700,
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}
