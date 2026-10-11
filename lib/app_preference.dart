
import 'package:flutter/material.dart';

class AppPreferencePage extends StatefulWidget {
  const AppPreferencePage({super.key});

  @override
  State<AppPreferencePage> createState() => _AppPreferencePageState();
}

class _AppPreferencePageState extends State<AppPreferencePage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);

  bool orderUpdates = true;
  bool promotionalUpdates = false;
  bool soundEnabled = true;

  String selectedLanguage = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
        title: const Text(
          'App Preferences',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _sectionTitle('Appearance'),
              _preferenceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Theme',
                      style: TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedTheme,
                      decoration: _inputDecoration(),
                      items: const [
                        DropdownMenuItem(
                          value: 'Light',
                          child: Text('Light'),
                        ),
                        DropdownMenuItem(
                          value: 'Dark',
                          child: Text('Dark'),
                        ),
                        DropdownMenuItem(
                          value: 'System',
                          child: Text('System default'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedTheme = value);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Demo setting: changing this selection does not yet change the app theme.',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _sectionTitle('Language'),
              _preferenceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Language',
                      style: TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedLanguage,
                      decoration: _inputDecoration(),
                      items: const [
                        DropdownMenuItem(
                          value: 'English',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'Tamil',
                          child: Text('தமிழ் (Tamil)'),
                        ),
                        DropdownMenuItem(
                          value: 'Hindi',
                          child: Text('हिन्दी (Hindi)'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedLanguage = value);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Demo setting: the selected language is not yet applied throughout the app.',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _sectionTitle('Notifications'),
              _preferenceCard(
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeTrackColor: coral,
                      title: const Text(
                        'Order updates',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text(
                        'Receive updates about new and existing orders.',
                      ),
                      value: orderUpdates,
                      onChanged: (value) {
                        setState(() => orderUpdates = value);
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeTrackColor: coral,
                      title: const Text(
                        'Offers and announcements',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text(
                        'Receive promotional messages and app news.',
                      ),
                      value: promotionalUpdates,
                      onChanged: (value) {
                        setState(() => promotionalUpdates = value);
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeTrackColor: coral,
                      title: const Text(
                        'Sound',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text(
                        'Enable notification sounds where supported.',
                      ),
                      value: soundEnabled,
                      onChanged: (value) {
                        setState(() => soundEnabled = value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: coral,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Preferences saved for this session.',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Save Preferences',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  'Crumbly • Made with love',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: ink,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _preferenceCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1E5DF)),
      ),
      child: child,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: cream,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}