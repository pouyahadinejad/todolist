import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/data/source/source.dart';
// import 'package:task_list/data/data.dart';
// import 'package:task_list/data/source/source.dart';

class HiveTaskDataSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HiveTaskDataSource(this.box);

  @override
  Future<TaskEntity> createOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskEntity data) async {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) {
    return box.delete(id);
  }

  @override
  Future<TaskEntity> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskEntity>> getAll({String searchKeyword = ''}) async {
    if (searchKeyword.isNotEmpty) {
      return box.values
          .where((task) => task.name.contains(searchKeyword))
          .toList();
    } else {
      return box.values.toList();
    }
  }
}
