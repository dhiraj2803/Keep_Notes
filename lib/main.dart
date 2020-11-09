import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes/screens/Home_Screens.dart';
import 'package:notes/models/NotesProvider.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>NotesProviders(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue ,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home_Screen()
      ),
    );
  }
}

//HexColor("#ffff4444")