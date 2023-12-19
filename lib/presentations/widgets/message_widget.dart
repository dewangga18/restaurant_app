import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

enum MessageType { dataEmpty, searchEmpty, noInternet }

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.type,
    this.onRefresh,
    this.spacer,
  });

  final MessageType type;
  final Widget? spacer;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    String asset = '';
    String message = '';

    switch (type) {
      case MessageType.dataEmpty:
        asset = 'assets/empty_data.jpg';
        message = 'Data is empty';
      case MessageType.searchEmpty:
        asset = 'assets/search_empty.jpg';
        message = 'Try another keyword for load other data';
      case MessageType.noInternet:
        asset = 'assets/no_internet.jpg';
        message = 'Unable to load data because your internet connection';
    }

    return Center(
      child: Column(
        children: [
          spacer ?? (MediaQuery.of(context).size.height * 0.2).verticalSpace,
          Image.asset(
            asset,
            height: 300,
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          if (onRefresh != null) ...[
            5.verticalSpace,
            IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: onRefresh,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.refresh_rounded,
                  ),
                  5.horizontalSpace,
                  Text(
                    'Refresh',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: secondaryColor,
                        ),
                  ),
                  5.horizontalSpace,
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
