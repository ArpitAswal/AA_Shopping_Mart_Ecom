import 'package:flutter/material.dart';

class GridViewAttributes{

  static int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1100) {
      return 4; // Large screens (desktops, tablets)
    } else if (screenWidth >= 800) {
      return 3; // Medium screens (tablets)
    } else if (screenWidth >= 600) {
      return 2; // Small screens (larger phones, tablets)
    } else {
      return 1; // Extra small screens (phones)
    }
  }

  static double getChildAspectRatio(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200){
      return 1.2;
    } else if(screenWidth >= 1100){
      return 1.0;
    } else if (screenWidth >= 950) {
      return 1.2;  // For larger screens
    } else if (screenWidth >= 800) {
      return 1.0; // For medium screens
    } else if (screenWidth >= 750){
      return 1.4;
    } else if (screenWidth >= 600) {
      return 1.2;  // For smaller screens
    } else {
      return 2.0;  // For extra small screens
    }
  }
}