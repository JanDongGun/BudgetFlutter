import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:budgetapp/model/profile.dart';

class ProfileService {
  Future<dynamic> getUser() async {
    var res = await http.get(
        Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/users/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        });
    final jsonResponse = json.decode(res.body);

    print("get user  ${res}");
    return jsonResponse['data'];
  }

  Future<dynamic> updateProfile(
      String name, String phone, String dateOfBirth) async {
    var res = await http.patch(
        Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/users/"),
        headers: {
          "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
          "Accept": "*/*"
        },
        body: {
          "name": name,
          "phone": phone,
          // "image": imageUrl,
          "dayOfBirth": dateOfBirth
        });

    print("update proflie ${res}");
  }

  // Future<dynamic> ChangePassword(String password) async {
  //   var res = await http.patch(
  //       Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/users/"),
  //       headers: {
  //         "Authorization": "Bearer 61b36b47fd33e2b66764d1cb",
  //         "Accept": "*/*"
  //       },
  //       body: {
  //         "password": password
  //       });
  // }
}
