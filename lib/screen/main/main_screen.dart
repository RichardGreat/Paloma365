import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/history/bloc.dart';
import 'package:paloma365/bloc/history/event.dart';
import 'package:paloma365/screen/history/history.dart';
import 'package:paloma365/screen/seats/seats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SeatsScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            // Get the HistoryBloc instance and trigger refresh
            final historyBloc = context.read<HistoryBloc>();
            historyBloc.add(LoadHistory());
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chair),
            label: 'Seats',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
