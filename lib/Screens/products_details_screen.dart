import 'package:aa_shopping_mart/DataModel/products_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../ProvidersClass/products_provider.dart';
import '../Widgets/image_slider.dart';
import '../Widgets/product_rating_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.prodId});
  final int prodId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProductsProvider>(builder:
            (BuildContext context, ProductsProvider provider, Widget? child) {
          return FutureBuilder(
            future: provider.getSingleProduct(prodId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProductShimmer(); // Shimmer effect while loading
              } else if (snapshot.hasError) {
                return const Text(
                    "There is some error to display the information of selected product");
              } else {
                return ProductDetailWidget(data: snapshot.data!);
              }
            },
          );
        }),
      ),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Shimmer.fromColors(
          enabled: true,
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.9,
                width: size.width * 0.35,
                margin: const EdgeInsets.only(right: 8.0),
                constraints: BoxConstraints(
                    minWidth: size.width * 0.2,
                    minHeight: size.height * 0.5,
                    maxWidth: size.width * 0.35,
                    maxHeight: size.height * 0.9),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.4,
                    height: size.height * 0.05,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: size.width * 0.5,
                    height: size.height * 0.15,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.05,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }
}

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({super.key, required this.data});

  final ProductModel data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.9,
            width: size.width * 0.35,
            margin: const EdgeInsets.only(right: 14.0),
            constraints: BoxConstraints(
                minWidth: size.width * 0.2,
                minHeight: size.height * 0.5,
                maxWidth: size.width * 0.35,
                maxHeight: size.height * 0.9),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.purpleAccent,
                  ],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.deepPurpleAccent,
                    blurRadius: 8.0,
                    spreadRadius: 4.5,
                  ),
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 8.0,
                    spreadRadius: 2.5,
                  )
                ]),
            child: Hero(
              tag: "${data.image.toString()}/HomePage",
              transitionOnUserGestures: true,
              flightShuttleBuilder: (flightContext, animation, direction,
                  fromContext, toContext) {
                // Use different animations for push and pop
                return AnimatedBuilder(
                  animation: animation,
                  child: Image.network(data.image!),
                  builder: (context, child) {
                    // Customize animation for push and pop
                    final value = direction == HeroFlightDirection.push
                        ? animation.value
                        : (1.0 - animation.value); // Slow down pop

                    return Transform.scale(
                      scale: 1.0 + (0.5 * value), // Scale it smoothly
                      child: child,
                    );
                  },
                );
              },
              child: ImageSlider(images: List.filled(3, data.image!)),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.title.toString(),
                style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              Text(
                "\$ ${data.price}",
                style: GoogleFonts.alkatra(color: Colors.green, fontSize: 18),
                textAlign: TextAlign.end,
              ),
              Text('"${data.description.toString()}"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alkatra(
                      color: Colors.grey,
                      fontSize: 18,
                      fontStyle: FontStyle.italic)),
              RatingBuilder(
                rating: data.rating!.rate ?? 0,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
