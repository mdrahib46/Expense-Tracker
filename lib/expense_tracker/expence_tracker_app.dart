import 'package:expensetracker/expense_tracker/screens/earnings.dart';
import 'package:expensetracker/expense_tracker/screens/expences.dart';
import 'package:expensetracker/expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'model/transaction_model.dart';



class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  /// All transactions (earning + expense)
  final List<TransactionModel> transactions = [];

  /// Helpers
  List<TransactionModel> get earnings =>
      transactions.where((t) => t.type == TransactionType.earning).toList();

  List<TransactionModel> get expenses =>
      transactions.where((t) => t.type == TransactionType.expense).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _openBottomSheet,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          title: Text(
            'Expense Tracker',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Earnings'),
              Tab(text: 'Expenses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(transactions: transactions,),
            EarningScreen(earnings:  earnings,),
            ExpenseScreen(expenses: expenses,),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showTransactionDialog(TransactionType.earning);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFc7e9c0),
                  foregroundColor: const Color(0xff006d2c),
                ),
                child: const Text("Add Earnings"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _showTransactionDialog(TransactionType.expense);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffbaba),
                  foregroundColor: const Color(0xffa70000),
                ),
                child: const Text("Add Expense"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDialog(TransactionType type) {
    _titleController.clear();
    _amountController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          type == TransactionType.earning ? 'Add Earnings' : 'Add Expense',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                prefixIcon: Icon(Icons.account_balance_wallet_rounded),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final amount =
                  double.tryParse(_amountController.text.trim());

                  if (title.isEmpty || amount == null || amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid input')),
                    );
                    return;
                  }

                  setState(() {
                    transactions.add(
                      TransactionModel(
                        title: title,
                        amount: amount,
                        date: DateTime.now(),
                        type: type,
                      ),
                    );
                  });

                  Navigator.pop(context);
                  Navigator.pop(context); // close bottom sheet
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}