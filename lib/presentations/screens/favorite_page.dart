import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/data/providers/scheduler_provider.dart';
import 'package:restaurant_app/presentations/components/item_list.dart';
import 'package:restaurant_app/presentations/widgets/custom_dialog.dart';
import 'package:restaurant_app/presentations/widgets/message_widget.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  static const String route = '/favorite';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();
    final data = provider.savedList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigation.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text(
          'My Favorite Resto',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Text('Want to receive we recomendation?'),
                const Spacer(),
                Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      activeColor: Colors.indigo,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.setRecomendation(value);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (data.isEmpty)
            const MessageWidget(
              type: MessageType.dataEmpty,
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, i) => 20.verticalSpace,
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  final index = (i % 9).toInt();
                  bool isSavedItem = provider.isSavedItem(data[i].id);

                  return ItemList(
                    restaurant: data[i],
                    i: index,
                    isSaved: isSavedItem,
                    removeFunc: () => provider.removeData(data[i]),
                    addFunc: () => provider.addData(data[i]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
