import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'transaction_model.dart';

class TransactionFirebaseService {
  final CollectionReference _transactionCollection =
  FirebaseFirestore.instance.collection('transactions');

  /// Add transaction
  Future<void> addTransaction({
    required String title,
    required double amount,
    required TransactionType type,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _transactionCollection.add({
      'title': title,
      'amount': amount,
      'type': type == TransactionType.earning ? 'earning' : 'expense',
      'date': DateTime.now(),
      'userId': user.uid,
    });
  }

  /// Get transactions stream for current user (no orderBy)
  Stream<List<TransactionModel>> getTransactions() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return _transactionCollection
        .where('userId', isEqualTo: user.uid) // ✅ only filter by user
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return TransactionModel(
        title: data['title'] ?? '',
        amount: (data['amount'] as num).toDouble(),
        type: data['type'] == 'earning'
            ? TransactionType.earning
            : TransactionType.expense,
        date: (data['date'] as Timestamp).toDate(),
      );
    }).toList());
  }
}
