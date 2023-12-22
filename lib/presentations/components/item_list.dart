import 'package:flutter/material.dart';
import 'package:restaurant_app/presentations/screens/detail_page.dart';
import 'package:restaurant_app/utils/extensions/get_image.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';
import 'package:restaurant_app/utils/functions/color_profile.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.restaurant,
    required this.i,
    required this.isSaved,
    this.addFunc,
    this.removeFunc,
  });

  final Restaurant restaurant;
  final int i;
  final bool isSaved;
  final VoidCallback? addFunc;
  final VoidCallback? removeFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailPage.route,
        arguments: restaurant,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorProfile.getColorBg(i),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Hero(
              tag: restaurant.pictureId?.largeImageResolution ?? '-',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  restaurant.pictureId?.largeImageResolution ?? '',
                  height: 90,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 90,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'No Image',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? '-',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    restaurant.city ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  3.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber.shade700,
                        size: 20,
                      ),
                      5.horizontalSpace,
                      Text(
                        (restaurant.rating ?? '0').toString(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isSaved) ...[
              IconButton(
                onPressed: removeFunc,
                icon: const Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                ),
              ),
            ] else ...[
              IconButton(
                onPressed: addFunc,
                icon: const Icon(Icons.favorite_outline),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
