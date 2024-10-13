
import 'package:aa_shopping_mart/GlobalData/CartProducts.dart';
import 'package:aa_shopping_mart/Screens/products_details_screen.dart';
import 'package:aa_shopping_mart/Widgets/cart_calling.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CartProductsScreen extends StatefulWidget {
  const CartProductsScreen({super.key});

  @override
  State<CartProductsScreen> createState() => _CartProductsScreenState();
}

class _CartProductsScreenState extends State<CartProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartCalling>(
        create: (context) => CartCalling(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart Screen'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Stack(children: [
              SingleChildScrollView(child: Consumer<CartCalling>(
                  builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: value.count,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 6.0,
                              maxCrossAxisExtent: 300,
                            ),
                            itemBuilder: (ctx, index) {
                              CartProducts item = value.lst.toList()[index];
                              return InkWell(
                                  onTap: () {
                                    value.del(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(8.0),
                                      elevation: 7,
                                      color: Theme.of(context).cardColor,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: ProductDetailScreen(
                                                prodId: item.id ?? -1,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 3),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text: '\$ ',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text:
                                                                    "${item.price}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: FancyShimmerImage(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  width: double.infinity,
                                                  errorWidget: Icon(
                                                    IconlyBold.danger,
                                                    color: Colors.red,
                                                    size: 28,
                                                  ),
                                                  imageUrl: item.image!,
                                                  boxFit: BoxFit.fill,
                                                )),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0,
                                                        vertical: 4),
                                                child: Center(
                                                  child: Text(
                                                    item.title.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            }))
                  ],
                );
              })),
            ]),
          );
        }));
  }
}
