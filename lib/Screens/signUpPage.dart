import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/Constants.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key key}) : super(key: key);

  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  bool _obscureText = true;
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  String _professionType;
  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  storeDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Session.Name, txtName.text);
    prefs.setString(Session.Password, txtPassword.text);
    prefs.setString(Session.Email, txtEmail.text);
    prefs.setString(Session.PhoneNo, txtPhone.text);
    prefs.setString(Session.Profession, _professionType);
  }

  List _professionTypeList = [
    "Student",
    "Teacher",
    "Doctor",
      "Engineer"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: txtPassword,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        validator: (val) => val.length < 6 ? 'Password too short.' : null,
                        onSaved: (val) => _password = val,
                        obscureText: _obscureText,
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
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: txtEmail,
                        obscureText: true,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: txtPhone,
                        obscureText: true,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'PhoneNo',
                            prefixIcon: Icon(Icons.phone),
                            labelStyle: TextStyle(
                                fontSize: 15
                            )
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        hint: Text("Select Profession"),
                        value: _professionType,
                        onChanged: (val) {
                          setState((){
                            _professionType = val;
                          });
                        },
                        items:
                        _professionTypeList.map((dynamic val) {
                          return  DropdownMenuItem<dynamic>(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: (){
                        if(txtName==null || txtPassword==null || txtEmail == null || txtPhone == null || _professionType == null){
                          Fluttertoast.showToast(
                              msg: "Please fill all the fields",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white);
                        }
                        else if(txtPhone.text.length!=10){
                          Fluttertoast.showToast(
                              msg: "Phone No Should be of 10 digits",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white);
                        }
                        else if(!txtEmail.toString().contains("@")){
                          Fluttertoast.showToast(
                              msg: "Please Enter valid Email Address",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white);
                        }
                        else{
                          storeDataLocally();
                          Fluttertoast.showToast(
                              msg: "Account Created Successfully!!!",
                              backgroundColor: Colors.green,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white);
                          Navigator.of(context).pop();
                        }
                      },//since this is only a UI app
                      child: Text('Create Account',
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
