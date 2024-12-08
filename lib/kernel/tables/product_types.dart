// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class RProductTypes {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "r_product_types";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCT_TYPE_ID = "product_type_id";
	// ignore: non_constant_identifier_names
	static const String C_NAME = "name";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table r_product_types (
	  product_type_id          int not null,
	  name                     int not null,
	 constraint r_product_type_pk primary key (product_type_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? productTypeId, int? name) {
		ArgumentError.checkNotNull(productTypeId, C_PRODUCT_TYPE_ID);
		ArgumentError.checkNotNull(name, C_NAME);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_PRODUCT_TYPE_ID], C_PRODUCT_TYPE_ID);
		ArgumentError.checkNotNull(data[C_NAME], C_NAME);
	}

	static void checkPrimaryKeys(int? productTypeId) {
		ArgumentError.checkNotNull(productTypeId, C_PRODUCT_TYPE_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int productTypeId;
	final int name;

	RProductTypes({required this.productTypeId, required this.name});

	factory RProductTypes.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_PRODUCT_TYPE_ID]);
		return RProductTypes(
			productTypeId: data[C_PRODUCT_TYPE_ID],
			name: data[C_NAME],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_PRODUCT_TYPE_ID: this.productTypeId,
			C_NAME: this.name,
		};
	}

	@override
	String toString() {
		 return "RProductTypes($C_PRODUCT_TYPE_ID:$productTypeId, $C_NAME:$name)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_RProductTypes {

	// init
	static RProductTypes init({required int productTypeId, required int name}) {
		return new RProductTypes(productTypeId: productTypeId, name: name);
	}

	// load all rows in database
	static Future<List<RProductTypes>> loadAll(Database db) {
		return db.query(RProductTypes.TABLE_NAME)
			.then((it) => it.map((d) => RProductTypes.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<RProductTypes?> take(Database db, int productTypeId) async {
		final result = await db.query(RProductTypes.TABLE_NAME, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [productTypeId]);
		return result.isEmpty ? null : RProductTypes.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<RProductTypes> load(Database db, int productTypeId) async {
		final result = await take(db, productTypeId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int productTypeId) {
		return take(db, productTypeId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int productTypeId, void onResult(RProductTypes? row)) async {
		final result = await take(db, productTypeId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProductTypes.TABLE_NAME, data, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [data[RProductTypes.C_PRODUCT_TYPE_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProductTypes.TABLE_NAME, data, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [data[RProductTypes.C_PRODUCT_TYPE_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, RProductTypes row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProductTypes.TABLE_NAME, data, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [row.productTypeId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProductTypes.TABLE_NAME, data, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [row.productTypeId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int productTypeId, int? name, bool removeNull = false}) {
		return updateByMap(db, toMap(productTypeId: productTypeId, name: name), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, RProductTypes row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(RProductTypes.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypes.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int productTypeId, required int name, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [productTypeId, name]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		RProductTypes.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(RProductTypes.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypes.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(RProductTypes.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProductTypes.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int productTypeId) {
		if (db is Batch) {
			 db.delete(RProductTypes.TABLE_NAME, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [productTypeId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProductTypes.TABLE_NAME, where: "${RProductTypes.C_PRODUCT_TYPE_ID} = ?", whereArgs: [productTypeId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, RProductTypes row) {
		if (db is Batch) {
			db.insert(RProductTypes.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypes.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int productTypeId, required int name}) {
		return insertRowTry(db, toRowFromList(values: [productTypeId, name]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, RProductTypes row) {
		if (db is Batch) {
			db.insert(RProductTypes.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypes.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int productTypeId, required int name}) {
		return insertRow(db, toRowFromList(values: [productTypeId, name]));
	}

	// to map
	static Map<String, dynamic> toMap({RProductTypes? row, String? f1, String? f2, int? productTypeId, int? name}) {
		productTypeId = nvl(row?.productTypeId, productTypeId);
		name = nvl(row?.name, name);
		RProductTypes.checkPrimaryKeys(productTypeId);
		return {nvlString(f1, RProductTypes.C_PRODUCT_TYPE_ID): productTypeId, nvlString(f2, RProductTypes.C_NAME): name};
	}

	// to list
	static List<dynamic> toList({RProductTypes? row, int? productTypeId, int? name}) {
		productTypeId = nvl(row?.productTypeId, productTypeId);
		name = nvl(row?.name, name);
		RProductTypes.checkPrimaryKeys(productTypeId);
		return [productTypeId, name];
	}

	// to row from map
	static RProductTypes toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, int? productTypeId, int? name}) {
		productTypeId = nvl(data == null ? null : data[nvl(f1, RProductTypes.C_PRODUCT_TYPE_ID)], productTypeId);
		name = nvl(data == null ? null : data[nvl(f2, RProductTypes.C_NAME)], name);
		RProductTypes.checkRequired(productTypeId, name);
		return new RProductTypes(productTypeId: productTypeId!, name: name!);
	}

	// to row from list
	static RProductTypes toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2}) {
		final productTypeId = values[keys?.indexOf(nvl(f1, RProductTypes.C_PRODUCT_TYPE_ID)) ?? 0];
		final name = values[keys?.indexOf(nvl(f2, RProductTypes.C_NAME)) ?? 1];
		RProductTypes.checkRequired(productTypeId, name);
		return new RProductTypes(productTypeId: productTypeId, name: name);
	}

	// to row from list strings
	static RProductTypes toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2}) {
		dynamic productTypeId = values[keys?.indexOf(nvl(f1, RProductTypes.C_PRODUCT_TYPE_ID)) ?? 0];
		dynamic name = values[keys?.indexOf(nvl(f2, RProductTypes.C_NAME)) ?? 1];
		productTypeId = productTypeId is String && productTypeId.isNotEmpty ? num.parse(productTypeId) : null;
		name = name is String && name.isNotEmpty ? num.parse(name) : null;
		RProductTypes.checkRequired(productTypeId, name);
		return new RProductTypes(productTypeId: productTypeId, name: name);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			RProductTypes.C_PRODUCT_TYPE_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			RProductTypes.C_NAME: values.length > 1 ? nvlTryInt(values[1]) : null
		};
	}

	static R nvl<R>(R? a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String? a, String b) {
		return a == null ? b : a;
	}

	static int? nvlTryInt(Object value) {
		if (value is String)
			return value.isNotEmpty ? int.tryParse(value) : null;
		else if (value is int)
			return value;
		else
			return null;
	}


	static num? nvlTryNum(Object value) {
		if (value is String)
			return value.isNotEmpty ? num.tryParse(value) : null;
		else if (value is num)
			return value;
		else if (value is int)
			return value;
		else if (value is double)
			return value;
		else
			return null;
	}

}