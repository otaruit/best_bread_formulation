import 'package:appwrite/appwrite.dart';
import 'package:best_bread_formulation/constants/appwrite_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppwriteConstants.endPoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});
