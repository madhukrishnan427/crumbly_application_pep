import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  final List<Map<String, dynamic>> orders = [
    {
      'id': 'CB1001',
      'customer': 'Ananya Sharma',
      'product': 'Chocolate Cake',
      'amount': 650.0,
      'status': 'New',
    },
    {
      'id': 'CB1002',
      'customer': 'Priya Kumar',
      'product': 'Red Velvet Cake',
      'amount': 550.0,
      'status': 'In Progress',
    },
    {
      'id': 'CB1003',
      'customer': 'Rahul Kumar',
      'product': 'Cupcakes',
      'amount': 360.0,
      'status': 'Completed',
    },
    {
      'id': 'CB1004',
      'customer': 'Meera Ravi',
      'product': 'Brownies',
      'amount': 280.0,
      'status': 'New',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'New':
        return const Color(0xFFE99B44);
      case 'In Progress':
        return const Color(0xFF648AC7);
      case 'Completed':
        return const Color(0xFF5B9B78);
      case 'Cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Future<void> _changeStatus(Map<String, dynamic> order) async {
    const statuses = [
      'New',
      'In Progress',
      'Completed',
      'Cancelled',
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text('Order ${order['id']}'),
        children: statuses.map((status) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, status),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: _statusColor(status),
                ),
                const SizedBox(width: 10),
                Text(status),
                const Spacer(),
                if (order['status'] == status)
                  const Icon(Icons.check, size: 18),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      setState(() {
        order['status'] = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: cream,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Review orders and update their status.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _CountChip(
                    label: 'New',
                    count: orders.where((o) => o['status'] == 'New').length,
                    color: _statusColor('New'),
                  ),
                  _CountChip(
                    label: 'In Progress',
                    count: orders
                        .where((o) => o['status'] == 'In Progress')
                        .length,
                    color: _statusColor('In Progress'),
                  ),
                  _CountChip(
                    label: 'Completed',
                    count: orders
                        .where((o) => o['status'] == 'Completed')
                        .length,
                    color: _statusColor('Completed'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...orders.map((order) {
                final status = order['status'] as String;
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: Color(0xFFF3E4DE)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Order ${order['id']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _statusColor(status).withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: _statusColor(status),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          order['customer'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          order['product'] as String,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '₹${(order['amount'] as num).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: coral,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () => _changeStatus(order),
                              child: const Text('Update Status'),
                            ),
                          ],
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

class _CountChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CountChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(Icons.circle, size: 10, color: color),
      label: Text('$label: $count'),
      backgroundColor: Colors.white,
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
  }
}