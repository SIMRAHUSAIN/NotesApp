import 'dart:convert';

class Notes {
  String title;
  String description;

  Notes({this.title, this.description});

  //need a toMap function for database queries
  //when you create an object you are creating an instance of class
  /* object means where memory location is associated with object(it is a run time entity of a class)
  using a new operator, whereas Instance refers to the copy of
  an object at a particular time
   */
  /*factory function returns an instance of class. Dart uses this to
  label a default or named constructor. Then we have to return an instance from 
  constructor*/
  /* JSON is a lightweight format for storing and transporting data.
  it is self describing. JavaScript Object Notation*/
  /* Map<String, dynamic> toMap(class_name name) //used to convert a string to map
   */

  factory Notes.fromJson(Map<String, dynamic> jsonData) {
    return Notes(title: jsonData["title"], description: jsonData["desc"]);
  }

  //declaring a map
  static Map<String, dynamic> toMap(Notes task) =>
      {'title': task.title, 'desc': task.description};
//converting string type to json rep for data storage
  static String encodeTasks(List<Notes> tasks) => json.encode(
      tasks.map<Map<String, dynamic>>((task) => Notes.toMap(task)).toList());

  //converting jsonencoded string back to map
  static List<Notes> decodeTasks(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Notes>((item) => Notes.fromJson(item))
          .toList();
}
