import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/products_details_screen.dart';

class Category2Widget extends StatefulWidget {
   const Category2Widget({super.key, required this.id, required this.title, required this.price, required this.image, required this.category, });
   final int id;
   final String title;
   final double? price;
   final String image;
   final String category;
  @override
  State<Category2Widget> createState() => _Category2WidgetState();
}

class _Category2WidgetState extends State<Category2Widget> {
  bool _click=false;

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 7,
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: ProductDetailScreen(prodId:widget.id),),);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: '\$ ',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w800,fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.price.toString(),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: (_click)?Colors.white:Colors.grey[200],
                            shape: BoxShape.circle
                        ),
                        child:Center(
                          child: IconButton(onPressed: (){
                            _click=!_click;
                            setState(() {

                            });
                          }, icon: Icon(IconlyBold.heart,color: (_click)?Colors.red:Colors.white,)),
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    height: size.height * 0.2,
                    width: double.infinity,
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 28,
                    ),
                    imageUrl:widget.image,
                    boxFit: BoxFit.fill,
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                  child: Center(
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}