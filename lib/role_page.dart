
import 'package:flutter/material.dart';
import 'login_page.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  static const Color coral = Color(0xFFFF5B68);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);

  void _openLogin(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage(role: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(flex: 2),

                            // Crumbly logo
                            Center(
                              child: Image.asset(
                                'assets/images/logo_crumbly.png',
                                height: 105,
                                width: 260,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) {
                                  return const Text(
                                    'Crumbly',
                                    style: TextStyle(
                                      color: coral,
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Welcome to Crumbly!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ink,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Choose how you would like to continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 34),

                            // Home Baker card
                            _RoleCard(
                              emoji: '👩🏻‍🍳',
                              title: 'Home Baker',
                              subtitle: 'Manage your bakery and orders',
                              onTap: () =>
                                  _openLogin(context, 'Home Baker'),
                            ),

                            const SizedBox(height: 18),

                            // Customer card
                            _RoleCard(
                              emoji: '🍰',
                              title: 'Customer',
                              subtitle: 'Discover delicious treats',
                              onTap: () =>
                                  _openLogin(context, 'Customer'),
                            ),

                            const Spacer(flex: 3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const Color coral = Color(0xFFFF5B68);
  static const Color ink = Color(0xFF3D3030);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 22,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFFFD5CE),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Emoji only; no background or square icon.
              SizedBox(
                width: 32,
                child: Text(
                  emoji,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: coral,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
