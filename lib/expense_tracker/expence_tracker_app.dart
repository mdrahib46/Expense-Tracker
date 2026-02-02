import 'package:expensetracker/expense_tracker/screens/login_screen.dart';
import 'package:expensetracker/expense_tracker/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'model/firebase_transection_service.dart';
import 'model/transaction_model.dart';
import 'screens/home_screen.dart';
import 'screens/earnings.dart';
import 'screens/expences.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final _service = TransactionFirebaseService();

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        AppUtils.showCustomSnackBar(
          context: context,
          message: 'Account logged out...!',
          isSuccess: true
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        AppUtils.showCustomSnackBar(context: context, message: "Logout Failed: $e", isSuccess: false);
      }
    }
  }

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
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: _logout,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Earnings'),
              Tab(text: 'Expenses'),
            ],
          ),
        ),

        body: StreamBuilder<List<TransactionModel>>(
          stream: _service.getTransactions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No transactions yet"));
            }

            final transactions = snapshot.data!;
            final earnings = transactions
                .where((t) => t.type == TransactionType.earning)
                .toList();
            final expenses = transactions
                .where((t) => t.type == TransactionType.expense)
                .toList();

            return TabBarView(
              children: [
                HomeScreen(transactions: transactions),
                EarningScreen(earnings: earnings),
                ExpenseScreen(expenses: expenses),
              ],
            );
          },
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
                onPressed: () =>
                    _showTransactionDialog(TransactionType.earning),
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
                onPressed: () =>
                    _showTransactionDialog(TransactionType.expense),
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
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final title = _titleController.text.trim();
                  final amount = double.tryParse(_amountController.text.trim());

                  if (title.isEmpty || amount == null || amount <= 0) {
                    AppUtils.showCustomSnackBar(
                      context: context,
                      message: 'Invalid input..!',
                      isSuccess: false,
                    );

                    return;
                  }

                  try {
                    await _service.addTransaction(
                      title: title,
                      amount: amount,
                      type: type,
                    );

                    if (mounted) {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // close bottom sheet

                      AppUtils.showCustomSnackBar(
                        context: context,
                        message: type == TransactionType.earning
                            ? "New earnings has been added....!"
                            : 'New expenses has been added....!',
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      AppUtils.showCustomSnackBar(
                        context: context,
                        message: "$e",
                        isSuccess: false,
                      );
                    }
                  }
                },
                child: const Text('Save'),
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
