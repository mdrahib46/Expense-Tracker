
import 'package:expensetracker/expense_tracker/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget transactionTile({
  required TransactionType type,
  required String title,
  required double amount,
  required DateTime date,
}) {
  final bool isExpense = type == TransactionType.expense;

  return ListTile(
    leading: Icon(
      Icons.currency_exchange,
      color: isExpense ? Colors.red : Colors.green,
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(amount.toStringAsFixed(2)),
        const SizedBox(height: 4),
        Text(
          DateFormat('dd-MM-yyyy').format(date),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    ),
    trailing: Icon(
      isExpense
          ? Icons.trending_down_rounded
          : Icons.trending_up_rounded,
      color: isExpense ? Colors.red : Colors.green,
    ),
  );
}