import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/pages/cart_pages.dart';
import 'package:sushi_app/provider/cart.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int quantityCount = 0;
  int costPayment = 0;

  void incrementQuantity() {
    setState(() {
      quantityCount++;
      costPayment = quantityCount * int.parse(widget.food.price.toString());
    });
  }

  void decrementQuantiry() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
        costPayment = quantityCount * int.parse(widget.food.price.toString());
      }
    });
  }

  void addToCart() {
    if (quantityCount > 0) {
      final cart = context.read<Cart>();
      cart.addToCart(widget.food, quantityCount);
      bottomSheet();
    }
  }

  void bottomSheet() {
    setState(() {
      quantityCount = 0;
      costPayment = 0;
    });

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Food was added to cart',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.food.name} was added to cart, would you like to add some food?',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FloatingActionButton(
                        heroTag: 'goToCart',
                        backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                        elevation: 0,
                        onPressed: () {
                          Navigator.pop(context);
                          goToCart();
                        },
                        child: const Text(
                          'View cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FloatingActionButton(
                        heroTag: 'pop',
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sure',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartPage(
          fromhome: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {
                        goToCart();
                      },
                      icon: const Icon(
                        CupertinoIcons.cart,
                      ),
                    ),
                    Visibility(
                      visible: value.cart.isEmpty ? false : true,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10.0,
                        child: Text(
                          value.cart.length.toString(),
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Container(
            height: 80,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: 'q',
                  backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                  elevation: 0,
                  onPressed: () {
                    incrementQuantity();
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'w',
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {},
                  child: Text(
                    quantityCount.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'r',
                  backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                  elevation: 0,
                  onPressed: () {
                    decrementQuantiry();
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FloatingActionButton(
                    heroTag: 't',
                    backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                    elevation: 0,
                    onPressed: () {
                      addToCart();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'IDR $costPayment',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Add to cart',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    widget.food.imagePath.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name.toString(),
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                          ),
                          Text(
                            '${widget.food.price} IDR',
                            style: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.heart),
                    ],
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: double.parse(widget.food.rating.toString()),
                        minRating: 1,
                        maxRating: 5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.food.rating.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.food.description.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ReadMoreText(
                  //   widget.food.description.toString(),
                  //   trimMode: TrimMode.Line,
                  //   trimLines: 10,
                  //   colorClickableText: Colors.black,
                  //   trimCollapsedText: 'Show more',
                  //   trimExpandedText: 'Show less',
                  //   moreStyle: const TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
