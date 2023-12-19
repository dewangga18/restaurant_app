import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/utils/functions/color_profile.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
        right: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorProfile.getColorBg(index),
      ),
      child: Text(
        text,
        style: myTextTheme.bodyMedium,
      ),
    );
  }
}
