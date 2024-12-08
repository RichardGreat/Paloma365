import 'package:flutter/material.dart';
import 'package:paloma365/kernel/bean/order_history.dart';
import 'package:paloma365/kernel/bean/order_pref.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderHistory order;

  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        leading: CircleAvatar(
          backgroundColor:
              order.status == OrderPref.ORDER_STATUS_COMPLETE ? Colors.blue : Colors.green,
          child: Text(
            order.seatNumber.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text('Table ${order.seatNumber}'),
        subtitle: Text(
          'Order Time: ${order.orderDate}\n'
          'Status: ${order.status}',
        ),
        trailing: Text(
          '\$${order.total.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: order.status == OrderPref.ORDER_STATUS_COMPLETE ? Colors.blue : Colors.green,
              ),
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Items:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.quantity}x ${item.productName}'),
                            Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                          ],
                        ),
                      )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total: \$${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} - '
        '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
