import 'package:budgetapp/json/budget_json.dart';
import 'package:budgetapp/model/transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './budget_service.dart';

class TransactionService {
  late List<Transaction> listTrans;

  final _budgetService = BudetService();

  Future<dynamic> getAllTranSaction() async {
    listTrans = [];
    var res = await http.get(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/transactions/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
    final jsonResponse = json.decode(res.body);
    //Student student = new Student.fromJson(jsonResponse);
    //return jsonResponse['data'];

    jsonResponse['data'].forEach((item) {
      Transaction budget = Transaction(
          id: item['_id'],
          notes: item['notes'],
          amount: item['amount'].toString(),
          time: item['time'],
          category: item['category'],
          bugetID: item['budgetID']);
      listTrans.add(budget);
    });

    return jsonResponse['data'];
  }

  Future<void> addTransaction(
    String notes,
    String amount,
    String transactionType,
    String budgetID,
    String dateTime,
  ) async {
    var res = await http.post(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/transactions/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        },
        body: {
          "notes": notes,
          "transactionType": transactionType.toLowerCase(),
          "amount": amount,
          "budget": budgetID,
          "time": dateTime
        });

    print("add transac ${res}");
  }

  Future<void> removeTransaction(String id) async {
    var res = await http.delete(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/transactions/${id}"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
  }

  Future<void> updateTransaction(
      String id, String notes, String amount, String budget) async {
    var res = await http.patch(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/transactions/${id}"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        },
        body: {
          "notes": notes,
          "amount": amount,
          "budget": budget
        });

    print(res);
  }
}
