import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/providers/restaurant_provider.dart';
import 'package:restaurant_app/presentations/components/card_review.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';

class ReviewComponents extends StatelessWidget {
  const ReviewComponents({
    super.key,
    required this.provider,
  });

  final RestaurantProvider provider;

  @override
  Widget build(BuildContext context) {
    final subParent = myTextTheme.displaySmall?.copyWith(
      fontSize: 20,
    );
    final data = provider.data;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingin menambahkan review?',
            style: subParent,
          ),
          15.verticalSpace,
          TextField(
            controller: provider.nameCtrl,
            cursorColor: secondaryColor,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Namamu',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: secondaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          20.verticalSpace,
          TextField(
            controller: provider.commentCtrl,
            cursorColor: secondaryColor,
            decoration: InputDecoration(
              labelText: 'Keterangan',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: secondaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          15.verticalSpace,
          ElevatedButton(
            onPressed:
                provider.enableAdd ? () => provider.addReview(context) : null,
            child: provider.postLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Tambahkan'),
          ),
          15.verticalSpace,
          Text(
            'Daftar Review',
            style: subParent,
          ),
          15.verticalSpace,
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            separatorBuilder: (_, i) => 10.verticalSpace,
            itemCount: data?.customerReviews?.length ?? 0,
            itemBuilder: (_, i) {
              return CardReview(
                review: data!.customerReviews![i],
              );
            },
          ),
        ],
      ),
    );
  }
}
