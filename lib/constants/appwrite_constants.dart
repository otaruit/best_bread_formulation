class AppwriteConstants {
  static const String databaseId = '65dea77e07c4ff2eb00a';
  static const String projectId = '65dea751a2e6be0327f8';
  static const String userCollectionId = '65dea77e07c4ff2eb00a';
  static const String formulationCollectionId = '65deea12e89b8b7a1d05';
  static const String recipeCollectionId = '660521724b6f2bae4511';
  static const String bucketId = '65e689a1799d4f3a630f';

  static const String endPoint = 'http://localhost/v1';
  // 以下Android シミュレーター用
  // static const String endPoint = 'http://10.0.2.2/v1';


  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$bucketId/files/$imageId/view?project=$projectId&mode=admin';
}
