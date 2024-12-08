// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class RSeats {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "r_seats";
	// ignore: non_constant_identifier_names
	static const String C_SEAT_ID = "seat_id";
	// ignore: non_constant_identifier_names
	static const String C_SEAT_NUMBER = "seat_number";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table r_seats (
	  seat_id           int not null,
	  seat_number       int not null,
	 constraint r_seats_pk primary key (seat_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int? seatId, int? seatNumber) {
		ArgumentError.checkNotNull(seatId, C_SEAT_ID);
		ArgumentError.checkNotNull(seatNumber, C_SEAT_NUMBER);
	}

	static void checkRequiredByMap(Map<String, dynamic> data) {
		ArgumentError.checkNotNull(data[C_SEAT_ID], C_SEAT_ID);
		ArgumentError.checkNotNull(data[C_SEAT_NUMBER], C_SEAT_NUMBER);
	}

	static void checkPrimaryKeys(int? seatId) {
		ArgumentError.checkNotNull(seatId, C_SEAT_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int seatId;
	final int seatNumber;

	RSeats({required this.seatId, required this.seatNumber});

	factory RSeats.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_SEAT_ID]);
		return RSeats(
			seatId: data[C_SEAT_ID],
			seatNumber: data[C_SEAT_NUMBER],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_SEAT_ID: this.seatId,
			C_SEAT_NUMBER: this.seatNumber,
		};
	}

	@override
	String toString() {
		 return "RSeats($C_SEAT_ID:$seatId, $C_SEAT_NUMBER:$seatNumber)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_RSeats {

	// init
	static RSeats init({required int seatId, required int seatNumber}) {
		return new RSeats(seatId: seatId, seatNumber: seatNumber);
	}

	// load all rows in database
	static Future<List<RSeats>> loadAll(Database db) {
		return db.query(RSeats.TABLE_NAME)
			.then((it) => it.map((d) => RSeats.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<RSeats?> take(Database db, int seatId) async {
		final result = await db.query(RSeats.TABLE_NAME, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [seatId]);
		return result.isEmpty ? null : RSeats.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<RSeats> load(Database db, int seatId) async {
		final result = await take(db, seatId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int seatId) {
		return take(db, seatId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int seatId, void onResult(RSeats? row)) async {
		final result = await take(db, seatId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateByMap(dynamic db, Map<String, dynamic> data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RSeats.TABLE_NAME, data, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [data[RSeats.C_SEAT_ID]]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RSeats.TABLE_NAME, data, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [data[RSeats.C_SEAT_ID]]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update row
	static Future<int> updateRow(dynamic db, RSeats row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(RSeats.TABLE_NAME, data, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [row.seatId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(RSeats.TABLE_NAME, data, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [row.seatId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {required int seatId, int? seatNumber, bool removeNull = false}) {
		return updateByMap(db, toMap(seatId: seatId, seatNumber: seatNumber), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, RSeats row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(RSeats.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RSeats.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {required int seatId, required int seatNumber, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [seatId, seatNumber]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRowByMap(dynamic db, Map<String, dynamic>  data, {bool removeNull = false}) {
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		RSeats.checkRequiredByMap(data);
		if (db is Batch) {
			db.insert(RSeats.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RSeats.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(RSeats.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RSeats.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int seatId) {
		if (db is Batch) {
			 db.delete(RSeats.TABLE_NAME, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [seatId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(RSeats.TABLE_NAME, where: "${RSeats.C_SEAT_ID} = ?", whereArgs: [seatId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, RSeats row) {
		if (db is Batch) {
			db.insert(RSeats.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RSeats.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {required int seatId, required int seatNumber}) {
		return insertRowTry(db, toRowFromList(values: [seatId, seatNumber]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, RSeats row) {
		if (db is Batch) {
			db.insert(RSeats.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(RSeats.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {required int seatId, required int seatNumber}) {
		return insertRow(db, toRowFromList(values: [seatId, seatNumber]));
	}

	// to map
	static Map<String, dynamic> toMap({RSeats? row, String? f1, String? f2, int? seatId, int? seatNumber}) {
		seatId = nvl(row?.seatId, seatId);
		seatNumber = nvl(row?.seatNumber, seatNumber);
		RSeats.checkPrimaryKeys(seatId);
		return {nvlString(f1, RSeats.C_SEAT_ID): seatId, nvlString(f2, RSeats.C_SEAT_NUMBER): seatNumber};
	}

	// to list
	static List<dynamic> toList({RSeats? row, int? seatId, int? seatNumber}) {
		seatId = nvl(row?.seatId, seatId);
		seatNumber = nvl(row?.seatNumber, seatNumber);
		RSeats.checkPrimaryKeys(seatId);
		return [seatId, seatNumber];
	}

	// to row from map
	static RSeats toRowFromMap({Map<String, dynamic>? data, String? f1, String? f2, int? seatId, int? seatNumber}) {
		seatId = nvl(data == null ? null : data[nvl(f1, RSeats.C_SEAT_ID)], seatId);
		seatNumber = nvl(data == null ? null : data[nvl(f2, RSeats.C_SEAT_NUMBER)], seatNumber);
		RSeats.checkRequired(seatId, seatNumber);
		return new RSeats(seatId: seatId!, seatNumber: seatNumber!);
	}

	// to row from list
	static RSeats toRowFromList({required List<dynamic> values, List<String>? keys, String? f1, String? f2}) {
		final seatId = values[keys?.indexOf(nvl(f1, RSeats.C_SEAT_ID)) ?? 0];
		final seatNumber = values[keys?.indexOf(nvl(f2, RSeats.C_SEAT_NUMBER)) ?? 1];
		RSeats.checkRequired(seatId, seatNumber);
		return new RSeats(seatId: seatId, seatNumber: seatNumber);
	}

	// to row from list strings
	static RSeats toRowFromListString({required List<String> values, List<String>? keys, String? f1, String? f2}) {
		dynamic seatId = values[keys?.indexOf(nvl(f1, RSeats.C_SEAT_ID)) ?? 0];
		dynamic seatNumber = values[keys?.indexOf(nvl(f2, RSeats.C_SEAT_NUMBER)) ?? 1];
		seatId = seatId is String && seatId.isNotEmpty ? num.parse(seatId) : null;
		seatNumber = seatNumber is String && seatNumber.isNotEmpty ? num.parse(seatNumber) : null;
		RSeats.checkRequired(seatId, seatNumber);
		return new RSeats(seatId: seatId, seatNumber: seatNumber);
	}

	// to map from list strings
	static Map<String, dynamic> toMapFromListString({required List<String> values}) {
		return {
			RSeats.C_SEAT_ID: values.length > 0 ? nvlTryInt(values[0]) : null,
			RSeats.C_SEAT_NUMBER: values.length > 1 ? nvlTryInt(values[1]) : null
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