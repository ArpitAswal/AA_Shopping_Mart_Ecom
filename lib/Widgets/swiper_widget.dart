import 'package:aa_shopping_mart/DataModel/sale_items_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../GlobalData/sale_items_data.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget(this.whichSwiper, {super.key});
  final String whichSwiper;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.3,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
              colors: [
                Color(0xFF7A60A5),
                Color(0xFF82C3DF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Swiper(
        itemCount: (whichSwiper == "LeftSwiper")
            ? SaleItemsData.saleItemsList.length ~/ 2
            : (SaleItemsData.saleItemsList.length / 2).ceil(),
        itemBuilder: (ctx, index) {
          index = (whichSwiper == "LeftSwiper")
              ? index
              : index + (SaleItemsData.saleItemsList.length / 2).floor();
          return SaleWidget(item: SaleItemsData.saleItemsList[index]);
        },
        autoplay: true,
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(right: 10, bottom: 5),
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
                color: Colors.white, activeColor: Colors.red)),
        control: const SwiperControl(
            color: Colors.white,
            disableColor: Colors.red,
            size: 18,
            padding: EdgeInsets.all(2)),
      ),
    );
  }
}

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key, required this.item});

  final SaleItemsModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(bottom: 20.0, top: 16.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
              colors: [
                Color(0xFF7A60A5),
                Color(0xFF82C3DF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: const Color(0xFF9689CE),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.white,
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                      ]),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                        textAlign: TextAlign.center,
                        softWrap: true,
                        text: TextSpan(
                            text: "Special\nDiscount\n",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 21),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${item.discount.toString()}%",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              )
                            ])),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    height: double.infinity,
                    width: double.infinity,
                    item.image![0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
