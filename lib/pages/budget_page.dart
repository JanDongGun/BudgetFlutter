import 'package:budgetapp/model/budget_service.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'create_budget_page.dart';
import '../json/day_month.dart';
import '../json/budget_json.dart';
import 'package:budgetapp/pages/budget_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List budgetList = [];
  int activeMonth = 1;

  String _budgetName = "";
  int _budgetMoney = 0;
  String id = "";

  final _budgetService = BudetService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(color: white, boxShadow: [
            BoxShadow(
                color: grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)
          ]),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Budget",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateBudget()),
                          );
                        },
                        child: const Icon(Icons.add)),
                    const Icon(AntIcons.searchOutlined)
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(months.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeMonth = index;
                        });
                      },
                      child: Container(
                        width: (size.width - 40) / 7,
                        child: Column(
                          children: [
                            Text(
                              months[index]['label'],
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: activeMonth == index
                                      ? primary
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: activeMonth == index
                                          ? primary
                                          : black.withOpacity(0.1))),
                              child: Center(
                                child: Text(
                                  months[index]['month'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: activeMonth == index ? white : black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<dynamic>(
          future: _budgetService.getAllBudget(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: List.generate(snapshot.data.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        id = snapshot.data[index]['_id'];
                      });
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Update budget"),
                                actions: [
                                  FlatButton(
                                      onPressed: () async {
                                        await _budgetService
                                            .updateBudget(id, _budgetName,
                                                _budgetMoney.toString())
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: Text("Update"))
                                ],
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextField(
                                        //controller: _budgetNameController,
                                        controller: TextEditingController()
                                          ..text = snapshot.data[index]['name'],
                                        onChanged: (text) => {
                                          if (text != "")
                                            {
                                              setState(() {
                                                _budgetName = text;
                                              })
                                            }
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Enter budget name',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        //controller: _budgetNameController,
                                        controller: TextEditingController()
                                          ..text = snapshot.data[index]
                                                  ['amount']
                                              .toString(),
                                        onChanged: (text) => {
                                          if (text != "")
                                            {
                                              setState(() {
                                                _budgetMoney = int.parse(text);
                                              })
                                            }
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Enter budget name',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                    onLongPress: () async {
                      await _budgetService
                          .removeBudget(snapshot.data[index]['_id']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data[index]['name'],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data[index]['amount'].toString(),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(
                                      color: Colors.red[100], fontSize: 12),
                                ),
                                const Spacer(),
                                Text(snapshot.data[index]['amount'].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearPercentIndicator(
                              percent: 0.8,
                              progressColor: Colors.red[100],
                            )
                          ],
                        ),
                        width: (size.width - 40),
                        height: (size.height) / 8,
                        padding: const EdgeInsets.all(15.0),
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
                      ),
                    ),
                  );
                }),
              );
            }
            return Container();
          },
        ),
      ],
    ));
  }
}
