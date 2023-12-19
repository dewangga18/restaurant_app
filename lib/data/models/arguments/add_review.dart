class AddReview {
  String? id;
  String? name;
  String? review;

  AddReview({
    this.id,
    this.name,
    this.review,
  });

  factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
