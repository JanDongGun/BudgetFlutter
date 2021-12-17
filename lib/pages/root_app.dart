import 'package:budgetapp/pages/daily_page.dart';
import 'package:budgetapp/pages/stat_page.dart';
import 'package:budgetapp/pages/add_transaction_page.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'budget_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: FloatingActionButton(
          heroTag: 'btn root',
          onPressed: () {
            setTabs(4);
          },
          child: const Icon(Icons.add, size: 25),
          backgroundColor: primary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        DailyPage(),
        Center(
          child: Stat(),
        ),
        Center(
          child: Budget(),
        ),
        Center(
          child: Text("Profile page"),
        ),
        Center(
          child: AddTransaction(),
        ),
      ],
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.calendar,
      Ionicons.stats_chart,
      Ionicons.wallet,
      Ionicons.person
    ];
    return AnimatedBottomNavigationBar(
        icons: iconItems,
        activeColor: primary,
        inactiveColor: black.withOpacity(0.5),
        activeIndex: pageIndex,
        splashColor: secondary,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
