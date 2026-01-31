
import 'package:expensetracker/expense_tracker/model/transaction_model.dart';
import 'package:expensetracker/expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required this.expenses});

  final List<TransactionModel> expenses;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return widget.expenses.isEmpty
        ? const Center(
      child: Text(
        'No expenses yet...',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
        : ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (context, index) {
        final expenses = widget.expenses[index];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: transactionTile(
            type: expenses.type,
            title: expenses.title,
            amount: expenses.amount,
            date: expenses.date,
          ),
        );
      },
    );
  }
}
