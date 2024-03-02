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
  return FormulationAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IFormulationAPI {
  Future<List<Document>> getFormulations();
  FutureEither<Document> submitFormulation(Formulation formulation);
}

class FormulationAPI implements IFormulationAPI {
  final Databases _db;
  FormulationAPI({
    required Databases db,
  }) : _db = db;

  @override
  Future<List<Document>> getFormulations() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.formulationCollection,
      queries: [
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
          collectionId: AppwriteConstants.formulationCollection,
          documentId: ID.unique(),
          data: formulation.toMap());
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? "Some unexpected error occurred",
          stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
