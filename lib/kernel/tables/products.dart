// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class RProducts {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "r_products";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCT_ID = "product_id";
	// ignore: non_constant_identifier_names
	static const String C_NAME = "name";
	// ignore: non_constant_identifier_names
	static const String C_PRICE = "price";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table r_products (
	  product_id        int not null,
	  name              text not null,
	  price             real not null,
	 constraint r_products_pk primary key (product_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? productId, String? name, num? price) {
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
		ArgumentError.checkNotNull(name, C_NAME);
		ArgumentError.checkNotNull(price, C_PRICE);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_PRODUCT_ID], C_PRODUCT_ID);
		ArgumentError.checkNotNull(data[C_NAME], C_NAME);
		ArgumentError.checkNotNull(data[C_PRICE], C_PRICE);
	}

	static void checkPrimaryKeys(int? productId) {
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int productId;
	final String name;
	final num price;

	RProducts({required this.productId, required this.name, required this.price});

	factory RProducts.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_PRODUCT_ID]);
		return RProducts(
			productId: data[C_PRODUCT_ID],
			name: data[C_NAME],
			price: data[C_PRICE],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_PRODUCT_ID: this.productId,
			C_NAME: this.name,
			C_PRICE: this.price,
		};
	}

	@override
	String toString() {
		 return "RProducts($C_PRODUCT_ID:$productId, $C_NAME:$name, $C_PRICE:$price)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_RProducts {

	// init
	static RProducts init({required int productId, required String name, required num price}) {
		return new RProducts(productId: productId, name: name, price: price);
	}

	// load all rows in database
	static Future<List<RProducts>> loadAll(Database db) {
		return db.query(RProducts.TABLE_NAME)
			.then((it) => it.map((d) => RProducts.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<RProducts?> take(Database db, int productId) async {
		final result = await db.query(RProducts.TABLE_NAME, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [productId]);
		return result.isEmpty ? null : RProducts.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<RProducts> load(Database db, int productId) async {
		final result = await take(db, productId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int productId) {
		return take(db, productId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int productId, void onResult(RProducts? row)) async {
		final result = await take(db, productId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProducts.TABLE_NAME, data, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [data[RProducts.C_PRODUCT_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProducts.TABLE_NAME, data, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [data[RProducts.C_PRODUCT_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, RProducts row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RProducts.TABLE_NAME, data, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [row.productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RProducts.TABLE_NAME, data, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [row.productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int productId, String? name, num? price, bool removeNull = false}) {
		return updateByMap(db, toMap(productId: productId, name: name, price: price), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, RProducts row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(RProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int productId, required String name, required num price, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [productId, name, price]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		RProducts.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(RProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(RProducts.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProducts.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int productId) {
		if (db is Batch) {
			 db.delete(RProducts.TABLE_NAME, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RProducts.TABLE_NAME, where: "${RProducts.C_PRODUCT_ID} = ?", whereArgs: [productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, RProducts row) {
		if (db is Batch) {
			db.insert(RProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int productId, required String name, required num price}) {
		return insertRowTry(db, toRowFromList(values: [productId, name, price]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, RProducts row) {
		if (db is Batch) {
			db.insert(RProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int productId, required String name, required num price}) {
		return insertRow(db, toRowFromList(values: [productId, name, price]));
	}

	// to map
	static Map<String, dynamic> toMap({RProducts? row, String? f1, String? f2, String? f3, int? productId, String? name, num? price}) {
		productId = nvl(row?.productId, productId);
		name = nvl(row?.name, name);
		price = nvl(row?.price, price);
		RProducts.checkPrimaryKeys(productId);
		return {nvlString(f1, RProducts.C_PRODUCT_ID): productId, nvlString(f2, RProducts.C_NAME): name, nvlString(f3, RProducts.C_PRICE): price};
	}

	// to list
	static List<dynamic> toList({RProducts? row, int? productId, String? name, num? price}) {
		productId = nvl(row?.productId, productId);
		name = nvl(row?.name, name);
		price = nvl(row?.price, price);
		RProducts.checkPrimaryKeys(productId);
		return [productId, name, price];
	}

	// to row from map
	static RProducts toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, String? f3, int? productId, String? name, num? price}) {
		productId = nvl(data == null ? null : data[nvl(f1, RProducts.C_PRODUCT_ID)], productId);
		name = nvl(data == null ? null : data[nvl(f2, RProducts.C_NAME)], name);
		price = nvl(data == null ? null : data[nvl(f3, RProducts.C_PRICE)], price);
		RProducts.checkRequired(productId, name, price);
		return new RProducts(productId: productId!, name: name!, price: price!);
	}

	// to row from list
	static RProducts toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2, String? f3}) {
		final productId = values[keys?.indexOf(nvl(f1, RProducts.C_PRODUCT_ID)) ?? 0];
		final name = values[keys?.indexOf(nvl(f2, RProducts.C_NAME)) ?? 1];
		final price = values[keys?.indexOf(nvl(f3, RProducts.C_PRICE)) ?? 2];
		RProducts.checkRequired(productId, name, price);
		return new RProducts(productId: productId, name: name, price: price);
	}

	// to row from list strings
	static RProducts toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2, String? f3}) {
		dynamic productId = values[keys?.indexOf(nvl(f1, RProducts.C_PRODUCT_ID)) ?? 0];
		dynamic name = values[keys?.indexOf(nvl(f2, RProducts.C_NAME)) ?? 1];
		dynamic price = values[keys?.indexOf(nvl(f3, RProducts.C_PRICE)) ?? 2];
		productId = productId is String && productId.isNotEmpty ? num.parse(productId) : null;
		price = price is String && price.isNotEmpty ? num.parse(price) : null;
		RProducts.checkRequired(productId, name, price);
		return new RProducts(productId: productId, name: name, price: price);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			RProducts.C_PRODUCT_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			RProducts.C_NAME: values.length > 1 ? nvl(values[1], null) : null,
			RProducts.C_PRICE: values.length > 2 ? nvlTryNum(values[2]) : null
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