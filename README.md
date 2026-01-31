# Expense Tracker App

A simple and user-friendly **Expense Tracker** built with **Flutter**. This app allows users to track their earnings, expenses, and balance in a clean and organized interface.

---

## 📝 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Code Snippets](#-code-snippets)
- [Getting Started](#-getting-started)
- [Usage](#-usage)
- [Folder Structure](#-folder-structure)
- [Technologies](#-technologies)
- [Future Improvements](#-future-improvements)


---

## ✨ Features

- Track **earnings** and **expenses** separately.
- Automatically calculate **balance**.
- **Add new transactions** via modal dialogs.
- Display transactions with **type-based icons**:
  - Green for earnings
  - Red for expenses
- Show **empty state** when no transactions exist.
- Tab-based navigation for **Dashboard, Earnings, and Expenses**.
- Clean and responsive UI.

---

## 📸 Screenshots

### Home Screen
<img width="1547" height="3272" alt="Screenshot_20260131_163024" src="https://github.com/user-attachments/assets/c8c9a4b8-50fb-4ae5-a324-166d69e4c2f8" width="300"/>

### Earnings Tab
<img width="1547" height="3272" alt="Screenshot_20260131_163033" src="https://github.com/user-attachments/assets/6994f0d6-6e50-4d8b-88b7-77ec5429f47e" width="300"/>

### Add Expenses Tab
<img width="1547" height="3272" alt="Screenshot_20260131_194028" src="https://github.com/user-attachments/assets/d832a844-d138-4884-abfc-2fcc25d2bd7f" width="300"/>

### Add Transaction Modal
<img width="1547" height="3272" alt="Screenshot_20260131_193919" src="https://github.com/user-attachments/assets/c40a31d2-a1ca-4d9d-9477-312f389e55b4" width="300"/>


---

## 💻 Code Snippets

### 1️⃣ Transaction Model

```dart
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
```

### 2️⃣ Transaction Tile Widget

```dart
Widget transactionTile({
  required TransactionType type,
  required String title,
  required double amount,
  required DateTime date,
}) {
  final IconData trailingIcon = type == TransactionType.expense
      ? Icons.trending_down_rounded
      : Icons.trending_up_rounded;

  final Color iconColor = type == TransactionType.expense ? Colors.red : Colors.green;

  return ListTile(
    leading: Icon(Icons.currency_exchange, color: iconColor),
    title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(amount.toStringAsFixed(2)),
        Text('Date: ${DateFormat('dd-MM-yyyy').format(date)}', style: TextStyle(fontSize: 12)),
      ],
    ),
    trailing: Icon(trailingIcon, color: iconColor),
  );
}
```

### 3️⃣ Home Screen (Dashboard)

```dart
double get totalEarnings => transactions
    .where((t) => t.type == TransactionType.earning)
    .fold(0, (sum, t) => sum + t.amount);

double get totalExpenses => transactions
    .where((t) => t.type == TransactionType.expense)
    .fold(0, (sum, t) => sum + t.amount);

double get balance => totalEarnings - totalExpenses;
```

### 4️⃣ Earning Screen Example

```dart
class EarningScreen extends StatelessWidget {
  final List<TransactionModel> earnings;

  const EarningScreen({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    if (earnings.isEmpty) {
      return const Center(
        child: Text('No earnings yet...', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: earnings.length,
      itemBuilder: (context, index) {
        final t = earnings[index];
        return transactionTile(
          type: t.type,
          title: t.title,
          amount: t.amount,
          date: t.date,
        );
      },
    );
  }
}
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (comes with Flutter)
- **Android Studio** / **VS Code**

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/expense_tracker.git
   ```

2. Navigate to the project directory:
   ```bash
   cd expense_tracker
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## 🛠 Usage

1. Tap the **Floating Action Button (+)** to add a new transaction.
2. Fill in the **title** and **amount**, then submit.
3. View totals in the **Dashboard**.
4. Switch tabs to see only **Earnings** or **Expenses**.
5. Balance is automatically calculated as:
   ```
   Balance = Total Earnings - Total Expenses
   ```

---

## 📂 Folder Structure

```
lib/
├─ main.dart
├─ screens/
│  ├─ home_screen.dart
│  ├─ earnings.dart
│  ├─ expenses.dart
├─ widgets/
│  ├─ transaction_tile.dart
│  ├─ amount_card_widget.dart
├─ model/
│  └─ transaction_model.dart
```

---

## 🔧 Technologies

- **Flutter** - UI Framework
- **Dart** - Programming Language
- **Intl** - For formatting dates

---

## 💡 Future Improvements

- ✅ Edit/Delete transactions
- ✅ Firebase or local database for persistence
- ✅ Charts/Graphs for visualization
- ✅ Monthly/Yearly filters
- ✅ Category-based expense tracking
- ✅ Export data to CSV/PDF

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**
- LinkedIn: [MD Monirujjaman Nahid](https://www.linkedin.com/in/rahib-in/)
- WhatsApp: [Md Rahib](https://wa.me/message/CYTDI44PRL3WJ1)

---

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Community contributors and supporters

---

**MD Rahib**
