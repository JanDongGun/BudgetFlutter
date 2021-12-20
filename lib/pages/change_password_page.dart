import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var repeatPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
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
                        child: const Icon(Icons.arrow_back)),
                    const Text(
                      "Change Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    const SizedBox(
                      width: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/synth_polaroid.png'),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Old Password',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    TextField(
                      controller: oldPassword,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter the old password',
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'New password',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: newPassword,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          hintText: 'Enter the new password',
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
                    const Text(
                      'Repeat  new password',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            controller: repeatPassword,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              hintText: 'Repeat the new password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.navigate_next),
                            color: white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
