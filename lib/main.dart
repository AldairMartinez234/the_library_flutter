import 'package:The_Library/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:The_Library/view/new_book.dart';

void main() {
  runApp(FormApp());
}

class FormApp extends StatelessWidget {
  final String title='';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'The Library'),
      routes: <String,WidgetBuilder>{
        '/dashboard' : (BuildContext context) => new Home(title:title),
        '/new_book' : (BuildContext context) => new New_Book(title:title)
      },
    );
  }
}
