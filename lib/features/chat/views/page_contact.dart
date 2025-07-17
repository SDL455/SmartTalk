import 'package:flutter/material.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/features/chat/views/message_page.dart';
import 'package:get/get.dart';
import 'package:whatsapp/features/chat/controllers/contact_controller.dart';

class PageContact extends StatelessWidget {
  const PageContact({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactController contactController = Get.put(ContactController());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text('ລາຍຊື່ຕິດຕໍ່'),
      ),
      body: Obx(() {
        if (contactController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final users = contactController.onlineUsers;
        if (users.isEmpty) {
          return Center(child: Text('ບໍ່ມີຜູ້ໃຊ້ online ໃນຂະນະນີ້'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage:
                    user.photoUrl != null && user.photoUrl!.isNotEmpty
                    ? NetworkImage(user.photoUrl!)
                    : null,
                child: (user.photoUrl == null || user.photoUrl!.isEmpty)
                    ? Icon(Icons.person, size: 32)
                    : null,
              ),
              title: Text(
                user.displayName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  if (user.phone != null) Text('ເບີໂທ: ${user.phone}'),
                  if (user.email != null) Text('ອີເມວ: ${user.email}'),
                  Text(
                    'ສະຖານະ: ${user.status ?? "-"}',
                    style: TextStyle(
                      color: user.status == 'online'
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Get.to(() => MessagePage(), arguments: user);
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.primaryColor,
              ),
            );
          },
        );
      }),
    );
  }
}
