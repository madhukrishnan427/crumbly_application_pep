
import 'package:flutter/material.dart';

class DateAllocationPage extends StatefulWidget {
  const DateAllocationPage({super.key});

  @override
  State<DateAllocationPage> createState() => _DateAllocationPageState();
}

class _DateAllocationPageState extends State<DateAllocationPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);
  static const Color borderColor = Color(0xFFF3E4DE);

  DateTime displayedMonth = DateTime.now();
  DateTime? selectedDate;

  // Each date is managed independently.
  final Set<DateTime> unavailableDates = {};

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isUnavailable(DateTime date) {
    return unavailableDates.contains(_dateOnly(date));
  }

  void _changeMonth(int offset) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + offset,
      );
    });
  }

  // Selecting a date does not change its availability.
  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = _dateOnly(date);
    });
  }

  // Changes only the selected date's availability.
  void _toggleAvailability(DateTime date) {
    final normalized = _dateOnly(date);

    setState(() {
      selectedDate = normalized;

      if (unavailableDates.contains(normalized)) {
        unavailableDates.remove(normalized);
      } else {
        unavailableDates.add(normalized);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
    );

    final daysInMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month + 1,
      0,
    ).day;

    // Monday is the first column.
    final leadingSpaces = firstDay.weekday - 1;
    final totalCells = ((leadingSpaces + daysInMonth + 6) ~/ 7) * 7;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Date Allocation'),
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Manage your availability',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select a date, then change it to available or unavailable.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),

                // Calendar
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Previous month',
                            onPressed: () => _changeMonth(-1),
                            icon: const Icon(Icons.chevron_left),
                          ),
                          Expanded(
                            child: Text(
                              '${_monthName(displayedMonth.month)} '
                                  '${displayedMonth.year}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ink,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Next month',
                            onPressed: () => _changeMonth(1),
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      const Row(
                        children: [
                          _WeekdayLabel('Mon'),
                          _WeekdayLabel('Tue'),
                          _WeekdayLabel('Wed'),
                          _WeekdayLabel('Thu'),
                          _WeekdayLabel('Fri'),
                          _WeekdayLabel('Sat'),
                          _WeekdayLabel('Sun'),
                        ],
                      ),

                      const SizedBox(height: 10),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalCells,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final day = index - leadingSpaces + 1;

                          if (day < 1 || day > daysInMonth) {
                            return const SizedBox.shrink();
                          }

                          final date = DateTime(
                            displayedMonth.year,
                            displayedMonth.month,
                            day,
                          );

                          final unavailable = _isUnavailable(date);
                          final selected = selectedDate != null &&
                              _dateOnly(selectedDate!) == _dateOnly(date);

                          Color backgroundColor;
                          Color textColor;
                          Color outlineColor;

                          if (unavailable) {
                            backgroundColor = coral;
                            textColor = Colors.white;
                            outlineColor = coral;
                          } else if (selected) {
                            backgroundColor = const Color(0xFFFFE4DA);
                            textColor = ink;
                            outlineColor = coral;
                          } else {
                            backgroundColor = Colors.white;
                            textColor = ink;
                            outlineColor = borderColor;
                          }

                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => _selectDate(date),
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: outlineColor,
                                  width: selected ? 1.5 : 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$day',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Calendar legend
                const Wrap(
                  spacing: 18,
                  runSpacing: 10,
                  children: [
                    _LegendItem(
                      color: coral,
                      label: 'Unavailable',
                    ),
                    _LegendItem(
                      color: Color(0xFFFFE4DA),
                      label: 'Selected / available',
                      hasBorder: true,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Selected date information and action
                if (selectedDate != null)
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.event_available_outlined,
                            color: coral,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${selectedDate!.day} '
                                      '${_monthName(selectedDate!.month)} '
                                      '${selectedDate!.year}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ink,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isUnavailable(selectedDate!)
                                      ? 'This date is marked unavailable.'
                                      : 'This date is available.',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                              _toggleAvailability(selectedDate!);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: coral,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              _isUnavailable(selectedDate!)
                                  ? 'Make available'
                                  : 'Block date',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderColor),
                    ),
                    child: const Text(
                      'Select a date from the calendar to manage its availability.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                Text(
                  '${unavailableDates.length} unavailable date(s) selected',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool hasBorder;

  const _LegendItem({
    required this.color,
    required this.label,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: hasBorder
                ? Border.all(color: const Color(0xFFF0CFC5))
                : null,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF3D3030),
          ),
        ),
      ],
    );
  }
}