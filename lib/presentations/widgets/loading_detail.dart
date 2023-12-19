import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/extensions/set_space.dart';
import 'package:restaurant_app/presentations/widgets/skeleton.dart';

class LoadingDetail extends StatelessWidget {
  const LoadingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(
          width: width * 0.6,
          height: 18,
        ),
        10.verticalSpace,
        Skeleton(
          width: width,
          height: 200,
        ),
        10.verticalSpace,
        Skeleton(
          width: width * 0.2,
          height: 20,
        ),
        30.verticalSpace,
        Skeleton(
          width: width * 0.35,
          height: 20,
        ),
        15.verticalSpace,
        Row(
          children: [
            Skeleton(
              width: width * 0.3,
              height: 30,
              radius: 10,
            ),
            10.horizontalSpace,
            Skeleton(
              width: width * 0.3,
              height: 30,
              radius: 10,
            ),
          ],
        ),
        30.verticalSpace,
        Skeleton(
          width: width * 0.45,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Skeleton(
                width: width * 0.25,
                height: 20,
              ),
              15.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.25,
                    height: 30,
                    radius: 10,
                  ),
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.35,
                    height: 30,
                    radius: 10,
                  ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.2,
                    height: 30,
                    radius: 10,
                  ),
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.35,
                    height: 30,
                    radius: 10,
                  ),
                ],
              ),
              15.verticalSpace,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Skeleton(
                width: width * 0.25,
                height: 20,
              ),
              15.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.25,
                    height: 30,
                    radius: 10,
                  ),
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.35,
                    height: 30,
                    radius: 10,
                  ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.2,
                    height: 30,
                    radius: 10,
                  ),
                  20.horizontalSpace,
                  Skeleton(
                    width: width * 0.35,
                    height: 30,
                    radius: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        30.verticalSpace,
        Skeleton(
          width: width * 0.35,
          height: 20,
        ),
        15.verticalSpace,
        Skeleton(
          width: width * 0.5,
          height: 50,
          radius: 10,
        ),
        15.verticalSpace,
        Skeleton(
          width: width,
          height: 80,
          radius: 10,
        ),
        30.verticalSpace,
      ],
    );
  }
}
