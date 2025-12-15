import 'dart:async';

enum DBEventType { add, remove }

class DBEvent<K, V> {
  final K key;
  final V? value;
  final DBEventType type;

  DBEvent(this.key, this.value, this.type);
}

class Database<K, V> {
  static const Duration _delay = Duration(milliseconds: 250);

  final Map<K, V> _database;
  final StreamController<DBEvent<K, V>> _controller =
      StreamController.broadcast();

  Database(this._database);

  //getter of db changes
  Stream<DBEvent<K, V>> get changes => _controller.stream;

  //method to add new value to db
  Future<void> add(K key, V value) async {
    await Future.delayed(_delay);

    _database[key] = value;
    _controller.add(DBEvent(key, value, DBEventType.add));
  }

  //method to get value from db
  Future<V?> get(K key) async {
    await Future.delayed(_delay);

    return _database[key];
  }

  //method to remove value from db
  Future<void> remove(K key) async {
    await Future.delayed(_delay);

    final V? removed = _database.remove(key);
    if (removed != null)
      _controller.add(DBEvent(key, null, DBEventType.remove));
  }

  void dispose() => _controller.close();
}

void main() async {
  final db = Database<String, int>({});

  db.changes.listen((event) {
    print('DB event: ${event.type.name} ${event.key} ${event.value}');
  });

  await db.add('counter', 1);
  await db.add('counter', 2);

  final value = await db.get('counter');
  print('VALUE: $value');

  await db.remove('counter');

  db.dispose();
}
