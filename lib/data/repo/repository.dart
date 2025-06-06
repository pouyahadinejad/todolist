import 'package:hive/hive.dart';
import 'package:todolist/data/source/source.dart';

class Repository<T> implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository(HiveInterface hive, {required this.localDataSource});
  @override
  Future<T> createOrUpdate(T data) {
    return localDataSource.createOrUpdate(data);
  }

  @override
  Future<void> deleteAll() {
    return deleteAll();
  }

  @override
  Future<void> deleteById(id) {
    return deleteById(id);
  }

  @override
  Future<T> findById(id) {
    return findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return getAll(searchKeyword: searchKeyword);
  }

  @override
  Future<void> delete(void data)async {
    return delete(data);
  }
}
