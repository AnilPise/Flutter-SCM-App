import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'displayprofile.dart';


class OtpPage extends StatefulWidget {
  final String reg_code;
  final String sitename;
  OtpPage({Key key,this.reg_code, this.sitename}) : super(key : key);
  @override
  _OtpPageState createState() => new _OtpPageState(reg_code);
}

class _OtpPageState extends State<OtpPage> {
  var _textController1 = new TextEditingController();
  final String reg_code;
  _OtpPageState(this.reg_code);
  Future<String> _generate_otp() async {
    final http.Response data = await http.post(
      'http://uatscm.indictranstech.com/api/method/scm_crm.api.api.get_url',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'reg_code': reg_code,
      }),
    );
    var jsonData1 =json.decode(data.body);
    print("--------------------------------------------------------------");
    print("--------------------------------------------------------------");
    print(jsonData1);
    var get_url_json = jsonData1["message"][0];
    var customer_url = get_url_json["customer_url"];


    final http.Response data1 = await http.post(
      'http://'+customer_url+'/api/method/scm_payment_and_lending_management.scm_payment_and_lending_management.api.api.generate_otp',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'reg_code': reg_code,
      }),
    );
    var jsonData =json.decode(data1.body);
    print(jsonData);
    return reg_code;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:Container(
        child: FutureBuilder(
          future: _generate_otp(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            List<Widget> children;
            if (snapshot.hasData) {
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   validate Otp page");
              print(snapshot.data);
            }
            return new Scaffold(
              appBar: new AppBar(
                title: new Text("OPT Screen"),
              ),
              body: new ListView(
                children: <Widget>[
                  new ListTile(
                    title: new TextField(
                      controller: _textController1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter OTP',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Validate OTP'),
                        onPressed: (){
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new MyApp1(otp: _textController1.text,reg_code: snapshot.data),
                          );
                          Navigator.of(context).push(route);
                        },
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

