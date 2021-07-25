import 'package:The_Library/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:The_Library/Controllers/databasehelper.dart';


class New_Book extends StatefulWidget{

  List list;
  int index;

  New_Book({Key key , this.title,this.index , this.list}) : super(key : key);
  final String title;

  @override
  New_BookState  createState() => New_BookState();
}

class New_BookState extends State<New_Book> {
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController authorTextController = TextEditingController();
  TextEditingController categoryTextController = TextEditingController();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController dateinput = TextEditingController();


  @override
  void initState() {
    if (widget.list != null) {
      nameTextController = new TextEditingController(text: widget.list[widget.index]['name']);
      authorTextController = new TextEditingController(text: widget.list[widget.index]['author']);
      categoryTextController = new TextEditingController(text: widget.list[widget.index]['category']);
      statusTextController.text = widget.list[widget.index]['availability'];
      dateinput.text = widget.list[widget.index]['published_date'];
    } else {
      dateinput.text = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: Container(
          child: new Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _nameInput(), //2
                _authorInput(), //2
                _categoryInput(), //2
                _published_dateInput(), //2
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Center(
                    child: Text(
                      "Availability",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  dropdownColor: Color.fromRGBO(58, 66, 86, 1.0),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.list,color: Colors.white),
                  ),

                  focusColor: Colors.black,
                  value: statusTextController.text.isNotEmpty
                      ? statusTextController.text
                      : null,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  iconEnabledColor: Colors.white,
                  items: <String>[
                    'Available',
                    'Not available'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(color: Colors.white),),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a availability",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      statusTextController.text = value;
                    });
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _NewButton()), //2
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameInput() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp("[0-9.]")),
      ],
      controller: nameTextController,
      decoration: const InputDecoration(
        icon: Icon(Icons.book,color: Colors.white),
        hintText: 'Enter name',
          hintStyle: TextStyle(
              color: Colors.white
          ),
        labelText: 'Name',
          labelStyle: TextStyle(
              color: Colors.white
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },);
  }

  Widget _authorInput() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp("[0-9.]")),
      ],
        controller: authorTextController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person,color: Colors.white),
          hintText: 'Enter the author',
            hintStyle: TextStyle(
                color: Colors.white
            ),
          labelText: 'Author',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              ),
            )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },);
  }

  Widget _categoryInput() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: categoryTextController,
      decoration: const InputDecoration(
          icon: Icon(Icons.category,color: Colors.white),
          hintText: 'Enter category',
          hintStyle: TextStyle(
              color: Colors.white
          ),
          labelText: 'Category',
          labelStyle: TextStyle(
              color: Colors.white
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },);
  }

  Widget _published_dateInput() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: dateinput,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a valid date';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.calendar_today,color: Colors.white),
          labelText: "Enter published date",
          labelStyle: TextStyle(
          color: Colors.white
      ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
            context: context, initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101)
        );

        if (pickedDate != null) {
          print(pickedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate);

          setState(() {
            dateinput.text = formattedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  Widget _NewButton() {
    if (widget.list != null) {
      return RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            databaseHelper.editData(
                widget.list[widget.index]['id'], nameTextController.text.trim(),
                authorTextController.text.trim(),
                categoryTextController.text.trim(), dateinput.text.trim(),
                statusTextController.text.trim());
            Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new Home(),
                )
            );
          }
        },
        color: Colors.blue,
        child: new Text(
          'Save Changes',
          style: new TextStyle(
              color: Colors.white,
              backgroundColor: Colors.blue),),
      );
    } else {
      return RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            databaseHelper.addData(
                nameTextController.text.trim(),
                authorTextController.text.trim(),
                categoryTextController.text.trim(), dateinput.text.trim(),
                statusTextController.text.trim());
            Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new Home(),
                )
            );
          }
        },
        color: Colors.blue,
        child: new Text(
          'Save',
          style: new TextStyle(
              color: Colors.white,
              backgroundColor: Colors.blue),),
      );
    }
  }

}







