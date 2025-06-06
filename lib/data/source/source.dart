abstract class DataSource<T> {
  Future<List<T>> getAll({String searchKeyword});
  Future<T> findById(dynamic id);
  Future<void> deleteAll();
  Future<void> deleteById(dynamic id);
  Future<T> createOrUpdate(T data);
  Future<void> delete(data);
}
