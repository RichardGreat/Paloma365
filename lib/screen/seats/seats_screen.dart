import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/seats/bloc.dart';
import 'package:paloma365/bloc/seats/event.dart';
import 'package:paloma365/bloc/seats/state.dart';
import 'package:paloma365/screen/order/order.dart';
import 'package:paloma365/widgets/seat_card.dart';

class SeatsScreen extends StatelessWidget {
  const SeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Seats'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<SeatBloc, SeatState>(
        builder: (context, state) {
          if (state is SeatLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = (constraints.maxWidth / 120).floor();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount >= 3 ? crossAxisCount : 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: state.seats.length,
                    itemBuilder: (context, index) {
                      final seat = state.seats[index];
                      return SeatCard(
                        numberTitle: 'Table ${seat.number}',
                        isOccupied: seat.isOccupied,
                        orderTotal: seat.totalAmount,
                        onTap: () async {
                          final Map<String, dynamic> data = {
                            "order_id": seat.orderId,
                            "seat_id": seat.id,
                          };
                          await Navigator.pushNamed(context, OrderScreen.routeName,
                              arguments: data);

                          context.read<SeatBloc>().add(LoadSeats());
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
