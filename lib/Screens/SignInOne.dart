import 'package:flutter/material.dart';
import 'package:loginui/Screens/signUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dashBoard.dart';

class SignInOne extends StatefulWidget {

  @override
  _SignInOneState createState() => _SignInOneState();
}

class _SignInOneState extends State<SignInOne> {

  @override
  void initState() {
   getLocalData();
  }

  String name="",password="";

  TextEditingController txtName = new TextEditingController();

  TextEditingController txtPassword = new TextEditingController();

  getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Session.Name);
    password = prefs.getString(Session.Password);
    print(name);
    print(password);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image1.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
            )
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      controller: txtName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(
                          fontSize: 15
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    controller: txtPassword,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){
                      if(txtName.text == "" || txtPassword.text == ""){
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white);
                      }
                      else if(txtName.text != name.toString() || txtPassword.text!=password.toString()){
                        Fluttertoast.showToast(
                            msg: "invalid credentials",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white);
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => dashBoard()),
                        );
                      }
                    },//since this is only a UI app
                    child: Text('SIGN IN',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    color: Color(0xffff2d55),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontFamily: 'SFUIDisplay',
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signUpPage()),
                          ),
                          child: Text(
                            " sign up",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xffff2d55),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}