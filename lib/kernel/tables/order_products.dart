// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class COrderProducts {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "c_order_products";
	// ignore: non_constant_identifier_names
	static const String C_ORDER_ID = "order_id";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCT_ID = "product_id";
	// ignore: non_constant_identifier_names
	static const String C_PRICE = "price";
	// ignore: non_constant_identifier_names
	static const String C_QUANTITY = "quantity";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table c_order_products (
	  order_id               int not null,
	  product_id             int not null,
	  price                  real,
	  quantity               int,
	 constraint c_order_products_pk primary key (order_id, product_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? orderId, int? productId) {
		ArgumentError.checkNotNull(orderId, C_ORDER_ID);
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_ORDER_ID], C_ORDER_ID);
		ArgumentError.checkNotNull(data[C_PRODUCT_ID], C_PRODUCT_ID);
	}

	static void checkPrimaryKeys(int? orderId, int? productId) {
		ArgumentError.checkNotNull(orderId, C_ORDER_ID);
		ArgumentError.checkNotNull(productId, C_PRODUCT_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int orderId;
	final int productId;
	final num? price;
	final int? quantity;

	COrderProducts({required this.orderId, required this.productId, this.price, this.quantity});

	factory COrderProducts.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_ORDER_ID], data[C_PRODUCT_ID]);
		return COrderProducts(
			orderId: data[C_ORDER_ID],
			productId: data[C_PRODUCT_ID],
			price: data[C_PRICE],
			quantity: data[C_QUANTITY],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_ORDER_ID: this.orderId,
			C_PRODUCT_ID: this.productId,
			C_PRICE: this.price,
			C_QUANTITY: this.quantity,
		};
	}

	@override
	String toString() {
		 return "COrderProducts($C_ORDER_ID:$orderId, $C_PRODUCT_ID:$productId, $C_PRICE:$price, $C_QUANTITY:$quantity)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_COrderProducts {

	// init
	static COrderProducts init({required int orderId, required int productId, num? price, int? quantity}) {
		return new COrderProducts(orderId: orderId, productId: productId, price: price, quantity: quantity);
	}

	// load all rows in database
	static Future<List<COrderProducts>> loadAll(Database db) {
		return db.query(COrderProducts.TABLE_NAME)
			.then((it) => it.map((d) => COrderProducts.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<COrderProducts?> take(Database db, int orderId, int productId) async {
		final result = await db.query(COrderProducts.TABLE_NAME, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [orderId, productId]);
		return result.isEmpty ? null : COrderProducts.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<COrderProducts> load(Database db, int orderId, int productId) async {
		final result = await take(db, orderId, productId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int orderId, int productId) {
		return take(db, orderId, productId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int orderId, int productId, void onResult(COrderProducts? row)) async {
		final result = await take(db, orderId, productId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(COrderProducts.TABLE_NAME, data, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [data[COrderProducts.C_ORDER_ID], data[COrderProducts.C_PRODUCT_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(COrderProducts.TABLE_NAME, data, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [data[COrderProducts.C_ORDER_ID], data[COrderProducts.C_PRODUCT_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, COrderProducts row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(COrderProducts.TABLE_NAME, data, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [row.orderId, row.productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(COrderProducts.TABLE_NAME, data, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [row.orderId, row.productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int orderId, required int productId, num? price, int? quantity, bool removeNull = false}) {
		return updateByMap(db, toMap(orderId: orderId, productId: productId, price: price, quantity: quantity), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, COrderProducts row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(COrderProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrderProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int orderId, required int productId, num? price, int? quantity, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [orderId, productId, price, quantity]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		COrderProducts.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(COrderProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrderProducts.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(COrderProducts.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(COrderProducts.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int orderId, int productId) {
		if (db is Batch) {
			 db.delete(COrderProducts.TABLE_NAME, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [orderId, productId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(COrderProducts.TABLE_NAME, where: "${COrderProducts.C_ORDER_ID} = ? AND ${COrderProducts.C_PRODUCT_ID} = ?", whereArgs: [orderId, productId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, COrderProducts row) {
		if (db is Batch) {
			db.insert(COrderProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrderProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int orderId, required int productId, num? price, int? quantity}) {
		return insertRowTry(db, toRowFromList(values: [orderId, productId, price, quantity]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, COrderProducts row) {
		if (db is Batch) {
			db.insert(COrderProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrderProducts.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int orderId, required int productId, num? price, int? quantity}) {
		return insertRow(db, toRowFromList(values: [orderId, productId, price, quantity]));
	}

	// to map
	static Map<String, dynamic> toMap({COrderProducts? row, String? f1, String? f2, String? f3, String? f4, int? orderId, int? productId, num? price, int? quantity}) {
		orderId = nvl(row?.orderId, orderId);
		productId = nvl(row?.productId, productId);
		price = nvl(row?.price, price);
		quantity = nvl(row?.quantity, quantity);
		COrderProducts.checkPrimaryKeys(orderId, productId);
		return {nvlString(f1, COrderProducts.C_ORDER_ID): orderId, nvlString(f2, COrderProducts.C_PRODUCT_ID): productId, nvlString(f3, COrderProducts.C_PRICE): price, nvlString(f4, COrderProducts.C_QUANTITY): quantity};
	}

	// to list
	static List<dynamic> toList({COrderProducts? row, int? orderId, int? productId, num? price, int? quantity}) {
		orderId = nvl(row?.orderId, orderId);
		productId = nvl(row?.productId, productId);
		price = nvl(row?.price, price);
		quantity = nvl(row?.quantity, quantity);
		COrderProducts.checkPrimaryKeys(orderId, productId);
		return [orderId, productId, price, quantity];
	}

	// to row from map
	static COrderProducts toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, String? f3, String? f4, int? orderId, int? productId, num? price, int? quantity}) {
		orderId = nvl(data == null ? null : data[nvl(f1, COrderProducts.C_ORDER_ID)], orderId);
		productId = nvl(data == null ? null : data[nvl(f2, COrderProducts.C_PRODUCT_ID)], productId);
		price = nvl(data == null ? null : data[nvl(f3, COrderProducts.C_PRICE)], price);
		quantity = nvl(data == null ? null : data[nvl(f4, COrderProducts.C_QUANTITY)], quantity);
		COrderProducts.checkRequired(orderId, productId);
		return new COrderProducts(orderId: orderId!, productId: productId!, price: price, quantity: quantity);
	}

	// to row from list
	static COrderProducts toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2, String? f3, String? f4}) {
		final orderId = values[keys?.indexOf(nvl(f1, COrderProducts.C_ORDER_ID)) ?? 0];
		final productId = values[keys?.indexOf(nvl(f2, COrderProducts.C_PRODUCT_ID)) ?? 1];
		final price = values[keys?.indexOf(nvl(f3, COrderProducts.C_PRICE)) ?? 2];
		final quantity = values[keys?.indexOf(nvl(f4, COrderProducts.C_QUANTITY)) ?? 3];
		COrderProducts.checkRequired(orderId, productId);
		return new COrderProducts(orderId: orderId, productId: productId, price: price, quantity: quantity);
	}

	// to row from list strings
	static COrderProducts toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2, String? f3, String? f4}) {
		dynamic orderId = values[keys?.indexOf(nvl(f1, COrderProducts.C_ORDER_ID)) ?? 0];
		dynamic productId = values[keys?.indexOf(nvl(f2, COrderProducts.C_PRODUCT_ID)) ?? 1];
		dynamic price = values[keys?.indexOf(nvl(f3, COrderProducts.C_PRICE)) ?? 2];
		dynamic quantity = values[keys?.indexOf(nvl(f4, COrderProducts.C_QUANTITY)) ?? 3];
		orderId = orderId is String && orderId.isNotEmpty ? num.parse(orderId) : null;
		productId = productId is String && productId.isNotEmpty ? num.parse(productId) : null;
		price = price is String && price.isNotEmpty ? num.parse(price) : null;
		quantity = quantity is String && quantity.isNotEmpty ? num.parse(quantity) : null;
		COrderProducts.checkRequired(orderId, productId);
		return new COrderProducts(orderId: orderId, productId: productId, price: price, quantity: quantity);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			COrderProducts.C_ORDER_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			COrderProducts.C_PRODUCT_ID: values.length > 1 ? nvlTryInt(values[1]) : null,
			COrderProducts.C_PRICE: values.length > 2 ? nvlTryNum(values[2]) : null,
			COrderProducts.C_QUANTITY: values.length > 3 ? nvlTryInt(values[3]) : null
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