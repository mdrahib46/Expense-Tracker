enum TransactionType { earning, expense }

class TransactionModel {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });
}
