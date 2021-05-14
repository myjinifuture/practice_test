import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginui/Common/Services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({Key key}) : super(key: key);

  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {

  @override
  void initState() {
    _getOutsideVisitor();
  }

  List Result = [];
  Map queryParam = {};

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _getOutsideVisitor() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var data = {
          "category": "movies",
          "language": "telugu",
          "genre": "all",
          "sort": "voting"
        };
        Services.responseHandler(
            apiName: 'https://hoblist.com/movieList',
            body: data).then((data) async {
          if (data.result.length > 0 && data.message == "success") {
            setState(() {
              Result = data.result;
              queryParam = data.queryParam;
            });
            print("result");
            print(Result);
            print("queryParam");
            print(queryParam);
          } else {
            Fluttertoast.showToast(
                msg: "Error",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        }, onError: (e) {
          showMsg("Something Went Wrong Please Try Again");
        });
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Text("Task")
        ],
      ),
      body:Result.length > 0
          ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                      itemCount: Result.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.arrow_drop_up_outlined,
                                    size: 60,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.001,
                                    ),
                                    Text("${Result[index]["totalVoted"]}"),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.001,
                                    ),
                                    Icon(Icons.arrow_drop_down_outlined,
                                      size: 60,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:16.0),
                                      child: Text("Votes",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:15.0),
                                  child: Image.network(
                                    Result[index]["poster"],
                                    width: MediaQuery.of(context).size.width*0.25,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10.0,bottom: 7),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${Result[index]["title"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:10.0),
                                          child: Text("Genre: ${Result[index]["genre"]}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Text("Directory: ${Result[index]["director"][0]}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceBetween,
                                            children: [
                                              Text("Starring: ${Result[index]["stars"][0]}",
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Text("Mins | ${Result[index]['language']} | "),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0),
                                          child: Text("${Result[index]["pageViews"]}" +
                                              " views " + "|" + " Voted by "
                                              + "${Result[index]["totalVoted"]}" + " People",
                                          style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:15.0,right: 15.0),
                              child: TextButton(
                                onPressed: () {
                                  // _addEvent();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Watch Trailer",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                            ),
                          ],
                        );
                      },
                    ),
              ),
            ],
          )
          : Center(
        child: CircularProgressIndicator(),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Company Info'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Hoblist'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
