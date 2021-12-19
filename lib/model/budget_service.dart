import 'package:budgetapp/model/budgetmodal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BudetService {
  late List<Budget> listBudget;

  Future<dynamic> getOneBudget(String id) async {
    var res = await http.get(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/budgets/${id}"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
    final jsonResponse = json.decode(res.body);

    print("get one budget ${res}");
    return jsonResponse['data'];
  }

  Future<dynamic> getAllBudget() async {
    listBudget = [];
    var res = await http.get(
        Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/budgets"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
    final jsonResponse = json.decode(res.body);
    //Student student = new Student.fromJson(jsonResponse);
    //return jsonResponse['data'];

    jsonResponse['data'].forEach((item) {
      Budget budget = Budget(
          id: item['_id'],
          name: item['name'],
          amount: item['amount'].toString());
      listBudget.add(budget);
    });

    return jsonResponse['data'];
  }

  Future<void> addBudget(String title, String amount) async {
    var res = await http.post(
        Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/budgets/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        },
        body: {
          "name": title,
          "amount": amount
        });
  }

  Future<void> removeBudget(String id) async {
    var res = await http.delete(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/budgets/${id}"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
  }

  Future<void> updateBudget(String id, String title, String amount) async {
    var res = await http.patch(
        Uri.parse(
            "https://budgettrackerapi.herokuapp.com/api/v1/budgets/${id}"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        },
        body: {
          "name": title,
          "amount": amount,
          "category": "61b618691314ee1432aff835"
        });

    print("update budget ${res}");
  }
}
