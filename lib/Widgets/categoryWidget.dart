import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
//  bool _click=false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 7,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.contain,
                )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                widget.name,
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
        ],
      ),
    );
  }
}
