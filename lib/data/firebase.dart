import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/task.dart';

CollectionReference<task>getTasks(){
  return FirebaseFirestore.instance.collection(task.collectionName)
      .withConverter<task>(fromFirestore: (snapshot,_)=> task.fromJson(snapshot.data()!),
      toFirestore: (item,_)=> item.toJson());
}
Future<void> pushToFirestore (String title, String description, DateTime dateTime){
  CollectionReference<task> collectionReference = getTasks();
  DocumentReference<task> docRef = collectionReference.doc();
  task item = task(id: docRef.id, title: title, description: description, dateTime: dateTime);
  return docRef.set(item);
}
