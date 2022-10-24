import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task_manager/service/auth_service.dart';
import 'package:firebase_task_manager/service/crud_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: CrudService().taskStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final taskId = streamSnapshot.data!.docs[index].id;
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        spacing: 8,
                        onPressed: (context) {
                          CrudService().delettask(id: taskId);
                        },
                      ),
                    ],
                  ),
                  child: CheckboxListTile(
                    value: streamSnapshot.data!.docs[index]['isDone'],
                    onChanged: (value) {},
                    title: Text(streamSnapshot.data!.docs[index]['task']),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add task'),
                titlePadding: const EdgeInsets.all(20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: taskController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await CrudService()
                                .addTask(task: taskController.text);
                            taskController.clear();
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
