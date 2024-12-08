// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class COrders {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "c_orders";
	// ignore: non_constant_identifier_names
	static const String C_ORDER_ID = "order_id";
	// ignore: non_constant_identifier_names
	static const String C_ORDER_DATE = "order_date";
	// ignore: non_constant_identifier_names
	static const String C_SEAT_ID = "seat_id";
	// ignore: non_constant_identifier_names
	static const String C_STATUS = "status";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table c_orders (
	  order_id            int not null,
	  order_date          text not null,
	  seat_id             int not null,
	  status              text not null, 
	 constraint c_orders_pk primary key (order_id)
	 constraint c_orders_f1 foreign key (seat_id) references r_seats(seat_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? orderId, String? orderDate, int? seatId, String? status) {
		ArgumentError.checkNotNull(orderId, C_ORDER_ID);
		ArgumentError.checkNotNull(orderDate, C_ORDER_DATE);
		ArgumentError.checkNotNull(seatId, C_SEAT_ID);
		ArgumentError.checkNotNull(status, C_STATUS);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_ORDER_ID], C_ORDER_ID);
		ArgumentError.checkNotNull(data[C_ORDER_DATE], C_ORDER_DATE);
		ArgumentError.checkNotNull(data[C_SEAT_ID], C_SEAT_ID);
		ArgumentError.checkNotNull(data[C_STATUS], C_STATUS);
	}

	static void checkPrimaryKeys(int? orderId) {
		ArgumentError.checkNotNull(orderId, C_ORDER_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int orderId;
	final String orderDate;
	final int seatId;
	final String status;

	COrders({required this.orderId, required this.orderDate, required this.seatId, required this.status});

	factory COrders.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_ORDER_ID]);
		return COrders(
			orderId: data[C_ORDER_ID],
			orderDate: data[C_ORDER_DATE],
			seatId: data[C_SEAT_ID],
			status: data[C_STATUS],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_ORDER_ID: this.orderId,
			C_ORDER_DATE: this.orderDate,
			C_SEAT_ID: this.seatId,
			C_STATUS: this.status,
		};
	}

	@override
	String toString() {
		 return "COrders($C_ORDER_ID:$orderId, $C_ORDER_DATE:$orderDate, $C_SEAT_ID:$seatId, $C_STATUS:$status)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_COrders {

	// init
	static COrders init({required int orderId, required String orderDate, required int seatId, required String status}) {
		return new COrders(orderId: orderId, orderDate: orderDate, seatId: seatId, status: status);
	}

	// load all rows in database
	static Future<List<COrders>> loadAll(Database db) {
		return db.query(COrders.TABLE_NAME)
			.then((it) => it.map((d) => COrders.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<COrders?> take(Database db, int orderId) async {
		final result = await db.query(COrders.TABLE_NAME, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [orderId]);
		return result.isEmpty ? null : COrders.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<COrders> load(Database db, int orderId) async {
		final result = await take(db, orderId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int orderId) {
		return take(db, orderId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int orderId, void onResult(COrders? row)) async {
		final result = await take(db, orderId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(COrders.TABLE_NAME, data, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [data[COrders.C_ORDER_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(COrders.TABLE_NAME, data, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [data[COrders.C_ORDER_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, COrders row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(COrders.TABLE_NAME, data, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [row.orderId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(COrders.TABLE_NAME, data, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [row.orderId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int orderId, String? orderDate, int? seatId, String? status, bool removeNull = false}) {
		return updateByMap(db, toMap(orderId: orderId, orderDate: orderDate, seatId: seatId, status: status), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, COrders row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(COrders.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrders.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int orderId, required String orderDate, required int seatId, required String status, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [orderId, orderDate, seatId, status]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		COrders.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(COrders.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrders.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(COrders.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(COrders.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int orderId) {
		if (db is Batch) {
			 db.delete(COrders.TABLE_NAME, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [orderId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(COrders.TABLE_NAME, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [orderId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, COrders row) {
		if (db is Batch) {
			db.insert(COrders.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrders.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int orderId, required String orderDate, required int seatId, required String status}) {
		return insertRowTry(db, toRowFromList(values: [orderId, orderDate, seatId, status]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, COrders row) {
		if (db is Batch) {
			db.insert(COrders.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(COrders.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int orderId, required String orderDate, required int seatId, required String status}) {
		return insertRow(db, toRowFromList(values: [orderId, orderDate, seatId, status]));
	}

	// to map
	static Map<String, dynamic> toMap({COrders? row, String? f1, String? f2, String? f3, String? f4, int? orderId, String? orderDate, int? seatId, String? status}) {
		orderId = nvl(row?.orderId, orderId);
		orderDate = nvl(row?.orderDate, orderDate);
		seatId = nvl(row?.seatId, seatId);
		status = nvl(row?.status, status);
		COrders.checkPrimaryKeys(orderId);
		return {nvlString(f1, COrders.C_ORDER_ID): orderId, nvlString(f2, COrders.C_ORDER_DATE): orderDate, nvlString(f3, COrders.C_SEAT_ID): seatId, nvlString(f4, COrders.C_STATUS): status};
	}

	// to list
	static List<dynamic> toList({COrders? row, int? orderId, String? orderDate, int? seatId, String? status}) {
		orderId = nvl(row?.orderId, orderId);
		orderDate = nvl(row?.orderDate, orderDate);
		seatId = nvl(row?.seatId, seatId);
		status = nvl(row?.status, status);
		COrders.checkPrimaryKeys(orderId);
		return [orderId, orderDate, seatId, status];
	}

	// to row from map
	static COrders toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, String? f3, String? f4, int? orderId, String? orderDate, int? seatId, String? status}) {
		orderId = nvl(data == null ? null : data[nvl(f1, COrders.C_ORDER_ID)], orderId);
		orderDate = nvl(data == null ? null : data[nvl(f2, COrders.C_ORDER_DATE)], orderDate);
		seatId = nvl(data == null ? null : data[nvl(f3, COrders.C_SEAT_ID)], seatId);
		status = nvl(data == null ? null : data[nvl(f4, COrders.C_STATUS)], status);
		COrders.checkRequired(orderId, orderDate, seatId, status);
		return new COrders(orderId: orderId!, orderDate: orderDate!, seatId: seatId!, status: status!);
	}

	// to row from list
	static COrders toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2, String? f3, String? f4}) {
		final orderId = values[keys?.indexOf(nvl(f1, COrders.C_ORDER_ID)) ?? 0];
		final orderDate = values[keys?.indexOf(nvl(f2, COrders.C_ORDER_DATE)) ?? 1];
		final seatId = values[keys?.indexOf(nvl(f3, COrders.C_SEAT_ID)) ?? 2];
		final status = values[keys?.indexOf(nvl(f4, COrders.C_STATUS)) ?? 3];
		COrders.checkRequired(orderId, orderDate, seatId, status);
		return new COrders(orderId: orderId, orderDate: orderDate, seatId: seatId, status: status);
	}

	// to row from list strings
	static COrders toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2, String? f3, String? f4}) {
		dynamic orderId = values[keys?.indexOf(nvl(f1, COrders.C_ORDER_ID)) ?? 0];
		dynamic orderDate = values[keys?.indexOf(nvl(f2, COrders.C_ORDER_DATE)) ?? 1];
		dynamic seatId = values[keys?.indexOf(nvl(f3, COrders.C_SEAT_ID)) ?? 2];
		dynamic status = values[keys?.indexOf(nvl(f4, COrders.C_STATUS)) ?? 3];
		orderId = orderId is String && orderId.isNotEmpty ? num.parse(orderId) : null;
		seatId = seatId is String && seatId.isNotEmpty ? num.parse(seatId) : null;
		COrders.checkRequired(orderId, orderDate, seatId, status);
		return new COrders(orderId: orderId, orderDate: orderDate, seatId: seatId, status: status);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			COrders.C_ORDER_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			COrders.C_ORDER_DATE: values.length > 1 ? nvl(values[1], null) : null,
			COrders.C_SEAT_ID: values.length > 2 ? nvlTryInt(values[2]) : null,
			COrders.C_STATUS: values.length > 3 ? nvl(values[3], null) : null
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