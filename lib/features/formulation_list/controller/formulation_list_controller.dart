import 'package:best_bread_formulation/apis/formulation_api.dart';
import 'package:best_bread_formulation/features/formulation_list/widgets/formulation_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationListController extends StateNotifier<bool> {
  final FormulationAPI _formulationAPI;
  FormulationListController({
    required FormulationAPI formulationAPI,
  })  : _formulationAPI = formulationAPI,
        super(false);
}
