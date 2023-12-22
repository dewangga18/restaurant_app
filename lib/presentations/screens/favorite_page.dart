import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/presentations/components/item_list.dart';
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
          onPressed: () => Navigator.pop(context),
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
          if (data.isEmpty)
            const Center(
              child: MessageWidget(
                type: MessageType.dataEmpty,
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, i) => 20.verticalSpace,
                itemCount: data.length,
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
