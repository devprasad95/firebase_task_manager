class Task {
  String? id;
  bool? isDone;
  String? task;

  Task({this.id, this.isDone, this.task});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDone = json['isDone'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isDone'] = isDone;
    data['task'] = task;
    return data;
  }
}
