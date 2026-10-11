
import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE6DF),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/customer_support.jpeg',
                  height: 140,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.support_agent_rounded,
                      color: coral,
                      size: 100,
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'How can we help?',
                  style: TextStyle(
                    color: ink,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Find answers to common questions or get in touch with the Crumbly support team.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ink, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              color: ink,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _faq(
            context,
            'How do I manage my menu?',
            'Open Settings and select Menu Management. You can add products, edit their details, or remove items.',
          ),
          _faq(
            context,
            'How do I mark a date unavailable?',
            'Open Availability from Settings or use the Calendar shortcut on your dashboard. Select a date to change its availability.',
          ),
          _faq(
            context,
            'Where can I check my sales?',
            'Open the Sales page from your dashboard to view the weekly sales chart and sales summary.',
          ),
          _faq(
            context,
            'How do I update my business details?',
            'Go to Settings, select Business Details, and update the information displayed for your bakery.',
          ),
          _faq(
            context,
            'Where can I see customer feedback?',
            'Open the Feedback page to view feedback entries and add new demo feedback.',
          ),
          const SizedBox(height: 24),
          const Text(
            'Still need help?',
            style: TextStyle(
              color: ink,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _contactTile(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'Contact details can be added by the app owner.',
            onTap: () => _showContactDialog(context),
          ),
          const SizedBox(height: 10),
          _contactTile(
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Support Chat',
            subtitle: 'Support chat is a demo feature.',
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Support Chat'),
                  content: const Text(
                    'Live support chat is not connected yet. Please add your preferred support service to enable this feature.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: coral),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Crumbly Bakery App',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _faq(BuildContext context, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF1E5DF)),
      ),
      child: ExpansionTile(
        iconColor: coral,
        collapsedIconColor: coral,
        title: Text(
          question,
          style: const TextStyle(
            color: ink,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer,
            style: const TextStyle(color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE6DF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: coral),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Email Support'),
        content: const Text(
          'Add your bakery support email address to connect this option. This demo does not send emails.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Close',
              style: TextStyle(color: coral),
            ),
          ),
        ],
      ),
    );
  }
}