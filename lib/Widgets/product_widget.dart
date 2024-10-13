import 'package:aa_shopping_mart/ProvidersClass/category_provider.dart';
import 'package:aa_shopping_mart/ProvidersClass/products_provider.dart';
import 'package:aa_shopping_mart/Screens/products_details_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final int index;
  final String whichList;

  const ProductWidget(
      {super.key, required this.index, required this.whichList});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<
        ProductsProvider>(); // Accessing the provider passed via ChangeNotifierProvider.value
    final ctgProvider = context.read<
        CategoryProvider>(); // Accessing the provider passed via ChangeNotifierProvider.value
    final prod = (whichList == "ProductList")
        ? provider.productsList[index]
        : ctgProvider.categoryItemsList[index];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ProductDetailScreen(
              prodId: prod.id ?? -1,
            ),
            reverseDuration: const Duration(milliseconds: 700),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                  tag: "${prod.image.toString()}/HomePage",
                  transitionOnUserGestures: true,
                  child: FancyShimmerImage(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 24,
                    ),
                    alignment: Alignment.center,
                    imageUrl: prod.image!,
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
  }
}
