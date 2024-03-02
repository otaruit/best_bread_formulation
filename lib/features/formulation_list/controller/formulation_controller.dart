import 'dart:io';

import 'package:best_bread_formulation/apis/formulation_api.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FormulationControllerProvider =
    StateNotifierProvider<FormulationController, bool>((ref) {
  return FormulationController(
      ref: ref, formulationAPI: ref.watch(formulationAPIProvider));
  // storageAPI: ref.watch(storageAPIProvider));
});

class FormulationController extends StateNotifier<bool> {
  final FormulationAPI _formulationAPI;
  final Ref _ref;
  FormulationController({
    required Ref ref,
    required FormulationAPI formulationAPI,
  })  : _ref = ref,
        _formulationAPI = formulationAPI,
        super(false);

  Future<void> submitFormulation({
    required Formulation formulation,
    required BuildContext context,
  }) async {
    state = true;
    // final imageLinkes = await _storageAPI.uploadImage(images);

    Formulation submitFormulation = formulation.copyWith();
    final res = await _formulationAPI.submitFormulation(submitFormulation);
    res.fold(
        (l) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.message))), (r) {
      return null;
    });
    state = false;
  }
}
