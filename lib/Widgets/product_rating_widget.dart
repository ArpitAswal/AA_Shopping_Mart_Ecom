
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBuilder extends StatelessWidget {
  const RatingBuilder({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {

    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 32.0,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
        // size: iconSize,
      ),
      ignoreGestures: true,
      onRatingUpdate: ((value) {}),
    );
  }
}