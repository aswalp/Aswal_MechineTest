import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/extension/extension.dart';
import 'package:project/providers/cartprovider.dart';
import 'package:project/widgets/emptycart.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int items = 0;
    var list = ref.watch(cartProvider).cartlist;

    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
              )),
          title: Text(
            "Order Summary",
            style: TextStyle(
                color: Colors.black54,
                fontSize: context.responsiveWidth(22),
                fontWeight: FontWeight.w500),
          ),
        ),
        body: list.isEmpty
            ? const EmptyCart()
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(context.responsiveWidth(20)),
                  padding: EdgeInsets.all(context.responsiveWidth(10)),
                  width: context.maxWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(1, 5))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.responsiveWidth(10)),
                        alignment: Alignment.center,
                        width: context.maxWidth(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[900],
                        ),
                        child: Text(
                          "${list.length} Dishes - ${ref.watch(totalItemProvider)} items",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: context.responsiveWidth(20)),
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          items = items + list[index].itemcount;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.crop_square_sharp,
                                    color: list[index].dishType == 2
                                        ? Colors.green
                                        : Colors.red,
                                    size: 24,
                                  ),
                                  Icon(Icons.circle,
                                      color: list[index].dishType == 2
                                          ? Colors.green
                                          : Colors.red,
                                      size: 10),
                                ],
                              ),
                              SizedBox(
                                width: context.responsiveWidth(5),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].dishName!,
                                      style: TextStyle(
                                          fontSize: context.responsiveWidth(18),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: context.responsiveWidth(8),
                                    ),
                                    Text(
                                      "INR:${(list[index].dishPrice!).round()}",
                                      style: TextStyle(
                                          fontSize: context.responsiveWidth(15),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: context.responsiveWidth(6),
                                    ),
                                    Text(
                                      "${list[index].dishCalories} Calories",
                                      style: TextStyle(
                                          fontSize: context.responsiveWidth(15),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: context.responsiveHeight(40),
                                width: context.responsiveWidth(110),
                                decoration: BoxDecoration(
                                    color: Colors.green[900],
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .removefromcart(list[index]);
                                          ref
                                              .read(totalItemProvider.notifier)
                                              .state--;
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "${list[index].itemcount}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .addtcart(list[index]);
                                          ref
                                              .read(totalItemProvider.notifier)
                                              .state++;
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: context.responsiveWidth(5),
                              ),
                              Text(
                                "INR:${(list[index].itemcount * list[index].dishPrice!).round()}",
                                style: TextStyle(
                                    fontSize: context.responsiveWidth(16),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                      const Divider(),
                      SizedBox(
                        height: context.responsiveWidth(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: context.responsiveWidth(20),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "INR:${(ref.watch(cartProvider).totalprice()).round()}",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: context.responsiveWidth(20),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(context.responsiveWidth(15)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  minimumSize:
                      Size(context.maxWidth(), context.responsiveHeight(50))),
              onPressed: () {
                Navigator.pop(context);
                ref.read(cartProvider.notifier).clearlist();
                context.showSnackbar("Order Placed Successfully");
              },
              child: Text(
                "Place Order",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.responsiveWidth(16),
                    fontWeight: FontWeight.w500),
              )),
        ));
  }
}
