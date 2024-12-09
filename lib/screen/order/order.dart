import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/order/bloc.dart';
import 'package:paloma365/bloc/order/event.dart';
import 'package:paloma365/bloc/order/state.dart';
import 'package:paloma365/kernel/bean/product.dart';
import 'package:paloma365/kernel/database.dart';
import 'package:paloma365/repository/order/order_repository.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order";
  final int? orderId;
  final int seatId;

  const OrderScreen({
    super.key,
    this.orderId,
    required this.seatId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = OrderRepository(DatabaseHolder.getInstance().getDatabase());

        return OrderBloc(repository: repository)
          ..add(LoadProducts(orderId: orderId, seatId: seatId));
      },
      child: OrderScreenContent(),
    );
  }
}

class OrderScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const ProductTypeSelector(),
          const Expanded(child: ProductGrid()),
          OrderTotalBar(mainContext: context),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onChanged: (value) {
          context.read<OrderBloc>().add(SearchProducts(value));
        },
      ),
    );
  }
}

class ProductTypeSelector extends StatelessWidget {
  const ProductTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadSuccess) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 50,
              child: CupertinoSegmentedControl<int>(
                children: {
                  for (final type in state.productTypes)
                    type.id: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(type.name, textAlign: TextAlign.center),
                    ),
                },
                groupValue: state.selectedTypeId,
                onValueChanged: (value) {
                  context.read<OrderBloc>().add(FilterProductsByType(value));
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.filteredProducts.length,
            itemBuilder: (context, index) {
              final product = state.filteredProducts[index];
              return ProductCard(product: product);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              product.name[0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '\$${product.price.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: product.quantity > 0
                    ? () {
                        context.read<OrderBloc>().add(
                              UpdateProductQuantity(
                                product.id,
                                product.quantity - 1,
                              ),
                            );
                      }
                    : null,
              ),
              Text(
                product.quantity.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  context.read<OrderBloc>().add(
                        UpdateProductQuantity(
                          product.id,
                          product.quantity + 1,
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderTotalBar extends StatelessWidget {
  final BuildContext mainContext;

  const OrderTotalBar({super.key, required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadSuccess) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Items:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        state.totalQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      '\$${state.totalAmount.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Service Fee (15%):',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      '\$${state.serviceFee.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.isNew())
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.totalQuantity > 0
                          ? () {
                              context.read<OrderBloc>().add(SaveOrder());
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.totalQuantity > 0
                                ? () {
                                    context.read<OrderBloc>().add(SaveOrder());
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Update Order',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.totalQuantity > 0
                                ? () {
                                    context.read<OrderBloc>().add(CompleteOrder());
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Complete',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
      listener: (BuildContext context, OrderState state) {
        if (state is OrderSaved) {
          Navigator.pop(mainContext);
        }
      },
    );
  }
}
