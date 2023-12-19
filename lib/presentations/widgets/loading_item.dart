import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';
import 'package:restaurant_app/presentations/widgets/skeleton.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, i) => 16.verticalSpace,
        itemBuilder: (_, i) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Skeleton(
                radius: 20,
                height: 90,
                width: 120,
              ),
              20.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(
                    width: 200,
                    height: 25,
                  ),
                  3.verticalSpace,
                  const Skeleton(
                    width: 150,
                    height: 15,
                  ),
                  3.verticalSpace,
                  const Skeleton(
                    width: 60,
                    height: 18,
                  ),
                  3.verticalSpace,
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
