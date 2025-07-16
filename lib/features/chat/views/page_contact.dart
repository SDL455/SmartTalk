import 'package:flutter/material.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/features/chat/views/message_page.dart';

class Contact {
  final String name;
  final String phone;
  final String email;
  final String avatarUrl;

  Contact({
    required this.name,
    required this.phone,
    required this.email,
    required this.avatarUrl,
  });
}

class PageContact extends StatelessWidget {
  const PageContact({super.key});

  List<Contact> get contacts => [
    Contact(
      name: '\u0eaa\u0eb8\u0e9e\u0eb1\u0e99\u0e99\u0eb0',
      phone: '020-12345678',
      email: 'supanna@email.com',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    Contact(
      name: '\u0e88\u0eb1\u0e99\u0e97\u0eb0\u0e27\u0ebb\u0e87',
      phone: '020-87654321',
      email: 'chanthavong@email.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          '\u0ea5\u0eb2\u0e8d\u0e8a\u0eb7\u0ec9\u0e95\u0eb4\u0e94\u0e95\u0ec8\u0ead',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(contact.avatarUrl),
            ),
            title: Text(
              contact.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text('\u0ec0\u0e9a\u0eb5\u0ec2\u0e97: ${contact.phone}'),
                Text('\u0ead\u0eb5\u0ec0\u0ea1\u0ea7: ${contact.email}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MessagePage()),
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
