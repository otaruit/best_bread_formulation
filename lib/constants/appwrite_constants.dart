class AppwriteConstants {
  static const String databaseId = '65dea77e07c4ff2eb00a';
  static const String projectId = '65dea751a2e6be0327f8';
  static const String endPoint = 'http://127.0.0.1/v1';

  static const String formulationCollection = '65deea12e89b8b7a1d05';
  static const String imagesBucket = '63cbdab48cdbccb6b34e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
