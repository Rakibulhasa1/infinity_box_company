// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/screeen/product_list_screen.dart';

import '../auth_api/api_service.dart';
import '../model/login_model.dart';
import '../widgets/progress.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 240, 240),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: maincolor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 38,
                              color: Colors.white),
                        ),
                        Expanded(child: Container()),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) => !input!.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              loginRequestModel.password = input,
                          validator: (input) => input!.length < 8
                              ? "Password should be more than 8 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.white,
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1,
                          child: ElevatedButton(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 12, horizontal: 80),
                            onPressed: () {
                              if (validateAndSave()) {
                                print(loginRequestModel.toJson());

                                setState(() {
                                  isApiCallProcess = true;
                                });

                                APIService apiService = APIService();
                                apiService
                                    .login(loginRequestModel)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });

                                    if (value.token!.isNotEmpty) {
                                      final snackBar = SnackBar(
                                          content: Text("Login Successful"));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductListScreen()));
                                      // scaffoldKey.currentState
                                      //     .showSnackBar(snackBar);
                                    } else {
                                      final snackBar = SnackBar(
                                          content:
                                              Text(value.error.toString()));
                                      // scaffoldKey.currentState
                                      //     .showSnackBar(snackBar);
                                    }
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: maincolor),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: StadiumBorder()),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'For Log in Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Email: eve.holt@reqres.in'),
            Text('Password: cityslicka')
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
