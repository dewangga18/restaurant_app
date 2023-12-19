extension ImageX on String {
  String get smallImageResolution => setSmallResolution(this);
  String get mediumImageResolution => setMediumResolution(this);
  String get largeImageResolution => setLargeResolution(this);

  static const String _baseImagesUrl = 'https://restaurant-api.dicoding.dev/images';

  String setSmallResolution(String pictureId) {
    return '$_baseImagesUrl/small/$pictureId';
  }

  String setMediumResolution(String pictureId) {
    return '$_baseImagesUrl/medium/$pictureId';
  }

  String setLargeResolution(String pictureId) {
    return '$_baseImagesUrl/large/$pictureId';
  }

}
