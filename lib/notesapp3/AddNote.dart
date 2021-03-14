import 'package:flutter/material.dart';
import 'package:notesapp/firebase/services.dart';
import 'package:notesapp/notesapp3/page3.dart';

import '../notesclass.dart';

class AddNewNote extends StatefulWidget {
  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 30),
          SizedBox(
            height: 60,
            width: 330,
            child: TextField(
                controller: _controller1,
                maxLines: 2,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    focusColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: "Title",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)))),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 60,
            width: 330,
            child: TextField(
                controller: _controller2,
                maxLines: 2,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    focusColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: "Description",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1)))),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 210,
                  child: RaisedButton(
                    onPressed: () {
                      Notes nt = new Notes(
                          title: _controller1.text.trim(),
                          description: _controller2.text.trim());
                      DatabaseServices().addNewNote(nt);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => App3Page()));
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("SAVE",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ))
            ],
          )
        ]));
  }
}
