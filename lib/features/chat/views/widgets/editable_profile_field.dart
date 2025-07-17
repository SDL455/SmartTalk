import 'package:flutter/material.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';

class EditableProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;

  const EditableProfileField({
    required this.label,
    required this.controller,
    required this.isEditing,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isEditing ? Colors.grey[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isEditing
                ? Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  )
                : Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(icon, color: AppTheme.primaryColor, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: isEditing,
                  obscureText: isPassword && !isPasswordVisible,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 4,
                    ),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
              if (isPassword && isEditing)
                IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
