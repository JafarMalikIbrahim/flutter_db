import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/item.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(''' 
    CREATE TABLE items ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT, 
      price INTEGER, 
      stok INTEGER,
      kodeBarang TEXT
 ) 
 ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'shinwoo.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

// Create new item
  static Future<int> createItem(Item item) async {
    final db = await SQLHelper.db();
    int id = await db.insert('items', item.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Item>> getItemList() async {
    final db = await SQLHelper.db();
    var mapList = await db.query('items', orderBy: 'name');
    int count = mapList.length;
    List<Item> itemList = [];
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(mapList[i]));
    }

    return itemList;
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    var item =
        await db.query('items', where: 'id=?', whereArgs: [id], limit: 1);
    return item;
  }

  // Update an item by id
  static Future<int> updateItem(Item item) async {
    final db = await SQLHelper.db();
    final result = await db
        .update('items', item.toMap(), where: 'id=?', whereArgs: [item.id]);
    return result;
  }

  // Delete an item by id
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id=?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Kesalahan menghapus item: $err");
    }
  }
}
