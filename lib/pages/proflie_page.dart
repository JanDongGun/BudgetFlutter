import 'package:budgetapp/pages/change_password_page.dart';
import 'package:budgetapp/pages/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = {};

  Future<void> getUser() async {
    var res = await http.get(
        Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/users/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });

    var data = jsonDecode(res.body)['data'];

    setState(() {
      user = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: getUser,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: white.withOpacity(1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 25, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Proflie",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: black.withOpacity(1)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.5),
                      offset: const Offset(0, 10),
                      blurRadius: 5.0,
                      spreadRadius: 0)
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularPercentIndicator(
                          percent: 0.5,
                          progressColor: primary,
                          radius: 120,
                          center: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: grey, width: 0.5),
                                image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/images/keytar_sweenet.png'))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: grey.withOpacity(1), fontSize: 12),
                            ),
                            Text(
                              user['name'],
                              style: TextStyle(
                                  color: black.withOpacity(1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: grey.withOpacity(1), fontSize: 12),
                            ),
                            Text(
                              user['email'],
                              style: TextStyle(
                                  color: black.withOpacity(1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
                            child: Container(
                                height: size.height / 20,
                                width: size.width / 2 - 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Day of birth',
                                      style: TextStyle(
                                          color: grey.withOpacity(1),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      user['dayOfBirth'].split('T')[0],
                                      style: TextStyle(
                                          color: black.withOpacity(1),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
                            child: Container(
                                height: size.height / 20,
                                width: size.width / 2 - 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                          color: grey.withOpacity(1),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      user['phone'],
                                      style: TextStyle(
                                          color: black.withOpacity(1),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const ChangePassword()));
                                  },
                                  child: Text(
                                    "Change password",
                                    style:
                                        TextStyle(color: white.withOpacity(1)),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const UpdateProfile()));
                                  },
                                  child: Text(
                                    "Update profile",
                                    style:
                                        TextStyle(color: white.withOpacity(1)),
                                  ))),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset('assets/images/retro_ocupy.png'),
          const Text(
            'Welcome to Budget Tracker',
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: primary),
          ),
        ],
      ),
    );
  }
}
