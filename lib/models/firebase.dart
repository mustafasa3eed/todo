import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task.dart';

extension MyDateExtension on DateTime{
  DateTime getDateOnly(){
    return DateTime(year,month,day);
  }
}

CollectionReference<task>getTasks(){
  return FirebaseFirestore.instance.collection(task.collectionName)
      .withConverter<task>(fromFirestore: (snapshot,_)=> task.fromJson(snapshot.data()!),
      toFirestore: (item,_)=> item.toJson());
}
Future<void> pushToFirestore (String title, String description, DateTime dateTime){
  CollectionReference<task> collectionReference = getTasks();
  DocumentReference<task> docRef = collectionReference.doc();
  task item = task(id: docRef.id, title: title, description: description, dateTime: dateTime.getDateOnly());
  return docRef.set(item);
}

Future<void> deleteTask(task item){
  CollectionReference<task> collectionReference = getTasks();
  DocumentReference<task>itemDoc = collectionReference.doc(item.id);
  return itemDoc.delete();

}
isDone(task item){
 CollectionReference taskRef = getTasks();
 taskRef.doc(item.id).update({'isDone':item.isDone?false:true});
}

Future<void> editTaskDetails(task item){
 CollectionReference taskRef = getTasks();
 return taskRef.doc(item.id).update({
   'title':item.title,
   'description':item.description,
   'dateTime': item.dateTime.getDateOnly().millisecondsSinceEpoch
 });
}