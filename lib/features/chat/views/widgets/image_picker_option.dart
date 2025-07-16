import 'package:flutter/material.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ImagePickerBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    // Main green color (use your theme color if any)
    final mainColor = Color(0xFF005F50);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F6),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: mainColor, width: 4),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PickerButton(
              icon: Icons.camera_alt,
              label: 'Take Photo',
              color: mainColor,
              onTap: onCameraTap,
            ),
            const SizedBox(height: 24),
            _PickerButton(
              icon: Icons.photo_library,
              label: 'Choose from Gallery',
              color: mainColor,
              onTap: onGalleryTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PickerButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F8F6),
      borderRadius: BorderRadius.circular(32),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.07),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(width: 28),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
