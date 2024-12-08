import 'dart:collection';

import 'package:paloma365/kernel/database_seed.dart';
import 'package:paloma365/kernel/tables/order_products.dart';
import 'package:paloma365/kernel/tables/orders.dart';
import 'package:paloma365/kernel/tables/product_type_binds.dart';
import 'package:paloma365/kernel/tables/product_types.dart';
import 'package:paloma365/kernel/tables/products.dart';
import 'package:paloma365/kernel/tables/seats.dart';
import 'package:sqflite/sqflite.dart';

typedef VoidOnConfigure = void Function(Batch);
typedef VoidOnOpen = void Function(Batch);
typedef VoidOnCreate = void Function(Batch);

Future<void> batchWithCommit(Database db, void onRun(Batch)) async {
  final b = db.batch();

  onRun.call(b);

  await b.commit().then((value) => print("SUCCESS batch commit")).catchError(onError);
}

void onError([dynamic error, dynamic stacktrace]) {
  String message = error.toString();
  if (stacktrace != null) {
    message += "\n$stacktrace";
  }
  print("Log.ERROR: $message");
}

Future<Database> connectDatabase(
  String key,
  String path, {
  VoidOnConfigure? onConfigure,
  VoidOnOpen? onOpen,
  VoidOnCreate? onCreate,
}) async {
  DatabaseWrapper? db = DatabaseWrapper.instance(key);
  if (db != null && db.isOpen()) {
    await db.close();
  }
  return openDatabase(
    path,
    version: 1,
    onConfigure: (db) => batchWithCommit(db, (b) => onConfigure?.call(b)),
    onCreate: (db, version) => batchWithCommit(db, (b) => onCreate?.call(b)),
    onOpen: (db) => batchWithCommit(db, (b) => onOpen?.call(b)),
  );
}

abstract class DatabaseWrapper {
  static final Map<String, DatabaseWrapper> _database = HashMap();

  static DatabaseWrapper? instance(String key) => _database[key];

  static DatabaseWrapper requireInstance(String key) {
    DatabaseWrapper? db = instance(key);
    if (db == null) {
      throw Exception(
          "database by key:$key is null, you can use others database keys:${_database.keys}");
    }
    return db;
  }

  static bool isDatabaseOpen(String key) =>
      _database.containsKey(key) && requireInstance(key)._db.isOpen;

  Database _db;

  DatabaseWrapper(String key, Database db) : _db = db {
    _database[key] = this;
  }

  Database getDatabase() => _db;

  bool isOpen() => _db.isOpen;

  Future<void> close() async {
    if (isOpen()) {
      return _db.close();
    }
  }
}

class DatabaseHolder extends DatabaseWrapper {
  static const DATABASE = "global";

  static void onCreate(Batch batch) {
    batch.execute(RSeats.TABLE);
    batch.execute(RProducts.TABLE);
    batch.execute(RProductTypes.TABLE);
    batch.execute(RProductTypeBinds.TABLE);
    batch.execute(COrders.TABLE);
    batch.execute(COrderProducts.TABLE);
  }

  static void onOpen(Batch batch) {
    final seed = DatabaseSeed(batch);

    seed.seedDatabase();
  }

  static bool isDatabaseOpen() => DatabaseWrapper.isDatabaseOpen(DATABASE);

  static DatabaseHolder getInstance() =>
      DatabaseWrapper.requireInstance(DATABASE) as DatabaseHolder;

  DatabaseHolder({required Database database}) : super(DATABASE, database);

  static Future<DatabaseHolder> newInstance() async {
    String path = await getDatabasesPath().then((p) => [p, "$DATABASE.db"].join("/"));

    final database = await connectDatabase(DATABASE, path, onCreate: onCreate, onOpen: onOpen);

    return DatabaseHolder(database: database);
  }
}
