import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import '../json/day_month.dart';
import 'package:fl_chart/fl_chart.dart';

class Stat extends StatefulWidget {
  const Stat({Key? key}) : super(key: key);

  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  int activeMonth = 1;
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
                      "Stat",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87.withOpacity(1)),
                    ),
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width - 40,
                height: size.height / 2.8,
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
                  padding: const EdgeInsets.fromLTRB(0, 20, 30, 20),
                  child: LineChart(LineChartData(
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 20,
                    lineBarsData: [
                      LineChartBarData(spots: [
                        FlSpot(0, 3),
                        FlSpot(2, 4),
                        FlSpot(3, 6),
                        FlSpot(4, 9),
                        FlSpot(6, 5),
                        FlSpot(7, 10),
                        FlSpot(8, 15),
                        FlSpot(11, 9),
                      ])
                    ],
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                        rightTitles: SideTitles(showTitles: false),
                        topTitles: SideTitles(showTitles: false)),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
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
                        width: (size.width - 60) / 2,
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
                              FloatingActionButton(
                                onPressed: () {},
                                child: Icon(Icons.first_page),
                                backgroundColor: blue,
                                foregroundColor: white,
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 10, color: grey.withOpacity(1)),
                              ),
                              Text('\$ 654584556',
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
                        width: (size.width - 60) / 2,
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
                              FloatingActionButton(
                                onPressed: () {},
                                child: Icon(Icons.last_page),
                                backgroundColor: red,
                                foregroundColor: white,
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text(
                                'Expense',
                                style: TextStyle(
                                    fontSize: 10, color: grey.withOpacity(1)),
                              ),
                              Text('\$ 59658845',
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
              )
            ],
          ),
        ),
      ],
    ));
  }
}
