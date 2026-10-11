
import 'package:flutter/material.dart';
import 'date_allocation.dart';
import 'order_details.dart';
import 'sales_page.dart';
import 'settings_page.dart';
import 'menu_management.dart';

class BakerDashboard extends StatefulWidget {
  const BakerDashboard({super.key});

  @override
  State<BakerDashboard> createState() => _BakerDashboardState();
}

class _BakerDashboardState extends State<BakerDashboard> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);
  static const Color borderColor = Color(0xFFF3E2DC);
  static const Color chartBackground = Color(0xFFFCE7E3);
  static const Color barPink = Color(0xFFF89598);

  int selectedIndex = 0;

  final List<double> weeklySales = [
    75, 68, 52, 70, 34, 56, 63,
  ];

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ink,
            size: 22,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        titleSpacing: 0,
        title: Image.asset(
          'assets/images/logo_crumbly.png',
          height: 42,
          width: 125,
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => _navigateTo(const SettingsPage()),
            icon: const Icon(
              Icons.settings_outlined,
              color: ink,
              size: 23,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),

      // The page scrolls independently while the bottom navigation stays fixed.
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildGreeting(),
                        const SizedBox(height: 22),

                        _buildSummaryCard(
                          title: 'Total Orders',
                          value: '24',
                          subtitle: 'This week',
                          icon: Icons.shopping_bag_outlined,
                          iconColor: coral,
                          iconBackground: const Color(0xFFFFE9E8),
                        ),

                        const SizedBox(height: 16),

                        _buildSummaryCard(
                          title: 'Revenue',
                          value: '₹12,450',
                          subtitle: 'This week',
                          icon: Icons.currency_rupee,
                          iconColor: const Color(0xFF459B78),
                          iconBackground: const Color(0xFFEAF5EF),
                        ),

                        const SizedBox(height: 26),

                        _buildSectionHeader(
                          'Weekly Sales',
                          'View sales',
                              () => _navigateTo(const SalesPage()),
                        ),

                        const SizedBox(height: 12),
                        _buildWeeklySalesChart(),

                        const SizedBox(height: 26),

                        _buildSectionHeader(
                          'Order Status',
                          'View orders',
                              () => _navigateTo(const OrderDetailsPage()),
                        ),

                        const SizedBox(height: 12),
                        _buildOrderStatus(),

                        const SizedBox(height: 26),

                        _buildSectionHeader(
                          'Top Products',
                          'View menu',
                              () => _navigateTo(
                            const MenuManagementPage(),
                          ),
                        ),

                        const SizedBox(height: 12),
                        _buildTopProducts(),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning!',
                style: TextStyle(
                  color: ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Here is your bakery overview.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        ClipOval(
          child: Image.asset(
            'assets/images/baker_profile.jpeg',
            width: 54,
            height: 54,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const CircleAvatar(
                radius: 27,
                backgroundColor: Color(0xFFFFE4DA),
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: coral,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title,
      String action,
      VoidCallback onTap,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: coral,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
          child: Text(
            action,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // Sales chart matching the reference:
  // pink background, horizontal gridlines, left-side values,
  // seven pink bars and weekday labels.
  Widget _buildWeeklySalesChart() {
    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun',
    ];

    return Container(
      height: 230,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        color: chartBackground,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 24,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      9,
                          (index) => Text(
                        '${80 - index * 10}',
                        style: const TextStyle(
                          color: ink,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomPaint(
                    painter: _DashboardSalesPainter(
                      values: weeklySales,
                      barColor: barPink,
                      gridColor: const Color(0xFFE7D3CF),
                      axisColor: ink,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 32),
              ...weekdays.map(
                    (day) => Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          _orderStatusRow(
            'Pending',
            '4 orders',
            const Color(0xFFE5A23B),
            0.35,
          ),
          const SizedBox(height: 15),
          _orderStatusRow(
            'In Progress',
            '6 orders',
            const Color(0xFF629BD7),
            0.55,
          ),
          const SizedBox(height: 15),
          _orderStatusRow(
            'Completed',
            '14 orders',
            const Color(0xFF55A77D),
            0.85,
          ),
        ],
      ),
    );
  }

  Widget _orderStatusRow(
      String title,
      String count,
      Color color,
      double progress,
      ) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: const Color(0xFFF4EAE6),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildTopProducts() {
    final products = [
      {
        'name': 'Chocolate Truffle Cake',
        'image': 'assets/images/choco_truffle.jpeg',
      },
      {
        'name': 'Vanilla Strawberry Cake',
        'image': 'assets/images/strawberry_cake.png',
      },
      {
        'name': 'Bento Cake',
        'image': 'assets/images/bento_1.jpeg',
      },
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.map((product) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE7E2),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const ColoredBox(
                          color: Color(0xFFFFF0E8),
                          child: Icon(
                            Icons.cake_outlined,
                            color: coral,
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  product['name']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigation() {
    const labels = ['Home', 'Orders', 'Calendar', 'Settings'];
    const icons = [
      Icons.grid_view_rounded,
      Icons.receipt_long_outlined,
      Icons.calendar_month_outlined,
      Icons.settings_outlined,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: List.generate(labels.length, (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => _onNavTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFE4DA)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          icons[index],
                          color: isSelected ? coral : ink,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        labels[index],
                        style: TextStyle(
                          color: isSelected ? ink : Colors.black87,
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() => selectedIndex = index);

    switch (index) {
      case 0:
        break;
      case 1:
        _navigateTo(const OrderDetailsPage());
        break;
      case 2:
        _navigateTo(const DateAllocationPage());
        break;
      case 3:
        _navigateTo(const SettingsPage());
        break;
    }
  }
}

class _DashboardSalesPainter extends CustomPainter {
  final List<double> values;
  final Color barColor;
  final Color gridColor;
  final Color axisColor;

  const _DashboardSalesPainter({
    required this.values,
    required this.barColor,
    required this.gridColor,
    required this.axisColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const maxValue = 80.0;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.7;

    final barPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 0.8;

    // Horizontal gridlines.
    for (int i = 0; i <= 8; i++) {
      final y = size.height * i / 8;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Seven evenly spaced bars.
    final slotWidth = size.width / values.length;
    final barWidth = slotWidth * 0.48;

    for (int i = 0; i < values.length; i++) {
      final value = values[i].clamp(0.0, maxValue);
      final barHeight = (value / maxValue) * size.height;
      final left = i * slotWidth + (slotWidth - barWidth) / 2;
      final top = size.height - barHeight;

      canvas.drawRect(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        barPaint,
      );
    }

    // Left and bottom axes.
    canvas.drawLine(
      Offset.zero,
      Offset(0, size.height),
      axisPaint,
    );

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DashboardSalesPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.barColor != barColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.axisColor != axisColor;
  }
}