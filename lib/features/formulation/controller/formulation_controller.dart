import 'dart:io';

import 'package:best_bread_formulation/apis/formulation_api.dart';
import 'package:best_bread_formulation/apis/storage_api.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FormulationControllerProvider =
    StateNotifierProvider<FormulationController, bool>((ref) {
  return FormulationController(
      ref: ref,
      formulationAPI: ref.watch(formulationAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
  // storageAPI: ref.watch(storageAPIProvider));
});

final getFormulationListProvider = FutureProvider((ref) async {
  return ref.watch(FormulationControllerProvider.notifier).getFormulations();
});

class FormulationController extends StateNotifier<bool> {
  final FormulationAPI _formulationAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  FormulationController({
    required Ref ref,
    required FormulationAPI formulationAPI,
    required StorageAPI storageAPI,
  })  : _ref = ref,
        _formulationAPI = formulationAPI,
        _storageAPI = storageAPI,
        super(false);

Future<List<Formulation>> getFormulations() async {
    final formulationList = await _formulationAPI.getFormulations();
    return formulationList
        .map((formulation) => Formulation.fromMap(formulation.data))
        .toList();
  }

  Future<void> submitFormulation({
    required List<File> images,
    required Formulation formulation,
    required BuildContext context,
  }) async {
    if (images.isNotEmpty) {
      _submitFormulationWithImages(
        images: images,
        formulation: formulation,
        context: context,
      );
    } else {
      Formulation submitFormulation = formulation.copyWith();
      final res = await _formulationAPI.submitFormulation(submitFormulation);
      res.fold((l) => print(l.message), (r) {
        return null;
      });
    }
  }

  Future<void> _submitFormulationWithImages({
    required List<File> images,
    required Formulation formulation,
    required BuildContext context,
  }) async {
    state = true;
    final imageLinks = await _storageAPI.uploadImage(images);
    final submitFormulation = Formulation(
      recipeName: formulation.recipeName,
      versions: formulation.versions,
      revisionDate: formulation.revisionDate,
      creationDate: formulation.creationDate,
      strongFlour: formulation.strongFlour,
      weakFlour: formulation.weakFlour,
      butter: formulation.butter,
      sugar: formulation.sugar,
      salt: formulation.salt,
      skimMilk: formulation.skimMilk,
      east: formulation.east,
      water: formulation.water,
      uid: '',
      id: '',
      likes: List.empty(),
      commentIds: List.empty(),
      imageLinks: imageLinks,
    );
    final res = await _formulationAPI.submitFormulation(submitFormulation);
    res.fold((l) => print(l.message), (r) {
      return null;
    });
  }
}
