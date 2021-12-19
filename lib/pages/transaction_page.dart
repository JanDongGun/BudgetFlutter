import 'package:budgetapp/model/tracsaction_service.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:budgetapp/json/budget_json.dart';
import 'package:budgetapp/model/budget_service.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  final String type;
  const Transaction({required this.type, Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final _budgetService = BudetService();
  final _transaction = TransactionService();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFor = DateFormat("yyyy-MM-dd");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  var _budgetName = "";
  var _budgetID = "";
  int _amount = 0;
  var _notes = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: white, boxShadow: [
            BoxShadow(
                color: grey.withOpacity(0.05), spreadRadius: 5, blurRadius: 3)
          ]),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.clear)),
                    const Text(
                      "Add Transaction",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Row(
                children: [
                  widget.type == 'Income'
                      ? Container(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                            heroTag: 'type_income',
                            onPressed: () {},
                            child: Icon(Icons.first_page),
                            backgroundColor: blue,
                            foregroundColor: white,
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                            heroTag: 'type_expense',
                            onPressed: () {},
                            child: Icon(Icons.last_page),
                            backgroundColor: red,
                            foregroundColor: white,
                          ),
                        ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction type',
                        style: TextStyle(
                            fontSize: 12,
                            color: grey.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.type,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: black.withOpacity(1)),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      _notes = text;
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    hintText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.5)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: grey.withOpacity(0.5)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: grey.withOpacity(0.05),
                            spreadRadius: 3,
                            blurRadius: 3),
                      ],
                    ),
                    child: Container(
                      child: FloatingActionButton(
                        heroTag: 'trans_budget',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder<dynamic>(
                                    future: _budgetService.getAllBudget(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 100),
                                          child: Column(
                                            children: List.generate(
                                                snapshot.data.length, (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _budgetID = snapshot
                                                        .data[index]['_id'];
                                                    _budgetName = snapshot
                                                        .data[index]['name'];
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                onLongPress: () async {
                                                  await _budgetService
                                                      .removeBudget(snapshot
                                                          .data[index]['_id']);
                                                },
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index]
                                                            ['name'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  width: (size.width - 40),
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }),
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              });
                        },
                        child: Icon(Icons.account_balance_wallet),
                        backgroundColor: green,
                        foregroundColor: white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budget',
                        style: TextStyle(
                            fontSize: 12,
                            color: grey.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _budgetName,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: black.withOpacity(1)),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 100,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          _amount = int.parse(text);
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        hintText: '\$' 'Amount',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      heroTag: 'trans_date',
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today),
                      backgroundColor: secondary,
                      foregroundColor: white,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                            fontSize: 12,
                            color: grey.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dateFor.format(selectedDate),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: black.withOpacity(1)),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                          onPressed: () async {
                            await _transaction.addTransaction(
                                _notes,
                                _amount.toString(),
                                widget.type.toLowerCase(),
                                _budgetID,
                                dateFor.format(selectedDate));
                          },
                          child: Text(
                            "Finish",
                            style: TextStyle(color: white.withOpacity(1)),
                          )))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
