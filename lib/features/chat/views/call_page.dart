import 'package:flutter/material.dart';

class CallEntry {
  final String name;
  final String avatarUrl;
  final String time;
  final CallType type;

  CallEntry({
    required this.name,
    required this.avatarUrl,
    required this.time,
    required this.type,
  });
}

enum CallType { incoming, outgoing, missed }

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  List<CallEntry> get calls => [
    CallEntry(
      name: 'ສຸພັນນະ',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      time: '09:30 ນ.',
      type: CallType.incoming,
    ),
    CallEntry(
      name: 'ຈັນທະວົງ',
      avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      time: '08:15 ນ.',
      type: CallType.outgoing,
    ),
    CallEntry(
      name: 'ສຸພັນນະ',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      time: '07:00 ນ.',
      type: CallType.missed,
    ),
  ];

  IconData _getCallIcon(CallType type) {
    switch (type) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
    }
  }

  Color _getCallIconColor(CallType type) {
    switch (type) {
      case CallType.incoming:
        return Colors.green;
      case CallType.outgoing:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(call.avatarUrl),
            ),
            title: Text(
              call.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Row(
              children: [
                Icon(
                  _getCallIcon(call.type),
                  color: _getCallIconColor(call.type),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(call.time, style: TextStyle(fontSize: 15)),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call, color: Color(0xFF075E54)),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
