import 'package:flutter/material.dart';
import 'package:notes/models/Notes.dart';
import 'package:notes/models/NotesProvider.dart';
import 'package:notes/models/Notes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NotesProviders().getNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CardList(
                  snapshot.data[index], index, snapshot.data[index].id);
            },
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  final Note notes;
  int index;
  String id;
  CardList(this.notes, this.index, this.id);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffff7e67),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(1),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(1),
              )),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.note),
              ],
            ),
            title: Text(
              notes.title,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Symon',
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            subtitle: Text(
              notes.description,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'Hadlee',
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
        secondaryActions: <Widget>[
          SlideAction(
            child: Container(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Color(0xffdbf6e9),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 35,
                  ),
                  onPressed: () {
                    Provider.of<NotesProviders>(context, listen: false)
                        .removeNotes(notes.id);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
