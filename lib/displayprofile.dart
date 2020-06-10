import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(otp,reg_code) async {
  print("----------------------------,,,,,,,,,,,,,,,,,,,,");
  print(otp);
  print(reg_code);
  print('--------------------------------,,,,,,,,,,,,,,,,,,,,,');
  final http.Response response = await http.put(
    'http://kurlon.indictranstech.com/api/method/scm_payment_and_lending_management.scm_payment_and_lending_management.api.api.verify_otp',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'reg_code': reg_code,
      'otp': otp,
    }),
  );
  var jsonData1 =json.decode(response.body);
  print("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVvvv");
  print(jsonData1);
  var get_url_json = jsonData1["message"][0];
  print('********************************************************************2222222222222222222222');
  print(get_url_json);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(get_url_json);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Json');
  }
}


class Album {
  final String dealer_name;
  final String email_id;
  final String mobile_no;
  final String dealer_code;
  final String company_name;
  final String dealer_owner;
  final String address_line1;
  final String address_line2;
  final String city;
  final String state;
  final String pincode;
  final String country;


  Album({
    this.dealer_name,
    this.email_id,
    this.mobile_no,
    this.dealer_code,
    this.company_name,
    this.dealer_owner,
    this.address_line1,
    this.address_line2,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      dealer_name: json['dealer_name'],
      email_id: json['email_id'],
      mobile_no: json['mobile_no'],
      dealer_code: json['dealer_code'],
      company_name: json['company_name'],
      dealer_owner: json['dealer_owner'],
      address_line1: json['address_line1'],
      address_line2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      country: json['country'],
    );
  }
}

class MyApp1 extends StatefulWidget {
  final String otp;
  final String reg_code;
  MyApp1({Key key,this.otp, this.reg_code}) : super(key : key);
  @override
  _MyApp1State createState() => _MyApp1State(otp,reg_code);
}

class _MyApp1State extends State<MyApp1> {
  final TextEditingController _controller = TextEditingController();
  final String otp;
  final String reg_code;
  _MyApp1State(this.otp,this.reg_code);
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum(otp,reg_code);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        backgroundColor: Colors.blue[100],
        body: Container(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SourceSansPro',
                            color: Colors.red[400],
                            letterSpacing: 2.5,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Dealer Code : '+snapshot.data.dealer_code,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Company Name : '+snapshot.data.company_name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Dealer Owner : '+snapshot.data.dealer_owner,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 600,
                          child: Divider(
                            color: Colors.teal[100],
                          ),
                        ),
                        Card(
                            color: Colors.deepPurpleAccent,
                            margin:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: Text(
                                snapshot.data.dealer_name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 20,
                                ),
                              ),
                            )
                        ),
                        Card(
                          color: Colors.deepPurpleAccent,
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            title: Text(
                              snapshot.data.email_id,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Neucha'
                              ),
                            ),
                          ),
                        ),
                        Card(
                            color: Colors.deepPurpleAccent,
                            margin:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.contact_phone,
                                color: Colors.white,
                              ),
                              title: Text(
                                snapshot.data.mobile_no,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 20,
                                ),
                              ),
                            )
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Address Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceSansPro',
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400],
                                letterSpacing: 2.5,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Address Line1:  '+snapshot.data.address_line1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Address line2:  '+snapshot.data.address_line2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'City:  '+snapshot.data.city,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'State:  '+snapshot.data.state,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Pincode:  '+snapshot.data.pincode,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Country:  '+snapshot.data.country,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '              ',
                        ),
                        Wrap(
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Submit'),
                              onPressed: () {
                              },
                            ),
                            Text(
                              '              ',
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Edit'),
                              onPressed: () {
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}