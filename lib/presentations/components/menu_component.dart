import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/presentations/components/item_menu.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({super.key, this.data});

  final RestaurantData? data;

  @override
  Widget build(BuildContext context) {
    final subParent = myTextTheme.displaySmall?.copyWith(
      fontSize: 20,
    );
    final subChild = myTextTheme.displaySmall?.copyWith(
      fontSize: 16,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Restaurant',
          style: subParent,
        ),
        15.verticalSpace,
        Row(
          children: [
            Container(
              width: 15,
              height: 1,
              color: Colors.grey,
            ),
            5.horizontalSpace,
            Text(
              'Makanan',
              style: subChild,
            ),
          ],
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              data?.menus?.foods?.length ?? 0,
              (index) => ItemMenu(
                index: index % 9,
                text: data?.menus?.foods?[index].name ?? '-',
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Row(
          children: [
            Container(
              width: 15,
              height: 1,
              color: Colors.grey,
            ),
            5.horizontalSpace,
            Text(
              'Minuman',
              style: subChild,
            ),
          ],
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              data?.menus?.drinks?.length ?? 0,
              (index) => ItemMenu(
                index: index % 9,
                text: data?.menus?.drinks?[index].name ?? '-',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
