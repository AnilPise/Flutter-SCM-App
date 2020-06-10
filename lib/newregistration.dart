import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'validateotp.dart';
import 'main.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _reg_code_textinput = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Demo home Page"),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'New Registration',
                style: TextStyle(fontSize: 20),
              )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                '',
                style: TextStyle(fontSize: 20),
              )),
          new ListTile(
            title: new TextField(
              controller: _reg_code_textinput,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Reference No',
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                '',
                style: TextStyle(fontSize: 20),
              )),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Submit'),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new OtpPage(reg_code: _reg_code_textinput.text),
                  );
                  Navigator.of(context).push(route);
                },
              )),
          Container(
              child: Row(
                children: <Widget>[
                  Text('Already have an account?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new MyApp(),
                      );
                      Navigator.of(context).push(route);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
        ],
      ),
    );
  }
}

