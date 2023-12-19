import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/data/models/restaurant_response.dart';
import 'package:restaurant_app/data/providers/restaurant_provider.dart';
import 'package:restaurant_app/presentations/components/item_category.dart';
import 'package:restaurant_app/presentations/components/menu_component.dart';
import 'package:restaurant_app/presentations/components/review_components.dart';
import 'package:restaurant_app/presentations/widgets/loading_detail.dart';
import 'package:restaurant_app/presentations/components/sliver_app_bar.dart';
import 'package:restaurant_app/presentations/widgets/message_widget.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.data,
  });

  final Restaurant data;

  static const String route = '/detail';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
        apiService: ApiService(),
        idRestaurant: data.id ?? '',
      ),
      builder: (ctx, _) => _screen(context: ctx, restaurant: data),
    );
  }

  Scaffold _screen({
    required BuildContext context,
    required Restaurant restaurant,
  }) {
    final provider = context.watch<RestaurantProvider>();
    RestaurantData? data = provider.data;
    final subParent = myTextTheme.displaySmall?.copyWith(
      fontSize: 20,
    );

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        controller: provider.scrollCtrl,
        headerSliverBuilder: (ctx, scroolled) {
          return [
            DetailSliverAppBar(
              provider: provider,
              data: restaurant,
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.state == RestaurantState.loading) ...[
                const LoadingDetail(),
              ] else if (provider.state == RestaurantState.error) ...[
                MessageWidget(
                  type: MessageType.noInternet,
                  spacer: 20.verticalSpace,
                  onRefresh: provider.getDetailData,
                ),
              ] else ...[
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 15),
                    2.horizontalSpace,
                    Text(
                      '${data?.address}, ${data?.city} ',
                      style: myTextTheme.bodyMedium,
                    ),
                  ],
                ),
                5.verticalSpace,
                Text(
                  data?.description ?? '',
                  style: myTextTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                  ),
                  maxLines: provider.showMore ? null : 5,
                ),
                if (!provider.showMore) ...[
                  2.verticalSpace,
                  InkWell(
                    onTap: provider.doShowMore,
                    child: Text(
                      '..... Muat Lainnya',
                      style: myTextTheme.bodySmall?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
                30.verticalSpace,
                Text(
                  'Kategori Restaurant',
                  style: subParent,
                ),
                15.verticalSpace,
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(
                    data?.categories?.length ?? 0,
                    (index) => ItemCategory(
                      index: index % 9,
                      text: data?.categories?[index].name ?? '-',
                    ),
                  ),
                ),
                20.verticalSpace,
                MenuComponent(data: data),
                20.verticalSpace,
                ReviewComponents(provider: provider),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
