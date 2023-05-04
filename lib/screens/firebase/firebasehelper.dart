
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

Future<void> saveColors(List<Color> colors) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference colorsRef =
        FirebaseFirestore.instance.collection('colors');

    // Create a new document with a unique ID
    DocumentReference docRef = colorsRef.doc();

    // Store the color list as a field in the document
    await docRef.set({'colors': colors.map((c) => c.hex).toList()});

    print('Color list saved successfully!');
  } catch (e) {
    print('Error saving color list: $e');
  }
}
CollectionReference colors = FirebaseFirestore.instance.collection('colors');

Future<void> deleteUser() {
  return colors
    .doc(colors.id)
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));
}
CollectionReference myCollection = FirebaseFirestore.instance.collection('colors');

Future<void> deleteAllDocuments() {
  return myCollection
    .get()
    .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        document.reference.delete();
      });
      print("All documents in collection deleted");
    })
    .catchError((error) => print("Failed to delete documents: $error"));
}