import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:notesapp/notesapp3/AddNote.dart';
import '../notesclass.dart';

class App3Page extends StatefulWidget {
  @override
  _App3PageState createState() => _App3PageState();
}

class _App3PageState extends State<App3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notes App 3",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNewNote()));
          },
          icon: Icon(Icons.add),
          label: Text("NEW"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                        return Center(child: Text("No Note Present"));
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
