import 'package:The_Library/view/details.dart';
import 'package:The_Library/view/new_book.dart';
import 'package:flutter/material.dart';
import 'package:The_Library/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget{

  Home({Key key , this.title}) : super(key : key);
  final String title;

  @override
  HomeState  createState() => HomeState();
}

class HomeState extends State<Home> {

  DatabaseHelper databaseHelper = new DatabaseHelper();



  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

          appBar: AppBar(
            title:  Text('The Library'),
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add,color: Color.fromRGBO(58, 66, 86, 1.0)),
            backgroundColor:Colors.blueGrey,
            onPressed: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new New_Book(title: 'New Book',),
                )
            ),
          ),
          body: new FutureBuilder<List>(
            future: databaseHelper.getData(),
            builder: (context ,snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(list: snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          )
      ),
    );
  }


}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
          return new Container(
            padding: const EdgeInsets.all(5.0),
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Details(list:list , index:i,) ),
              ),

              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                color: Color.fromRGBO(58, 66, 86, 5.0),
                child: new ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: new Text(list[i]['name'],style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  leading: SizedBox(height: 50.0,
                    width: 50.0, child: Icon(Icons.book,color: Colors.white),),
                  subtitle: new Text('Author : ${list[i]['author']}',style: TextStyle(color: Colors.white))
                ),
              )
              ,
            ),
          );
        }
    );
  }

}















