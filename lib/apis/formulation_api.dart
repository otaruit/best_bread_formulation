import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:best_bread_formulation/core/failure.dart';
import 'package:best_bread_formulation/core/providers.dart';
import 'package:best_bread_formulation/core/type_defs.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/appwrite_constants.dart';

final formulationAPIProvider = Provider((ref) {
  return FormulationAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class IFormulationAPI {
  Future<List<Document>> getFormulations();
  FutureEither<Document> submitFormulation(Formulation formulation);
  FutureEither<Document> reviseRecipeName(Formulation formulation);
  Future<List<Document>> getVersionList(Formulation formulation);
  Stream<RealtimeMessage> getLatestFormulation();
}

class FormulationAPI implements IFormulationAPI {
  final Realtime _realtime;
  final Databases _db;
  FormulationAPI({
    required Databases db,
    required Realtime realtime})
      : _db = db,
        _realtime = realtime;

  @override
  Future<List<Document>> getFormulations() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.formulationCollectionId,
      queries: [
        Query.notEqual('recipeId', ''),
        Query.orderDesc('creationDate'),
      ],
    );
    return documents.documents;
  }

  @override
  FutureEither<Document> submitFormulation(Formulation formulation) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.formulationCollectionId,
          documentId: ID.unique(),
          data: formulation.toMap());
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "投稿中にエラーが発生しました", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<Document> reviseRecipeName(Formulation formulation) async {
    try {
      final Map<String, dynamic> updateData = {
        'recipeName': formulation.recipeName,
      };

      final document = await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.formulationCollectionId,
          documentId: formulation.recipeId,
          data: updateData);

      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "更新中にエラーが発生しました", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getVersionList(Formulation formulation) async {
    final document = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.formulationCollectionId,
      queries: [
        Query.equal('recipeId', formulation.recipeId),
        Query.orderDesc('creationDate'),
      ],
    );
    return document.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestFormulation() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.formulationCollectionId}.documents'
    ]).stream;
  }
}
