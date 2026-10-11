
import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {
const SalesPage({super.key});

static const Color coral = Color(0xFFF7636B);
static const Color cream = Color(0xFFFFF8F3);
static const Color ink = Color(0xFF3D3030);
static const Color borderColor = Color(0xFFF3E2DC);
static const Color barPink = Color(0xFFF89598);

final List<double> sales = const [
75, 68, 52, 70, 35, 57, 63,
];

final List<String> weekdays = const [
'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
];

final List<String> fullDays = const [
'Monday',
'Tuesday',
'Wednesday',
'Thursday',
'Friday',
'Saturday',
'Sunday',
];

final List<String> dailyEarnings = const [
'₹1,200',
'₹1,800',
'₹950',
'₹2,400',
'₹1,100',
'₹2,750',
'₹2,100',
];

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: cream,
appBar: AppBar(
backgroundColor: cream,
foregroundColor: ink,
elevation: 0,
titleSpacing: 0,
title: const Text(
'Sales Overview',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
),
),
),

// No bottom navigation bar on this page.
body: SafeArea(
child: Center(
child: ConstrainedBox(
constraints: const BoxConstraints(maxWidth: 700),
child: ListView(
physics: const AlwaysScrollableScrollPhysics(),
padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
children: [
_buildRevenueCard(),
const SizedBox(height: 18),

const Text(
'Weekly Sales',
style: TextStyle(
color: ink,
fontSize: 16,
fontWeight: FontWeight.w700,
),
),
const SizedBox(height: 10),

_buildSalesChart(),
const SizedBox(height: 20),

const Text(
'Daily Breakdown',
style: TextStyle(
color: ink,
fontSize: 16,
fontWeight: FontWeight.w700,
),
),
const SizedBox(height: 10),

...List.generate(
fullDays.length,
(index) => _buildDailyRow(
fullDays[index],
dailyEarnings[index],
),
),
],
),
),
),
),
);
}

Widget _buildRevenueCard() {
return Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: coral,
borderRadius: BorderRadius.circular(16),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Total Weekly Revenue',
style: TextStyle(
color: Colors.white,
fontSize: 11,
),
),
SizedBox(height: 6),
Text(
'₹14,400',
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 4),
Text(
'Your sales from Monday to Sunday',
style: TextStyle(
color: Colors.white,
fontSize: 10,
),
),
],
),
);
}

Widget _buildSalesChart() {
return Container(
height: 168,
padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(15),
border: Border.all(color: borderColor),
),
child: Container(
padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
decoration: BoxDecoration(
color: const Color(0xFFFCE7E3),
borderRadius: BorderRadius.circular(10),
),
child: Column(
children: [
Expanded(
child: Row(
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
fontSize: 7,
color: ink,
),
),
),
),
),
const SizedBox(width: 6),
Expanded(
child: CustomPaint(
painter: _SalesChartPainter(
values: sales,
barColor: barPink,
gridColor: const Color(0xFFE8D4D0),
axisColor: ink,
),
child: const SizedBox.expand(),
),
),
],
),
),
const SizedBox(height: 6),
Row(
children: [
const SizedBox(width: 30),
...weekdays.map(
(day) => Expanded(
child: Text(
day,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 8,
color: ink,
),
),
),
),
],
),
],
),
),
);
}

Widget _buildDailyRow(String day, String earnings) {
return Container(
margin: const EdgeInsets.only(bottom: 8),
padding: const EdgeInsets.symmetric(
horizontal: 13,
vertical: 13,
),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: borderColor),
),
child: Row(
children: [
Expanded(
child: Text(
day,
style: const TextStyle(
color: ink,
fontSize: 12,
fontWeight: FontWeight.w500,
),
),
),
Text(
earnings,
style: const TextStyle(
color: coral,
fontSize: 11,
fontWeight: FontWeight.w600,
),
),
],
),
);
}
}

class _SalesChartPainter extends CustomPainter {
final List<double> values;
final Color barColor;
final Color gridColor;
final Color axisColor;

const _SalesChartPainter({
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

final axisPaint = Paint()
..color = axisColor
..strokeWidth = 0.8;

final barPaint = Paint()
..color = barColor
..style = PaintingStyle.fill;

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
final barWidth = slotWidth * 0.52;

for (int i = 0; i < values.length; i++) {
final value = values[i].clamp(0.0, maxValue);
final barHeight = (value / maxValue) * size.height;
final left = i * slotWidth + (slotWidth - barWidth) / 2;
final top = size.height - barHeight;

canvas.drawRect(
Rect.fromLTWH(
left,
top,
barWidth,
barHeight,
),
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
bool shouldRepaint(covariant _SalesChartPainter oldDelegate) {
return oldDelegate.values != values ||
oldDelegate.barColor != barColor ||
oldDelegate.gridColor != gridColor ||
oldDelegate.axisColor != axisColor;
}
}

