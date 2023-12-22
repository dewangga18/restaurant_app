import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/data/providers/list_provider.dart';
import 'package:restaurant_app/data/providers/search_provider.dart';
import 'package:restaurant_app/presentations/components/item_list.dart';
import 'package:restaurant_app/presentations/screens/favorite_page.dart';
import 'package:restaurant_app/presentations/widgets/loading_item.dart';
import 'package:restaurant_app/presentations/widgets/message_widget.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListDataProvider>(
          create: (_) => ListDataProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
      ],
      builder: (ctx, _) => _screen(ctx),
    );
  }

  Scaffold _screen(BuildContext context) {
    final favProvider = context.watch<FavoriteProvider>();
    final searchProvider = context.watch<SearchProvider>();
    final dataProvider = context.watch<ListDataProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              if (searchProvider.isSearch) ...[
                IconButton(
                  onPressed: searchProvider.hideSearch,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: TextField(
                    onChanged: searchProvider.onChanged,
                    controller: searchProvider.txtController,
                    focusNode: searchProvider.focusNode,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      hintText: 'Cari restoran enak',
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: searchProvider.clearText,
                  icon: const Icon(Icons.close, size: 30),
                ),
              ] else ...[
                Text(
                  'Restaurant App',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: searchProvider.displaySearch,
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () => Navigation.pushNamed(
                    FavoritePage.route,
                  ),
                  icon: const Icon(Icons.favorite_outlined),
                ),
              ],
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (searchProvider.isSearch) ...[
            if (searchProvider.state == SearchState.loading) ...[
              const LoadingItem(),
            ] else if (searchProvider.state == SearchState.error) ...[
              const MessageWidget(type: MessageType.noInternet),
            ] else if (searchProvider.state == SearchState.empty) ...[
              const MessageWidget(type: MessageType.searchEmpty),
            ] else ...[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (_, i) => 20.verticalSpace,
                  itemCount: searchProvider.searchData.length,
                  itemBuilder: (_, i) {
                    final data = searchProvider.searchData[i];
                    final index = (i % 9).toInt();
                    bool isSavedItem = favProvider.isSavedItem(data.id);

                    return ItemList(
                      restaurant: data,
                      i: index,
                      isSaved: isSavedItem,
                      removeFunc: () => favProvider.removeData(data),
                      addFunc: () => favProvider.addData(data),
                    );
                  },
                ),
              ),
            ],
          ] else ...[
            if (dataProvider.state == ResultListState.loading) ...[
              const LoadingItem(),
            ] else if (dataProvider.state == ResultListState.error) ...[
              MessageWidget(
                type: MessageType.noInternet,
                onRefresh: dataProvider.getRestaurants,
              ),
            ] else if (dataProvider.state == ResultListState.empty) ...[
              MessageWidget(
                type: MessageType.dataEmpty,
                onRefresh: dataProvider.getRestaurants,
              ),
            ] else ...[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (_, i) => 20.verticalSpace,
                  itemCount: dataProvider.resultData.length,
                  itemBuilder: (_, i) {
                    final data = dataProvider.resultData[i];
                    final index = (i % 9).toInt();
                    bool isSavedItem = favProvider.isSavedItem(data.id);

                    return ItemList(
                      restaurant: data,
                      i: index,
                      isSaved: isSavedItem,
                      removeFunc: () => favProvider.removeData(data),
                      addFunc: () => favProvider.addData(data),
                    );
                  },
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
