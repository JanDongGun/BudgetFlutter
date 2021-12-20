import 'dart:io';

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
  DateTime dateTime = DateTime(2022);

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
              const Text(
                'Choose Image',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularPercentIndicator(
                    percent: 0.5,
                    progressColor: primary,
                    radius: 120,
                    center: imageFile != null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: grey, width: 0.5),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(imageFile!))),
                          )
                        : Container(
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
                  const SizedBox(width: 10),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: () => getImage(source: ImageSource.gallery),
                      icon: const Icon(Icons.image),
                      color: white,
                    ),
                  ),
                  const Text(
                    'Gallery',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      color: white,
                    ),
                  ),
                  const Text(
                    'Camera',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
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
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2022));
                              if (newDate != null) {
                                setState(() {
                                  dateTime = newDate;
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
                        const Spacer(),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                                onPressed: () {},
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
      });
    }
  }
}
