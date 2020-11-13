import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/list_items.dart';
import 'models/shopping_list.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }
  final int version = 1;
  Database db;
  static const tableLists = """
  CREATE TABLE IF NOT EXISTS lists
  (id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  priority INTEGER);
  """;
  static const tableItems = """
  CREATE TABLE IF NOT EXISTS items(id INTEGER PRIMARY KEY, 
  idList INTEGER, name TEXT, quantity TEXT,
  note TEXT);
  """;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (database, version) {
        database.execute(tableLists);
        database.execute(tableItems);
      }, version: version);
    }
    return db;
  }

  Future<int> insertList(ShoppingList list) async {
    openDb();
    int id = await this.db.insert(
          'lists',
          list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<int> insertItem(ListItem item) async {
    openDb();
    int id = await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query('lists');
    return List.generate(maps.length, (i) {
      return ShoppingList(maps[i]['id'], maps[i]['name'], maps[i]['priority']);
    });
  }

  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps =
        await db.query('items', where: 'idList = ?', whereArgs: [idList]);
    return List.generate(maps.length, (i) {
      return ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['name'],
        maps[i]['quantity'],
        maps[i]['note'],
      );
    });
  }

  Future<int> deleteList(ShoppingList list) async {
    int result = await db.delete("items", where: "idList = ?",
        whereArgs: [list.id]);
    result = await db.delete("lists", where: "id = ?", whereArgs:
    [list.id]);
    return result;
  }
}
