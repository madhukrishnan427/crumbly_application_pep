import 'package:flutter/material.dart';

class BusinessDetailsPage extends StatefulWidget {
  const BusinessDetailsPage({super.key});

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  final _formKey = GlobalKey<FormState>();

  final _businessController =
  TextEditingController(text: 'Sweet Bites');
  final _usernameController =
  TextEditingController(text: '@Sweet Bites');
  final _locationController =
  TextEditingController(text: 'Chennai');
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _businessController.dispose();
    _usernameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveDetails() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Business details saved for this demo session.'),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: coral),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Business Details'),
        backgroundColor: cream,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(22),
              children: [
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE4DA),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: coral,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your Bakery Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                  label: 'Business Name',
                  controller: _businessController,
                  icon: Icons.store_outlined,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter your business name'
                      : null,
                ),
                _buildField(
                  label: 'Username',
                  controller: _usernameController,
                  icon: Icons.alternate_email,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter a username'
                      : null,
                ),
                _buildField(
                  label: 'Location',
                  controller: _locationController,
                  icon: Icons.location_on_outlined,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter your location'
                      : null,
                ),
                _buildField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _buildField(
                  label: 'Email Address',
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        (!value.contains('@') || !value.contains('.'))) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saveDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: coral,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Save Details'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}