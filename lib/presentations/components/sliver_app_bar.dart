import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/data/providers/restaurant_provider.dart';
import 'package:restaurant_app/utils/extensions/get_image.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

class DetailSliverAppBar extends StatelessWidget {
  const DetailSliverAppBar({
    super.key,
    required this.provider,
    required this.data,
  });

  final RestaurantProvider provider;
  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoriteProvider>();
    bool isSaved = favProvider.isSavedItem(data.id);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 400,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      leading: const SizedBox(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: data.pictureId!.largeImageResolution,
                child: Image.network(
                  data.pictureId!.largeImageResolution,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade400,
                      child: Center(
                        child: Text(
                          'No Image',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (!provider.isCollapsed)
              Positioned(
                top: 25,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Row(
          children: [
            if (provider.isCollapsed) ...[
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              Text(
                data.name ?? '-',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              Text(
                (data.rating ?? '-').toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.start,
              ),
              5.horizontalSpace,
              const Icon(
                Icons.star,
                color: Colors.white,
              ),
              10.horizontalSpace,
            ] else ...[
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black12,
                padding: const EdgeInsets.only(bottom: 10, left: 48),
                child: Row(
                  children: [
                    Text(
                      data.name ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    Text(
                      (data.rating ?? '-').toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    5.horizontalSpace,
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    if (isSaved) ...[
                      IconButton(
                        onPressed: () => favProvider.removeData(data),
                        icon: const Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ] else ...[
                      IconButton(
                        onPressed: () => favProvider.addData(data),
                        icon: const Icon(Icons.favorite_outline),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
