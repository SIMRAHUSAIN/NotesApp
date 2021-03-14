import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:flutter/material.dart';
import 'package:notesapp/firebase/services.dart';
//import 'package:intl/intl.dart';
//used for internationalized msgs, date and number format
//parsing, bi-directional text, other internationalization issues

import 'notesclass.dart';

class App1Page extends StatefulWidget {
  @override
  _App1PageState createState() => _App1PageState();
}

class _App1PageState extends State<App1Page> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notes App 1",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
                controller: _controller1,
                maxLines: 2,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    focusColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: "Title")),
            SizedBox(height: 15),
            TextField(
                controller: _controller2,
                maxLines: 2,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    focusColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: "Description")),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 120,
                  child: RaisedButton(
                    onPressed: () {
                      Notes nt = new Notes(
                          title: _controller1.text.trim(),
                          description: _controller2.text.trim());
                      DatabaseServices().addNewNote(nt);
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("SAVE",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: cf.FirebaseFirestore.instance
                        .collection("notes")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.blue,
                                    strokeWidth: 3)));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text("No note present"));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              cf.DocumentSnapshot ds =
                                  snapshot.data.documents[index];
                              Notes notes = new Notes(
                                  title: ds["title"], description: ds["desc"]);
                              return Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.assignment, size: 45),
                                      title: Text(notes.title),
                                      subtitle: Text(notes.description),
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                    }))
          ],
        ));
  }
}
