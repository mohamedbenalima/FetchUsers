import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rannlabapplication/models/user.dart';
import 'package:rannlabapplication/themes/color.dart';

import 'package:http/http.dart' as http;

import 'details.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://randomuser.me/api/?results=50";
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      for (var i = 0; i < items.length; i++) {
        var fullName = items[i]['name']['title'] +
            " " +
            items[i]['name']['first'] +
            " " +
            "\n" +
            items[i]['name']['last'];
        var email = items[i]['email'];
        var profileUrl = items[i]['picture']['large'];
        users.add(User(fullName, email, profileUrl));
      }
      // print("++++++++++++++++++++++++++++++++++++++++++++++++++++++" +
      //     users[2].fullName);
      setState(() {
        //users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
        child: Lottie.asset('assets/lottie.json'),
        //     child: CircularProgressIndicator(
        //   valueColor: new AlwaysStoppedAnimation<Color>(primary),
        // ));
      );
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(item.profileUrl))),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          item.fullName,
                          style: TextStyle(fontSize: 17),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.email.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      fullName: item.fullName,
                      email: item.email.toString(),
                      profileUrl: item.profileUrl,
                    )),
          ),
        ),
      ),
    );
  }
}
