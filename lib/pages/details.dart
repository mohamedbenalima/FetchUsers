import 'package:flutter/material.dart';
import 'package:rannlabapplication/themes/color.dart';

import '/themes/color.dart';

class Details extends StatefulWidget {
  //final user;
  final fullName;
  final email;
  final profileUrl;
  Details({
    this.fullName,
    this.email,
    this.profileUrl,
  }) : super();

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var name = widget.fullName;
    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  color: primary,
                  // borderRadius: BorderRadius.circular(60 / 2),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.profileUrl))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.email.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
