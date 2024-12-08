import 'package:flutter/material.dart';

class SeatCard extends StatelessWidget {
  final String numberTitle;
  final bool isOccupied;
  final double? orderTotal;
  final VoidCallback? onTap;

  const SeatCard({
    super.key,
    required this.numberTitle,
    this.isOccupied = false,
    this.orderTotal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      color: isOccupied ? Colors.red.shade50 : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chair,
              size: 32,
              color: isOccupied ? Colors.red : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              numberTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (isOccupied && orderTotal != null) ...[
              const SizedBox(height: 4),
              Text(
                '\$${orderTotal!.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
