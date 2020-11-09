import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/NotesProvider.dart';
import 'package:notes/models/Notes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          icon: Icon(Icons.message),
          label: Text('New Note'),
        ),
        body:Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Dogfight',
                        fontSize: 60.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
/*                Text(
                  '${Provider.of<NoteData>(context).noteCount} Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    //
                  ),
                ),*/
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
                  builder: (context,NotesProviders data,child){
                    return data.getNotes.length !=0 ? ListView.builder(
                      itemCount: data.getNotes.length,
                      itemBuilder: (context,index){
                        return CardList(data.getNotes[index],index);
                      },
                    ): GestureDetector(onTap: (){
                      showAlertDialog(context);
                    },child: Center(child: Text("NO NOTES",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'SpecialElite'),)));
                  },
                ),
              ),)
          ],
        )
    );

  }

}

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  final Notes notes;
  int index;
  CardList(this.notes,this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child:Slidable(
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
              )
          ),

          child: ListTile(
            leading: Column(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.note),
              ],
            ),


            title: Text(notes.title,

              style: TextStyle(color: Colors.black,
                  fontFamily: 'Symon',
                  fontWeight: FontWeight.bold,
                  fontSize: 23),),

            subtitle: Text(notes.description,

              style: TextStyle(color: Colors.grey[800],
                  fontFamily: 'Hadlee',

                  fontWeight: FontWeight.normal,
                  fontSize: 18),),


            trailing: Column(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.arrow_forward_ios,color: Colors.black26,),
              ],
            ),
          ),

        ),

        secondaryActions: <Widget>[
          SlideAction(
            child: Container(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor:  Color(0xffdbf6e9),
                  child:  Icon(Icons.delete,color: Colors.red,size: 35,),
                  onPressed:  (){
                Provider.of<NotesProviders>(context,listen: false).removeNotes(index);
              }),
            ),
/*              caption: 'Delete',
              color: LinearGradient(begin: 0xffde6262),
             // color: Color(0x80ff4500),
              icon: Icons.delete,
              onTap: (){
                Provider.of<NotesProviders>(context,listen: false).removeNotes(index);
              }*/
          ),
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
      Provider.of<NotesProviders>(context,listen: false).addNotes(_Title.text, _Description.text);
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color(0xffdbf6e9),

    title: Text("New Note",style: TextStyle(fontFamily: 'SpecialElite',fontWeight: FontWeight.bold,fontSize: 35),),
    content:
    Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(

          cursorWidth: 2.0,
          controller: _Title,
          decoration:
          InputDecoration(
              hintText: "Enter Title"
          ),
        ),
        TextField(
          maxLines: 20,
          minLines: 1,
          controller: _Description,
          decoration: InputDecoration(hintText: "Enter Description"),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(
        Radius.circular(15))),
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


