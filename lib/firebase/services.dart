import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/notesclass.dart';

class DatabaseServices {
  final CollectionReference notescollection =
      FirebaseFirestore.instance.collection("notes");
  // final DocumentReference notessdocref =
  //     FirebaseFirestore.instance.collection("notes").doc("example");

  Future addNewNote(Notes newNote) async {
    print("added");
    return await notescollection
        .doc(newNote.title)
        .set({"Title": newNote.title, "Desc": newNote.description});
  }
}
