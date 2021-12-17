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
                child: Stack(children: [
                  Positioned(
                      top: 15,
                      left: 50,
                      child: Text(
                        'Net Balance',
                        style:
                            TextStyle(color: grey.withOpacity(1), fontSize: 10),
                      )),
                  Positioned(
                      top: 30,
                      left: 50,
                      child: Text(
                        '\$25648.90',
                        style: TextStyle(
                            color: black.withOpacity(1),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 10,
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            colors: redGradientColors,
                            barWidth: 3,
                            dotData: FlDotData(show: false),
                            spots: const [
                              FlSpot(0, 3),
                              FlSpot(2, 4),
                              FlSpot(3, 6),
                              FlSpot(4, 5),
                              FlSpot(6, 2),
                              FlSpot(7, 3),
                              FlSpot(8, 6),
                              FlSpot(11, 9),
                            ],
                          )
                        ],
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                            rightTitles: SideTitles(showTitles: false),
                            topTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (context, value) =>
                                    const TextStyle(color: grey, fontSize: 12),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'JAN';
                                    case 2:
                                      return 'MAR';
                                    case 4:
                                      return 'MAY';
                                    case 6:
                                      return 'JUL';
                                    case 8:
                                      return 'SEP';
                                    case 10:
                                      return 'NOV';
                                  }
                                  return '';
                                }),
                            leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (context, value) =>
                                    const TextStyle(color: grey, fontSize: 12),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return '0';
                                    case 2:
                                      return '2K';
                                    case 4:
                                      return '4K';
                                    case 6:
                                      return '6K';
                                    case 8:
                                      return '8K';
                                    case 10:
                                      return '10K';
                                  }
                                  return '';
                                })),
                      ),
                    ),
                  ),
                ]),
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
                                  heroTag: 'btn income',
                                  onPressed: () {},
                                  child: const Icon(Icons.first_page),
                                  backgroundColor: blue,
                                  foregroundColor: white,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 10, color: grey.withOpacity(1)),
                              ),
                              Text('\$64215.24',
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
                                  heroTag: 'btn expense',
                                  onPressed: () {},
                                  child: const Icon(Icons.last_page),
                                  backgroundColor: red,
                                  foregroundColor: white,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              Text(
                                'Expense',
                                style: TextStyle(
                                    fontSize: 10, color: grey.withOpacity(1)),
                              ),
                              Text('\$55628.20',
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

class LineTitle {
  getTitileData() => FlTitlesData(
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
          showTitles: true,
          margin: 8,
          getTextStyles: (context, value) => const TextStyle(color: grey),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'JAN';
              case 2:
                return 'MAR';
              case 4:
                return 'MAY';
              case 6:
                return 'JUL';
              case 8:
                return 'SEP';
              case 10:
                return 'NOV';
            }
            return '';
          }));
}
