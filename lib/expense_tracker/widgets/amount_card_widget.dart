import 'package:flutter/material.dart';

class AmountCard extends StatelessWidget {
  const AmountCard({
    super.key,
    required this.amount,
    required this.title,
    this.isEarning = false,
    this.isExpense = false,
    this.isBalance = false,
  });

  final String amount, title;

  final bool isEarning, isExpense, isBalance;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
      color: isEarning
          ? Color(0xFFc7e9c0)
          : isExpense
          ? Color(0xffffbaba)
          : Color(0xffb2d8d8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isEarning
                    ? Color(0xff006d2c)
                    : isExpense
                    ? Color(0xffa70000)
                    : Color(0xff006666),
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isEarning
                    ? Color(0xff006d2c)
                    : isExpense
                    ? Color(0xffa70000)
                    : Color(0xff006666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}