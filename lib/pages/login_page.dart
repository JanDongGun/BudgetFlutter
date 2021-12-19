import 'dart:convert';
import 'package:budgetapp/pages/root_app.dart';
import 'package:budgetapp/pages/signup_page.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:budgetapp/theme/colors.dart';
import 'package:budgetapp/pages/daily_page.dart';

// import 'package:buggettracker/general.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  
  // final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
              "Budget tracker",
              style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 20
            )
         ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: TextButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
                  return SignUpPage();
                }), (route)=>false);
              }, 
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: primary
                ),
              ),
            ),
          )
        ],
        backgroundColor: white,
        elevation: 0.5,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(80, 0, 0, 50),
                child: Image.asset("assets/images/login.png"),
              ),
              const Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: "GTWalsheimPro",
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              const SizedBox(height: 50),
              Row(children: [
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                    labelText: "Password",
                     labelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                     )
                  ),
                 ),
                ),
                const SizedBox(width: 40,),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: primary
                  ),
                  child: IconButton(
                    onPressed: (){
                      login();
                    }, 
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: white,
                    highlightColor: Colors.red,
                  ) ,
                )
                
              ],),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                "or",
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 800,
                height: 50,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(const BorderSide(width: 1, color: Colors.blue)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                  ),
                  onPressed: (){},
                  child: Row(children: const [
                    FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.blue,
                      size: 16,
                    ),
                    SizedBox(width: 80),
                    Text(
                      "Login with facebook",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],),
                 
                )
              ),
              const SizedBox(height: 30),
              const Center(
                child: TextButton(
                  onPressed: null,
                  child: Text("Forgot password?"),
              ),
              )
             
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {

    var res = await http.post(Uri.parse("https://budgettrackerapi.herokuapp.com/api/v1/users/signin"), 
      body: ({
        "email": emailController.text,
        "password": passwordController.text
      })
    );

    if(res.statusCode == 200){
      var jsonRes = jsonDecode(res.body);

      Navigator.push(context, MaterialPageRoute(builder: (context) => const RootApp()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login faild")));
    }
  
  }
}
