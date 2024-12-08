import 'package:sqflite/sqflite.dart';

class DatabaseSeed {
  final Batch batch;

  DatabaseSeed(this.batch);

  void seedDatabase() {
    batch.delete('r_seats');
    batch.delete('r_products');
    batch.delete('r_product_types');
    batch.delete('r_product_type_binds');

    final seats = [
      {'seat_id': 1, 'seat_number': 101},
      {'seat_id': 2, 'seat_number': 102},
      {'seat_id': 3, 'seat_number': 103},
      {'seat_id': 4, 'seat_number': 201},
      {'seat_id': 5, 'seat_number': 202},
      {'seat_id': 6, 'seat_number': 203},
      {'seat_id': 7, 'seat_number': 301},
      {'seat_id': 8, 'seat_number': 302},
      {'seat_id': 9, 'seat_number': 303},
    ];

    for (var seat in seats) {
      batch.insert('r_seats', seat);
    }

    // Insert product types
    final productTypes = [
      {'product_type_id': 1, 'name': 'Hot Drinks'},
      {'product_type_id': 2, 'name': 'Cold Drinks'},
      {'product_type_id': 3, 'name': 'Main Course'},
      {'product_type_id': 4, 'name': 'Desserts'},
      {'product_type_id': 5, 'name': 'Appetizers'},
    ];

    for (var type in productTypes) {
      batch.insert('r_product_types', type);
    }

    final products = [
      // Hot Drinks
      {'product_id': 1, 'name': 'Espresso', 'price': 2.50},
      {'product_id': 2, 'name': 'Cappuccino', 'price': 3.50},
      {'product_id': 3, 'name': 'Latte', 'price': 3.75},
      {'product_id': 4, 'name': 'Green Tea', 'price': 2.00},

      // Cold Drinks
      {'product_id': 5, 'name': 'Iced Coffee', 'price': 3.25},
      {'product_id': 6, 'name': 'Lemonade', 'price': 2.50},
      {'product_id': 7, 'name': 'Cola', 'price': 2.00},
      {'product_id': 8, 'name': 'Mineral Water', 'price': 1.50},

      // Main Course
      {'product_id': 9, 'name': 'Beef Steak', 'price': 25.00},
      {'product_id': 10, 'name': 'Grilled Salmon', 'price': 22.00},
      {'product_id': 11, 'name': 'Chicken Pasta', 'price': 18.00},
      {'product_id': 12, 'name': 'Vegetarian Pizza', 'price': 16.00},

      // Desserts
      {'product_id': 13, 'name': 'Chocolate Cake', 'price': 6.50},
      {'product_id': 14, 'name': 'Ice Cream', 'price': 4.50},
      {'product_id': 15, 'name': 'Apple Pie', 'price': 5.50},
      {'product_id': 16, 'name': 'Cheesecake', 'price': 6.00},

      // Appetizers
      {'product_id': 17, 'name': 'Caesar Salad', 'price': 8.50},
      {'product_id': 18, 'name': 'Soup of the Day', 'price': 6.00},
      {'product_id': 19, 'name': 'Garlic Bread', 'price': 4.00},
      {'product_id': 20, 'name': 'Bruschetta', 'price': 5.50},
    ];

    for (var product in products) {
      batch.insert('r_products', product);
    }

    // Insert product type bindings
    final productTypeBinds = [
      // Hot Drinks
      {'product_type_id': 1, 'product_id': 1},
      {'product_type_id': 1, 'product_id': 2},
      {'product_type_id': 1, 'product_id': 3},
      {'product_type_id': 1, 'product_id': 4},

      // Cold Drinks
      {'product_type_id': 2, 'product_id': 5},
      {'product_type_id': 2, 'product_id': 6},
      {'product_type_id': 2, 'product_id': 7},
      {'product_type_id': 2, 'product_id': 8},

      // Main Course
      {'product_type_id': 3, 'product_id': 9},
      {'product_type_id': 3, 'product_id': 10},
      {'product_type_id': 3, 'product_id': 11},
      {'product_type_id': 3, 'product_id': 12},

      // Desserts
      {'product_type_id': 4, 'product_id': 13},
      {'product_type_id': 4, 'product_id': 14},
      {'product_type_id': 4, 'product_id': 15},
      {'product_type_id': 4, 'product_id': 16},

      // Appetizers
      {'product_type_id': 5, 'product_id': 17},
      {'product_type_id': 5, 'product_id': 18},
      {'product_type_id': 5, 'product_id': 19},
      {'product_type_id': 5, 'product_id': 20},
    ];

    for (var bind in productTypeBinds) {
      batch.insert('r_product_type_binds', bind);
    }
  }
}
