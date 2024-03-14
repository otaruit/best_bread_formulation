import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:best_bread_formulation/constants/appwrite_constants.dart';
import 'package:best_bread_formulation/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorageProvider));
});

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    try {
      for (final file in files) {
        final uploadedImage = await _storage.createFile(
          bucketId: AppwriteConstants.bucketId,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: file.path),
        );
        imageLinks.add(AppwriteConstants.imageUrl(uploadedImage.$id));
      }
    } catch (e) {
      // エラーが発生した場合の処理
      print('画像のアップロード中にエラーが発生しました: $e');
    }
    return imageLinks;
  }
}
