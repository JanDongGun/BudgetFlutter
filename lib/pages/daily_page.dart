import 'package:budgetapp/json/daily_json.dart';
import 'package:budgetapp/json/day_month.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import '../model/tracsaction_service.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int activeDay = 4;
  String id = "";
  String notes = "";
  String amount = "";

  final _transaction = TransactionService();

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
                  children: const [
                    Text(
                      "Daily Transaction",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
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
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FutureBuilder<dynamic>(
              future: _transaction.getAllTranSaction(),
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
                                    title: Text("Update Transaction"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () async {
                                            await _transaction
                                                .updateTransaction(
                                                    id,
                                                    notes,
                                                    amount,
                                                    snapshot.data[index]
                                                        ['budget'])
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
                                              ..text =
                                                  snapshot.data[index]['notes'],
                                            onChanged: (text) => {
                                              if (text != "")
                                                {
                                                  setState(() {
                                                    notes = text;
                                                  })
                                                }
                                            },
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                              hintText: 'Enter budget name',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                                                    amount = text;
                                                  })
                                                }
                                            },
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                              hintText: 'Enter budget name',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                          await _transaction
                              .removeTransaction(snapshot.data[index]['_id']);
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (size.width - 40) * 0.7,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: grey.withOpacity(0.1),
                                            shape: BoxShape.circle),
                                      ),
                                      const SizedBox(width: 15),
                                      Container(
                                        width: (size.width - 90) * 0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index]['notes'],
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                dateFormat.format(
                                                    DateTime.parse(
                                                            snapshot.data[index]
                                                                ['time'])
                                                        .toUtc()),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        black.withOpacity(0.5),
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: (size.width - 40) * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data[index]['amount']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: green),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 65, top: 8),
                              child: Divider(
                                thickness: 0.8,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  );
                }
                return Container();
              }),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text(
                  "Total",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: black.withOpacity(0.4)),
                ),
              ),
              const Spacer(),
              const Text(
                "\$1780.00",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: black),
              )
            ],
          ),
        )
      ],
    ));
  }
}
