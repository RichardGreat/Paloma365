// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class RProductTypeBinds {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "r_product_type_binds";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCT_TYPE_ID = "product_type_id";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCT_ID = "product_id";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table r_product_type_binds (
	  product_type_id          int not null,
	  product_id               int not null,
	 constraint r_product_type_binds_pk primary key (product_type_id, product_id)
	 constraint r_product_type_binds_f1 foreign key (product_type_id) references r_product_types(product_type_id)
	 constraint r_product_type_binds_f2 foreign key (product_id) references r_products(product_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? productTypeId, int? productId) {
		ArgumentError.checkNotNull(productTypeId, C_PRODUCT_TYPE_ID);
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_PRODUCT_TYPE_ID], C_PRODUCT_TYPE_ID);
		ArgumentError.checkNotNull(data[C_PRODUCT_ID], C_PRODUCT_ID);
	}

	static void checkPrimaryKeys(int? productTypeId, int? productId) {
		ArgumentError.checkNotNull(productTypeId, C_PRODUCT_TYPE_ID);
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int productTypeId;
	final int productId;

	RProductTypeBinds({required this.productTypeId, required this.productId});

	factory RProductTypeBinds.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_PRODUCT_TYPE_ID], data[C_PRODUCT_ID]);
		return RProductTypeBinds(
			productTypeId: data[C_PRODUCT_TYPE_ID],
			productId: data[C_PRODUCT_ID],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_PRODUCT_TYPE_ID: this.productTypeId,
			C_PRODUCT_ID: this.productId,
		};
	}

	@override
	String toString() {
		 return "RProductTypeBinds($C_PRODUCT_TYPE_ID:$productTypeId, $C_PRODUCT_ID:$productId)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_RProductTypeBinds {

	// init
	static RProductTypeBinds init({required int productTypeId, required int productId}) {
		return new RProductTypeBinds(productTypeId: productTypeId, productId: productId);
	}

	// load all rows in database
	static Future<List<RProductTypeBinds>> loadAll(Database db) {
		return db.query(RProductTypeBinds.TABLE_NAME)
			.then((it) => it.map((d) => RProductTypeBinds.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<RProductTypeBinds?> take(Database db, int productTypeId, int productId) async {
		final result = await db.query(RProductTypeBinds.TABLE_NAME, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [productTypeId, productId]);
		return result.isEmpty ? null : RProductTypeBinds.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<RProductTypeBinds> load(Database db, int productTypeId, int productId) async {
		final result = await take(db, productTypeId, productId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int productTypeId, int productId) {
		return take(db, productTypeId, productId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int productTypeId, int productId, void onResult(RProductTypeBinds? row)) async {
		final result = await take(db, productTypeId, productId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProductTypeBinds.TABLE_NAME, data, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [data[RProductTypeBinds.C_PRODUCT_TYPE_ID], data[RProductTypeBinds.C_PRODUCT_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProductTypeBinds.TABLE_NAME, data, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [data[RProductTypeBinds.C_PRODUCT_TYPE_ID], data[RProductTypeBinds.C_PRODUCT_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, RProductTypeBinds row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProductTypeBinds.TABLE_NAME, data, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [row.productTypeId, row.productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProductTypeBinds.TABLE_NAME, data, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [row.productTypeId, row.productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int productTypeId, required int productId, bool removeNull = false}) {
		return updateByMap(db, toMap(productTypeId: productTypeId, productId: productId), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, RProductTypeBinds row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(RProductTypeBinds.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypeBinds.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int productTypeId, required int productId, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [productTypeId, productId]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		RProductTypeBinds.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(RProductTypeBinds.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypeBinds.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(RProductTypeBinds.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProductTypeBinds.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int productTypeId, int productId) {
		if (db is Batch) {
			 db.delete(RProductTypeBinds.TABLE_NAME, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [productTypeId, productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProductTypeBinds.TABLE_NAME, where: "${RProductTypeBinds.C_PRODUCT_TYPE_ID} = ? AND ${RProductTypeBinds.C_PRODUCT_ID} = ?", whereArgs: [productTypeId, productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, RProductTypeBinds row) {
		if (db is Batch) {
			db.insert(RProductTypeBinds.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypeBinds.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int productTypeId, required int productId}) {
		return insertRowTry(db, toRowFromList(values: [productTypeId, productId]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, RProductTypeBinds row) {
		if (db is Batch) {
			db.insert(RProductTypeBinds.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProductTypeBinds.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int productTypeId, required int productId}) {
		return insertRow(db, toRowFromList(values: [productTypeId, productId]));
	}

	// to map
	static Map<String, dynamic> toMap({RProductTypeBinds? row, String? f1, String? f2, int? productTypeId, int? productId}) {
		productTypeId = nvl(row?.productTypeId, productTypeId);
		productId = nvl(row?.productId, productId);
		RProductTypeBinds.checkPrimaryKeys(productTypeId, productId);
		return {nvlString(f1, RProductTypeBinds.C_PRODUCT_TYPE_ID): productTypeId, nvlString(f2, RProductTypeBinds.C_PRODUCT_ID): productId};
	}

	// to list
	static List<dynamic> toList({RProductTypeBinds? row, int? productTypeId, int? productId}) {
		productTypeId = nvl(row?.productTypeId, productTypeId);
		productId = nvl(row?.productId, productId);
		RProductTypeBinds.checkPrimaryKeys(productTypeId, productId);
		return [productTypeId, productId];
	}

	// to row from map
	static RProductTypeBinds toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, int? productTypeId, int? productId}) {
		productTypeId = nvl(data == null ? null : data[nvl(f1, RProductTypeBinds.C_PRODUCT_TYPE_ID)], productTypeId);
		productId = nvl(data == null ? null : data[nvl(f2, RProductTypeBinds.C_PRODUCT_ID)], productId);
		RProductTypeBinds.checkRequired(productTypeId, productId);
		return new RProductTypeBinds(productTypeId: productTypeId!, productId: productId!);
	}

	// to row from list
	static RProductTypeBinds toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2}) {
		final productTypeId = values[keys?.indexOf(nvl(f1, RProductTypeBinds.C_PRODUCT_TYPE_ID)) ?? 0];
		final productId = values[keys?.indexOf(nvl(f2, RProductTypeBinds.C_PRODUCT_ID)) ?? 1];
		RProductTypeBinds.checkRequired(productTypeId, productId);
		return new RProductTypeBinds(productTypeId: productTypeId, productId: productId);
	}

	// to row from list strings
	static RProductTypeBinds toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2}) {
		dynamic productTypeId = values[keys?.indexOf(nvl(f1, RProductTypeBinds.C_PRODUCT_TYPE_ID)) ?? 0];
		dynamic productId = values[keys?.indexOf(nvl(f2, RProductTypeBinds.C_PRODUCT_ID)) ?? 1];
		productTypeId = productTypeId is String && productTypeId.isNotEmpty ? num.parse(productTypeId) : null;
		productId = productId is String && productId.isNotEmpty ? num.parse(productId) : null;
		RProductTypeBinds.checkRequired(productTypeId, productId);
		return new RProductTypeBinds(productTypeId: productTypeId, productId: productId);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			RProductTypeBinds.C_PRODUCT_TYPE_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			RProductTypeBinds.C_PRODUCT_ID: values.length > 1 ? nvlTryInt(values[1]) : null
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