

import 'package:expensetracker/expense_tracker/model/transaction_model.dart';
import 'package:expensetracker/expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key, required this.earnings});

  final List<TransactionModel> earnings;

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return widget.earnings.isEmpty
        ? const Center(
      child: Text(
        'No earnings yet...',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
        : ListView.builder(
      itemCount: widget.earnings.length,
      itemBuilder: (context, index) {
        final earnings = widget.earnings[index];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: transactionTile(
            type: earnings.type,
            title: earnings.title,
            amount: earnings.amount,
            date: earnings.date,
          ),
        );
      },
    );
  }
}

