import 'package:cloud_firestore/cloud_firestore.dart';

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

  /// Convert Firestore document to TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] == 'earning'
          ? TransactionType.earning
          : TransactionType.expense,
      date: map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate()
          : DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Convert TransactionModel to Map for Firestore
  Map<String, dynamic> toMap(String userId) {
    return {
      'title': title,
      'amount': amount,
      'type': type == TransactionType.earning ? 'earning' : 'expense',
      'date': date,
      'userId': userId,
    };
  }
}
