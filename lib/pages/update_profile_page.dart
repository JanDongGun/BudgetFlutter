import 'dart:io';

import 'package:budgetapp/model/profile_service.dart';
import 'package:budgetapp/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? imageFile;
  String? imageFilePath;
  DateTime dateTime = DateTime(2000);
  DateTime? newDate;
  String formatDate = '2021-01-01T00:00:00.000Z';
  final newName = TextEditingController();
  final newPhone = TextEditingController();

  final _profileService = ProfileService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: getBody());
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
                      "Update Profile",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    const SizedBox(
                      width: 190,
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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New Name',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    TextField(
                      controller: newName,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter the new name',
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
                      'New Phone',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    TextField(
                      controller: newPhone,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter the new phone',
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
                      'Date of birth',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: () async {
                              newDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2022));
                              if (newDate != null) {
                                setState(() {
                                  dateTime = newDate!;
                                  formatDate =
                                      newDate.toString().split(' ')[0] +
                                          'T' +
                                          newDate.toString().split(' ')[1] +
                                          'Z';
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                            color: white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                          style: TextStyle(
                              fontSize: 15, color: grey.withOpacity(1)),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                                onPressed: () async {
                                  await _profileService
                                      .updateProfile(newName.text,
                                          newPhone.text, formatDate)
                                      .then((value) => Navigator.pop(context));
                                  // print(formatDate);
                                  // print(newName.text);
                                  // print(newPhone.text);
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: white.withOpacity(1)),
                                )))
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

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
        imageFilePath = file.path;
      });
    }
  }
}
