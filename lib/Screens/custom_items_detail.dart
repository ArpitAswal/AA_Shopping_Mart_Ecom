
import 'package:aa_shopping_mart/DataModel/sale_items_model.dart';
import 'package:aa_shopping_mart/Widgets/image_slider.dart';
import 'package:aa_shopping_mart/Widgets/product_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomItemsDetail extends StatelessWidget {
  const CustomItemsDetail({super.key, required this.item});
  final SaleItemsModel item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
                tag: "${item.image.toString()}/CustomItem",
                transitionOnUserGestures: true,
                flightShuttleBuilder: (flightContext, animation, direction,
                    fromContext, toContext) {
                  // Use different animations for push and pop
                  return AnimatedBuilder(
                    animation: animation,
                    child: Image.network(item.image![0]),
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
                child: ImageSlider(images: item.image!),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.title.toString(),
                  style: GoogleFonts.lato(
                      color: Colors.blue,
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\$ ${item.price}",
                  style: GoogleFonts.alkatra(color: Colors.green, fontSize: 18),
                  textAlign: TextAlign.end,
                ),
                Text('"${item.description.toString()}"',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alkatra(
                        color: Colors.grey,
                        fontSize: 18,
                        fontStyle: FontStyle.italic)),
                RatingBuilder(
                  rating: item.rating!.rate ?? 0,
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
