import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/extension/extension.dart';
import 'package:project/providers/cartprovider.dart';

import '../model/Itemmodel.dart';

class Dishescard extends ConsumerWidget {
  const Dishescard({super.key, required this.data, required this.index});
  final CategoryDish data;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider).cartlist;
    int? itemcount = ref.read(cartProvider).itemcount(data.dishId!);
    return Padding(
      padding: EdgeInsets.all(context.responsiveWidth(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.crop_square_sharp,
                color: data.dishType == 2 ? Colors.green : Colors.red,
                size: 24,
              ),
              Icon(Icons.circle,
                  color: data.dishType == 2 ? Colors.green : Colors.red,
                  size: 10),
            ],
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.dishName!,
                    style: TextStyle(
                        fontSize: context.responsiveWidth(14),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(7),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "INR:${(data.dishPrice!).round()}",
                        style: TextStyle(
                            fontSize: context.responsiveWidth(13),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${data.dishCalories}:Calories",
                        style: TextStyle(
                            fontSize: context.responsiveWidth(13),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.responsiveHeight(7),
                  ),
                  Text(
                    data.dishDescription!,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: context.responsiveWidth(13),
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(10),
                  ),
                  Container(
                    height: context.responsiveHeight(40),
                    width: context.responsiveWidth(120),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .removefromcart(data);

                            ref.read(totalItemProvider.notifier).state--;
                          },
                        ),
                        Text(
                          "${itemcount ?? data.itemcount}",
                          style: TextStyle(
                              fontSize: context.responsiveWidth(14),
                              color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            ref.read(cartProvider.notifier).addtcart(data);
                            ref.read(totalItemProvider.notifier).state++;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(10),
                  ),
                  data.addonCat!.isNotEmpty
                      ? Text(
                          "Customizations Avaiable",
                          style: TextStyle(
                              fontSize: context.responsiveWidth(13),
                              fontWeight: FontWeight.w300,
                              color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: context.responsiveWidth(80),
              width: context.responsiveWidth(80),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: data.dishImage!,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
