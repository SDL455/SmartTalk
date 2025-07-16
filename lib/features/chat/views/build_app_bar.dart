import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/cores/models/chat.dart';

import '../../../cores/colors/ັapp_theme.dart';

Widget buildAppBar(Chat? chat) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppTheme.whatsAppGreen, AppTheme.whatsAppLightGreen],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppTheme.whatsAppGreen.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          Hero(
            tag: 'avatar_${chat ?? "default"}',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Text(
                  chat?.avatar ?? 'U',
                  style: TextStyle(
                    color: AppTheme.whatsAppGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat?.name ?? 'ຜູ້ໃຊ້',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.whatsAppAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ອອນລາຍ',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam, color: Colors.white, size: 22),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.call, color: Colors.white, size: 22),
        ),
      ],
    ),
  );
}
