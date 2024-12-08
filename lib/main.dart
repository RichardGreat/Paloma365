import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/history/bloc.dart';
import 'package:paloma365/bloc/seats/bloc.dart';
import 'package:paloma365/kernel/database.dart';
import 'package:paloma365/repository/history/history_repository.dart';
import 'package:paloma365/repository/seat/seats_repository.dart';
import 'package:paloma365/screen/main/main_screen.dart';
import 'package:paloma365/screen/order/order.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHolder.newInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Database get database => DatabaseHolder.getInstance().getDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SeatBloc(repository: SeatsRepository(database))),
        BlocProvider(create: (context) => HistoryBloc(repository: HistoryRepository(database))),
      ],
      child: MaterialApp(
        title: 'Restaurant Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        home: const MainScreen(),
        onGenerateRoute: (settings) {
          // Handle named routes with arguments
          switch (settings.name) {
            case '/order':
              // Extract arguments
              final args = settings.arguments as Map<String, dynamic>?;
              final orderId = args?['order_Id'] as int?;
              final seatId = args?['seat_id'] as int;

              return MaterialPageRoute(
                  builder: (context) => OrderScreen(orderId: orderId, seatId: seatId));
            default:
              return MaterialPageRoute(builder: (context) => const MainScreen());
          }
        },
      ),
    );
  }
}
