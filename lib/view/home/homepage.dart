import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/extension/extension.dart';
import 'package:project/providers/apiprovider.dart';
import 'package:project/providers/cartprovider.dart';
import 'package:project/view/cart/cartpage.dart';
import 'package:project/widgets/drawer.dart';

import '../../model/Itemmodel.dart';
import '../../widgets/dishcard.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(apidataProvider);

    return Scaffold(
      drawer: const MyDrawer(),
      body: data.when(
        data: (data) => DefaultTabController(
            length: data[0].tableMenuList!.length,
            child: buildData(data, context)),
        error: (error, stackTrace) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.maxWidth(),
            ),
            Icon(
              Icons.error,
              size: context.responsiveWidth(50),
              color: Colors.red,
            ),
            IconButton(
                onPressed: () {
                  ref.invalidate(apidataProvider);
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black87,
                  size: context.responsiveWidth(50),
                )),
            Text(
              "Refresh",
              style: TextStyle(
                  fontSize: context.responsiveWidth(20), color: Colors.black54),
            ),
            Text(
              "Something Went Wrong!",
              style: TextStyle(
                  fontSize: context.responsiveWidth(20), color: Colors.black54),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildData(List<ResaurantItemModel> data, BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          // floating: true,
          centerTitle: true,
          title: Text(
            data[0].restaurantName!,
            style: TextStyle(
                fontSize: context.responsiveWidth(24), color: Colors.black87),
          ),
          primary: true,
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black54,
              )),
          actions: [
            GestureDetector(
              onTap: () {
                context.goto(const CartPage());
              },
              child: Stack(
                children: [
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black54,
                      )),
                  Positioned(
                    right: context.responsiveWidth(10),
                    child: Consumer(builder: (__, ref, _) {
                      return ref.watch(cartProvider).cartlist.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.all(
                                context.responsiveWidth(4),
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: Text(
                                ref
                                    .watch(cartProvider)
                                    .cartlist
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.responsiveWidth(12)),
                              ),
                            )
                          : const SizedBox();
                    }),
                  )
                ],
              ),
            )
          ],
        ),
        SliverAppBar(
          pinned: true,
          elevation: 3,
          primary: true,
          toolbarHeight: 0,
          bottom: TabBar(
              onTap: (value) {},
              labelColor: Colors.red[400],
              unselectedLabelColor: Colors.black45,
              indicatorColor: Colors.red,
              labelStyle: TextStyle(
                fontSize: context.responsiveWidth(14),
                fontWeight: FontWeight.w500,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              splashBorderRadius: BorderRadius.circular(50),
              isScrollable: true,
              tabs: [
                for (int i = 0; i < data[0].tableMenuList!.length; i++)
                  Tab(text: data[0].tableMenuList![i].menuCategory!)
              ]),
        ),
      ],
      body: TabBarView(children: [
        for (int i = 0; i < data[0].tableMenuList!.length; i++)
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dishescard(
                  data: data[0].tableMenuList![i].categoryDishes![index],
                  index: index,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data[0].tableMenuList![i].categoryDishes!.length),
      ]),
    );
  }
}
