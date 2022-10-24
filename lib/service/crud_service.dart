import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task_manager/service/auth_service.dart';

class CrudService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> get taskStream {
    return users.doc(AuthService().userId).collection('tasks').snapshots();
  }

  Future<void> addTask({
    required String task,
  }) async {
    await users.doc(AuthService().userId).collection('tasks').add(
      {
        'task': task,
        'isDone': false,
      },
    );
  }

  Future<void> delettask({
    required String id,
  }) async {
    await users.doc(AuthService().userId).collection('tasks').doc(id).delete();
  }

  Future<void> completeTask(
      {required String id, required bool complete}) async {
    await users.doc(AuthService().userId).collection('tasks').doc(id).update(
      {
        'isDone': complete,
      },
    );
  }
}
