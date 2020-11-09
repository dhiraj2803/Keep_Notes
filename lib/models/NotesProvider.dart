import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes/models/Notes.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = "https://keepnotes-backend.herokuapp.com/note";

class NotesProviders extends ChangeNotifier {
  //Notes List
  List<Note> notes = [];

  Future<List<Note>> getNotes() async {
    var data = await http.get(url);
    var jsonData = json.decode(data.body);

    for (var n in jsonData) {
      Note note =
          Note(title: n["title"], description: n["content"], id: n['_id']);

      notes.add(note);
    }
    return notes;
  }

// function to add data to list of notes
  void addNotes(String title, String descriptions) async {
    var response = await http.post(url, body: {
      'title': title,
      'content': descriptions,
    });
    print('Response status: ${response.statusCode}');
    notifyListeners();
  }

  // function to remove or delete notes by using list index position
  void removeNotes(String id) async {
    var response = await http.delete(
      '$url/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(id);
    notifyListeners();
  }
}
