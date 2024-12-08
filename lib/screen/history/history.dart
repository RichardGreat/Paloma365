import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/history/bloc.dart';
import 'package:paloma365/bloc/history/state.dart';
import 'package:paloma365/widgets/order_history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadSuccess) {
            if (state.orders.isEmpty) {
              return const Center(
                child: Text('No orders in history'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderHistoryCard(order: order);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
