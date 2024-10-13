import 'package:aa_shopping_mart/GlobalData/sale_items_data.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';

import '../Utils/gridview_attributes.dart';
import 'custom_items_detail.dart';

class DrawerItemsScreen extends StatelessWidget {
  const DrawerItemsScreen({super.key, required this.item});
  final String item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: LazyLoadScrollView(
          isLoading: true,
          onEndOfPage: () {},
          child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              shrinkWrap: true,
              itemCount: SaleItemsData.saleItemsList.length,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: GridViewAttributes.getCrossAxisCount(context),
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 16.0,
                childAspectRatio:
                    GridViewAttributes.getChildAspectRatio(context),
              ),
              itemBuilder: (ctx, index) {
                var prod = SaleItemsData.saleItemsList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: CustomItemsDetail(item: prod),
                        reverseDuration: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 12,
                    shadowColor: Colors.deepPurple,
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: "${prod.image.toString()}/CustomItem",
                              transitionOnUserGestures: true,
                              child: FancyShimmerImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                errorWidget: const Icon(
                                  IconlyBold.danger,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                alignment: Alignment.center,
                                imageUrl: prod.image![0],
                                boxFit: BoxFit.fill,
                                boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.deepPurpleAccent,
                                        offset: Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Flexible(
                              child: Text(prod.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    ));
  }
}
