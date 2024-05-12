import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/pages/home_page.dart';
import 'package:sushi_app/provider/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.fromhome,
  });

  final bool fromhome;

  @override
  Widget build(BuildContext context) {
    double price = 0;
    double totalPrice = 0;
    double taxAndService = 0;
    double totalPayment = 0;
    return Consumer<Cart>(
      builder: (context, value, child) {
        for (var cartModel in value.cart) {
          price = int.parse(cartModel.quantity.toString()) *
              int.parse(cartModel.price.toString()).toDouble();
          totalPrice += double.parse(price.toString());
          taxAndService = (totalPrice * 0.11).toDouble();
          totalPayment = totalPrice + taxAndService.toDouble();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: value.cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cart is empty',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const Text(
                          "Looks like you haven't added anything to your cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CupertinoButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (!fromhome) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Order some food',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.cart.length,
                      itemBuilder: (context, index) {
                        final food = value.cart[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                food.imagePath.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            food.name.toString(),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                food.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(' x '),
                              Text('${food.price} IDR'),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Delete food from cart',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Are you sure to remove ${food.name} from cart?',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                elevation: 0,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  value.removeFromCart(food);
                                                  if (value.cart.isEmpty) {
                                                    price = 0;
                                                    totalPrice = 0;
                                                    taxAndService = 0;
                                                    totalPayment = 0;
                                                  } else {
                                                    context.read<Cart>();
                                                  }
                                                },
                                                child: const Text(
                                                  'Yes, sure',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    // actions: [
                                    //   Expanded(
                                    //     child: FloatingActionButton(
                                    //       backgroundColor: const Color.fromARGB(
                                    //           109, 140, 94, 91),
                                    //       elevation: 0,
                                    //       onPressed: () {},
                                    //       child: const Text(
                                    //         'Cancel',
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   Expanded(
                                    //     child: FloatingActionButton(
                                    //       backgroundColor: const Color.fromARGB(
                                    //           109, 140, 94, 91),
                                    //       elevation: 0,
                                    //       onPressed: () {},
                                    //       child: const Text(
                                    //         'Cancel',
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ],
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              CupertinoIcons.minus_circle,
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        if (!fromhome) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add more food',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: value.cart.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Price'),
                                Text(
                                  'IDR $totalPrice',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tax and Service'),
                                Text(
                                  'IDR $taxAndService',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'IDR $totalPayment',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        color: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(20),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: () {
                          // addToCart();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
