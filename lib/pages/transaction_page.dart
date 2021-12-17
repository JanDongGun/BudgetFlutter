import 'package:flutter/material.dart';
import 'package:budgetapp/theme/colors.dart';

class Transaction extends StatefulWidget {
  final String type;
  const Transaction({required this.type, Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(
                      width: 180,
                    )
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
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'trans_budget',
                        onPressed: () {},
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
                        'Budget 1',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: black.withOpacity(1)),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 100,
                    child: TextField(
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
                      onPressed: () {},
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
                        'Today',
                        style: TextStyle(
                            fontSize: 19,
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
                          onPressed: () {},
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
