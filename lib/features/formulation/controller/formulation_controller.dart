import 'dart:io';

import 'package:best_bread_formulation/apis/formulation_api.dart';
import 'package:best_bread_formulation/apis/storage_api.dart';
import 'package:best_bread_formulation/core/utils.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formulationControllerProvider = Provider((ref) {
  return FormulationController(
      ref: ref,
      formulationAPI: ref.watch(formulationAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});

final getLatestFormulationProvider = StreamProvider.autoDispose((ref) {
  final formulationAPI = ref.watch(formulationAPIProvider);
  return formulationAPI.getLatestFormulation();
});

final getFormulationListProvider = FutureProvider.autoDispose((ref) async {
  final controller = ref.read(formulationControllerProvider);
  return controller.getFormulations();
});

final getVersionListProvider =
    FutureProvider.family((ref, Formulation formulation) async {
  return ref.watch(formulationControllerProvider).getVersionList(formulation);
});

class FormulationController extends StateNotifier<bool> {
  final FormulationAPI _formulationAPI;
  final StorageAPI _storageAPI;

  FormulationController({
    required Ref ref,
    required FormulationAPI formulationAPI,
    required StorageAPI storageAPI,
  })  : 
        _formulationAPI = formulationAPI,
        _storageAPI = storageAPI,
        super(false);

  void _setRecipeIdIfNeeded(Formulation formulation) {
    if (formulation.recipeId.isEmpty) {
      formulation = formulation.copyWith(id: formulation.id);
    }
  }

  Future<List<Formulation>> getFormulations() async {
    final formulationList = await _formulationAPI.getFormulations();
    return formulationList
        .map((formulation) => Formulation.fromMap(formulation.data))
        .toList();
  }

  Future<List<Formulation>> getVersionList(Formulation formulation) async {
    final formulationList = await _formulationAPI.getVersionList(formulation);
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
      _setRecipeIdIfNeeded(submitFormulation);
      final res = await _formulationAPI.submitFormulation(submitFormulation);
      res.fold((l) => print(l.message), (r) {
        return null;
      });
    }
  }

  Future<void> reviseRecipeName({
    required Formulation formulation,
    required BuildContext context,
  }) async {
    Formulation submitFormulation = formulation.copyWith();
    _setRecipeIdIfNeeded(submitFormulation);
    final res = await _formulationAPI.reviseRecipeName(submitFormulation);
    res.fold((l) => print(l.message), (r) {
      showSnackBar(context, "レシピ名を変更しました");
    });
  }

  Future<void> _submitFormulationWithImages({
    required List<File> images,
    required Formulation formulation,
    required BuildContext context,
  }) async {
    state = true;
    final imageLinks = await _storageAPI.uploadImage(images);
    final updatedFormulation = formulation.copyWith(imageLinks: imageLinks);
    _setRecipeIdIfNeeded(updatedFormulation);
    final res = await _formulationAPI.submitFormulation(updatedFormulation);
    res.fold((l) => print(l.message), (r) {
      return null;
    });
  }
}
