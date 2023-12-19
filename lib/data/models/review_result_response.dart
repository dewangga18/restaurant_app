import 'restaurant_detail_response.dart';

class ReviewResultResponse {
  bool? error;
  String? message;
  List<CustomerReview>? customerReviews;

  ReviewResultResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory ReviewResultResponse.fromJson(Map<String, dynamic> json) => ReviewResultResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
