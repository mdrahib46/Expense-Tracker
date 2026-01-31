
import 'package:expensetracker/expense_tracker/model/transaction_model.dart';
import 'package:expensetracker/expense_tracker/widgets/amount_card_widget.dart';
import 'package:expensetracker/expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.transactions});

  List<TransactionModel> transactions;



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double get totalEarnings{
    double sum = 0;
    for(var t in widget.transactions){
      if(t.type == TransactionType.earning){
        sum += t.amount;
      }
    }
    return sum;
  }


  double get totalExpenses{
    double sum = 0;
    for(var t in widget.transactions){
      if(t.type == TransactionType.expense){
        sum += t.amount;
      }
    }
    return sum;
  }


  double get balance {
    return totalEarnings - totalExpenses;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AmountCard(
                    amount: '$totalEarnings',
                    title: 'Earning',
                    isEarning: true,
                  ),
                ),

                Expanded(
                  child: AmountCard(
                    amount: '$totalExpenses',
                    title: 'Expenses',
                    isExpense: true,
                  ),
                ),
                Expanded(
                  child: AmountCard(
                    amount: '$balance',
                    title: 'Balance',
                    isBalance: true,
                  ),
                ),
              ],
            ),

            Expanded(
              child: widget.transactions.isEmpty
                  ? const Center(
                child: Text(
                  'No transactions yet...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: widget.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = widget.transactions[index];

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: transactionTile(
                      type: transaction.type,
                      title: transaction.title,
                      amount: transaction.amount,
                      date: transaction.date,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
