import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/arguments/add_review.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/utils/functions/messenger.dart';

enum RestaurantState {
  loading,
  error,
  success,
}

enum ReviewResult { loading, error, success }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({
    required this.apiService,
    required String idRestaurant,
  }) {
    id = idRestaurant;
    nameCtrl = TextEditingController()..addListener(_enableAddFunction);
    commentCtrl = TextEditingController()..addListener(_enableAddFunction);
    scrollCtrl = ScrollController()
      ..addListener(() {
        _isCollapsed =
            scrollCtrl.offset > 250 && !scrollCtrl.position.outOfRange;
        notifyListeners();
      });
    getDetailData();
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    nameCtrl.dispose();
    commentCtrl.dispose();
    super.dispose();
  }

  String id = '';

  bool _isCollapsed = false;

  bool get isCollapsed => _isCollapsed;

  bool _showMore = false;

  bool get showMore => _showMore;

  void doShowMore() {
    _showMore = true;
    notifyListeners();
  }

  RestaurantData? data;

  late ScrollController scrollCtrl;

  RestaurantState state = RestaurantState.loading;

  Future<void> getDetailData() async {
    state = RestaurantState.loading;
    notifyListeners();

    final response = await apiService.getDetailData(id);

    if (response.error ?? false) {
      state = RestaurantState.error;
    } else {
      state = RestaurantState.success;
      data = response.restaurant;
    }
    notifyListeners();
  }

  late TextEditingController nameCtrl;

  late TextEditingController commentCtrl;

  bool postLoading = false;

  bool _enableAdd = false;

  bool get enableAdd => _enableAdd;

  void _enableAddFunction() {
    _enableAdd = commentCtrl.text.isNotEmpty && nameCtrl.text.isNotEmpty;
    notifyListeners();
  }

  Future<void> addReview(BuildContext context) async {
    postLoading = true;
    notifyListeners();
    FocusManager.instance.primaryFocus?.unfocus();

    apiService
        .addReviewData(
      AddReview(
        id: id,
        name: nameCtrl.text,
        review: commentCtrl.text,
      ),
    )
        .then(
      (value) {
        if (value.error ?? false) {
          AppMessenger.showMessage(
            content: 'Unable to add your review!',
            context: context,
          );
        } else {
          nameCtrl.clear();
          commentCtrl.clear();
          if (value.customerReviews != null) {
            data?.customerReviews?.add(
              value.customerReviews!.last,
            );
            AppMessenger.showMessage(
              content: 'Success to add your review!',
              context: context,
            );
          }
        }

        postLoading = false;
        notifyListeners();
      },
    );
  }
}
