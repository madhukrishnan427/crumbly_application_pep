import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Order Received',
      'message': 'You have received order CB1001 for a Chocolate Cake.',
      'time': '10 minutes ago',
      'icon': Icons.shopping_bag_outlined,
      'read': false,
    },
    {
      'title': 'Order Completed',
      'message': 'Order CB0998 has been marked as completed.',
      'time': '1 hour ago',
      'icon': Icons.check_circle_outline,
      'read': false,
    },
    {
      'title': 'Weekly Sales Update',
      'message': 'Your bakery sales summary is ready to review.',
      'time': 'Yesterday',
      'icon': Icons.trending_up,
      'read': true,
    },
  ];

  void _markAllRead() {
    setState(() {
      for (final notification in notifications) {
        notification['read'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount =
        notifications.where((item) => item['read'] == false).length;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: cream,
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(color: coral),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Text(
                unreadCount == 0
                    ? 'You are all caught up!'
                    : '$unreadCount unread notification(s)',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              if (notifications.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(35),
                  child: Center(
                    child: Text('No notifications yet.'),
                  ),
                ),
              ...notifications.map((notification) {
                final isRead = notification['read'] as bool;

                return Card(
                  color: isRead ? Colors.white : const Color(0xFFFFEEE8),
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: Color(0xFFF3E4DE)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        notification['icon'] as IconData,
                        color: coral,
                      ),
                    ),
                    title: Text(
                      notification['title'] as String,
                      style: TextStyle(
                        fontWeight:
                        isRead ? FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification['message'] as String),
                          const SizedBox(height: 7),
                          Text(
                            notification['time'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          if (value == 'read') {
                            notification['read'] = true;
                          } else if (value == 'unread') {
                            notification['read'] = false;
                          } else if (value == 'delete') {
                            notifications.remove(notification);
                          }
                        });
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: isRead ? 'unread' : 'read',
                          child: Text(
                            isRead ? 'Mark unread' : 'Mark as read',
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}