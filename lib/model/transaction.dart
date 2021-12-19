import 'package:budgetapp/pages/budget_page.dart';

class Transaction {
  String? id;
  String? notes;
  String? amount;
  String? time;
  String? category;
  String? bugetID;

  Transaction(
      {this.id,
      this.notes,
      this.amount,
      this.time,
      this.category,
      this.bugetID});
}
