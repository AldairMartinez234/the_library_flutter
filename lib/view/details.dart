import 'package:The_Library/Controllers/databasehelper.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'new_book.dart';

class Details extends StatefulWidget{

  List list;
  int index;
  Details({this.index , this.list}) ;

  @override
  DetailsState  createState() => DetailsState();
}

class DetailsState extends State<Details> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            title: Text('Details Book'),
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          ),
          body: new ListView(
            children: <Widget>[
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              new ListTile(
                leading: const Icon(Icons.book,color: Colors.white),
                title: const Text('Name',style: TextStyle(color: Colors.white)),
                subtitle: new Text('${ widget.list[widget.index]['name']}',style: TextStyle(color: Colors.white)),
              ),
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              new ListTile(
                leading: const Icon(Icons.person,color: Colors.white),
                title: const Text('Author',style: TextStyle(color: Colors.white)),
                subtitle: new Text('${ widget.list[widget.index]['author']}',style: TextStyle(color: Colors.white)),
              ),
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              new ListTile(
                leading: const Icon(Icons.category,color: Colors.white),
                title: const Text('Category',style: TextStyle(color: Colors.white)),
                subtitle: new Text('${ widget.list[widget.index]['category']}',style: TextStyle(color: Colors.white)),
              ),
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              new ListTile(
                leading: const Icon(Icons.calendar_today,color: Colors.white),
                title: const Text('Published_date',style: TextStyle(color: Colors.white)),
                subtitle: new Text('${ widget.list[widget.index]['published_date']}',style: TextStyle(color: Colors.white)),
              ),
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              new ListTile(
                leading: const Icon(Icons.event_available,color: Colors.white),
                title: const Text('Availability',style: TextStyle(color: Colors.white)),
                subtitle: new Text('${ widget.list[widget.index]['availability']}',style: TextStyle(color: Colors.white)),
              ),
              const Divider(
                height: 6.0,
                color: Colors.white,
              ),
              const Divider(
                height: 50.0,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only( right: 20.0),
              height: 30,
              child: new RaisedButton(
                elevation: 10.0,
                onPressed: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new New_Book(list:widget.list , index:widget.index , title:'Edit Book', ),
                    )
                ) ,
                color: Colors.green,
                child: new Text(
                  'Edit',
                  style: new TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                  ),),
              ),
            ),

            Container(
              height: 30,
              child: new RaisedButton(
                elevation: 10.0,
                onPressed: (){
                  databaseHelper.deleteData(widget.list[widget.index]['id']);
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Home(),
                      )
                  );
                },
                color: Colors.red,
                child: new Text(
                  'Delete',
                  style: new TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                  ),),
              ),
            ),
            ],
        )],
          )
      ),
    );
  }

}















