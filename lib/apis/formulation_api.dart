import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import '../constants/appwrite_constants.dart';

abstract class IFormulationAPI {
  Future<List<Document>> getFormulations();
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
}
