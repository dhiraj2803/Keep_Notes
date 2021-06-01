import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/NoteList.dart';
import 'package:notes/models/NotesProvider.dart';
import 'package:provider/provider.dart';
import '../models/NotesProvider.dart';

// ignore: camel_case_types
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff68b0ab),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAlertDialog(context);
        },
        elevation: 5,
        backgroundColor: Color(0xff68b0ab),
        icon: Icon(Icons.edit),
        label: Text('New Note'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Notes🖋️',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Dogfight',
                      fontSize: 60.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xffdbf6e9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Consumer<NotesProviders>(
                builder: (context, NotesProviders data, child) {
                  return NoteList();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController _Title = TextEditingController();
  TextEditingController _Description = TextEditingController();
  // Create button
  Widget okButton = FloatingActionButton.extended(
    elevation: 5,
    backgroundColor: Color(0xff68b0ab),
    icon: Icon(Icons.save),
    label: Text('Save'),
    onPressed: () {
      Provider.of<NotesProviders>(context, listen: false)
          .addNotes(_Title.text, _Description.text);
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color(0xffdbf6e9),
    title: Text(
      "New Note",
      style: TextStyle(
          fontFamily: 'SpecialElite',
          fontWeight: FontWeight.bold,
          fontSize: 35),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          cursorWidth: 2.0,
          controller: _Title,
          decoration: InputDecoration(hintText: "Enter Title"),
        ),
        TextField(
          maxLines: 20,
          minLines: 1,
          controller: _Description,
          decoration: InputDecoration(hintText: "Enter Description"),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
