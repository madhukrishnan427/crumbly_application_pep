import 'package:flutter/material.dart';
import 'business_details.dart';
import 'menu_management.dart';
import 'date_allocation.dart';
import 'order_details.dart';
import 'notification_page.dart';
import 'help_support.dart';
import 'app_preference.dart';
import 'feedback_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  void _open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: coral,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (shouldSignOut == true && context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: cream,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4DA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/baker_profile.jpeg',
                        width: 68,
                        height: 68,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: coral, size: 35),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sweet Bites',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '@Sweet Bites',
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 15,
                                color: coral,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Chennai',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Edit business details',
                      onPressed: () =>
                          _open(context, const BusinessDetailsPage()),
                      icon: const Icon(Icons.edit_outlined, color: coral),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 10),
                child: Text(
                  'Business',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              _SettingsTile(
                icon: Icons.storefront_outlined,
                title: 'Business Details',
                subtitle: 'Update your bakery information',
                onTap: () => _open(context, const BusinessDetailsPage()),
              ),
              _SettingsTile(
                icon: Icons.menu_book_outlined,
                title: 'Menu Management',
                subtitle: 'Add, edit or remove products',
                onTap: () => _open(context, const MenuManagementPage()),
              ),
              _SettingsTile(
                icon: Icons.calendar_month_outlined,
                title: 'Availability',
                subtitle: 'Manage unavailable dates',
                onTap: () => _open(context, const DateAllocationPage()),
              ),
              _SettingsTile(
                icon: Icons.receipt_long_outlined,
                title: 'Order Details',
                subtitle: 'Review customer orders',
                onTap: () => _open(context, const OrderDetailsPage()),
              ),
              _SettingsTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'View recent notifications',
                onTap: () => _open(context, const NotificationPage()),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 10),
                child: Text(
                  'Preferences & Support',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              _SettingsTile(
                icon: Icons.tune,
                title: 'App Preferences',
                subtitle: 'Manage app display preferences',
                onTap: () => _open(context, const AppPreferencePage()),
              ),
              _SettingsTile(
                icon: Icons.support_agent,
                title: 'Help & Support',
                subtitle: 'Find help and contact support',
                onTap: () => _open(context, const HelpSupportPage()),
              ),
              _SettingsTile(
                icon: Icons.reviews_outlined,
                title: 'Customer Feedback',
                subtitle: 'View and add feedback entries',
                onTap: () => _open(context, const FeedbackPage()),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFF3E4DE)),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => _confirmSignOut(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF3E4DE)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE4DA),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: const Color(0xFFF7636B)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}