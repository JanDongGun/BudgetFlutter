import 'package:budgetapp/json/day_month.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'create_budget_page.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  int activeDay = 4;
  // int amount = 6000;
  // int currentAmount = 3000;
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
                    Text(
                      "Budget",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    SizedBox(
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
                        child: Icon(Icons.add)),
                    Icon(AntIcons.searchOutlined)
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(days.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeDay = index;
                        });
                      },
                      child: Container(
                        width: (size.width - 40) / 7,
                        child: Column(
                          children: [
                            Text(
                              days[index]['label'],
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: activeDay == index
                                      ? primary
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: activeDay == index
                                          ? primary
                                          : black.withOpacity(0.1))),
                              child: Center(
                                child: Text(
                                  days[index]['day'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: activeDay == index ? white : black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        budgetContainer("Budget 1", 2500, 3000),
        budgetContainer("Budget 2", 1200, 2500),
        budgetContainer("Budget 3", 700, 2300),
      ],
    ));
  }

  Widget budgetContainer(String budgetName, int currentAmount, int amount) {
    var size = MediaQuery.of(context).size;
    var percentAmount = (currentAmount / amount) * 100;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              budgetName,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$" + currentAmount.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  percentAmount.toStringAsFixed(0) + "%",
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  "\$" + amount.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            LinearPercentIndicator(
              percent: percentAmount / 100,
              progressColor: blue,
            )
          ],
        ),
        width: (size.width - 40),
        height: (size.height) / 7,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: grey.withOpacity(0.05), spreadRadius: 3, blurRadius: 3),
          ],
        ),
      ),
    );
  }
}
