import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
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
                        onTap: () {}, child: const Icon(Icons.clear)),
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
        const SizedBox(
          height: 20,
        ),
        Image.asset('assets/images/credit_card_illustration.png'),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width / 2,
                child: Text('What kind of transaction it is ?',
                    style: TextStyle(
                        fontSize: 20,
                        color: black.withOpacity(0.6),
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: size.width - 40,
                height: size.height / 4.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: (size.width - 100) / 2,
                        height: size.height / 4.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: grey.withOpacity(0.05),
                                spreadRadius: 3,
                                blurRadius: 3),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: FloatingActionButton(
                                  heroTag: 'btn trans_income',
                                  onPressed: () {},
                                  child: const Icon(Icons.first_page),
                                  backgroundColor: blue,
                                  foregroundColor: white,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text('Income',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87.withOpacity(1)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: (size.width - 100) / 2,
                        height: size.height / 4.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: grey.withOpacity(0.05),
                                spreadRadius: 3,
                                blurRadius: 3),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: FloatingActionButton(
                                  heroTag: 'btn trans_expense',
                                  onPressed: () {},
                                  child: const Icon(Icons.last_page),
                                  backgroundColor: red,
                                  foregroundColor: white,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text('Expense',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87.withOpacity(1)))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
