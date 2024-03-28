import 'package:best_bread_formulation/common/error_page.dart';
import 'package:best_bread_formulation/common/loading_page.dart';
import 'package:best_bread_formulation/constants/appwrite_constants.dart';
import 'package:best_bread_formulation/features/formulation/controller/formulation_controller.dart';
import 'package:best_bread_formulation/features/formulation/widgets/formulation_card.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationList extends ConsumerWidget {
  const FormulationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFormulationListProvider).when(
          data: (formulationList) {
            return ref.watch(getLatestFormulationProvider).when(
                  data: (data) {
                    if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.formulationCollectionId}.documents.*.create',
                    )) {
                      formulationList.insert(
                          0, Formulation.fromMap(data.payload));
                    } else if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.formulationCollectionId}.documents.*.delete',
                    )) {
                      final startingPoint =
                          data.events[0].lastIndexOf('documents.');
                      final endPoint = data.events[0].lastIndexOf('.delete');
                      final formulationId = data.events[0]
                          .substring(startingPoint + 10, endPoint);

                      formulationList.removeWhere(
                          (element) => element.id == formulationId);
                    }
                    return ListView.builder(
                      itemCount: formulationList.length,
                      itemBuilder: (context, index) {
                        final formulation = formulationList[index];
                        return Column(
                          children: [
                            FormulationCard(formulation: formulation),
                            SizedBox(height: 16),
                          ],
                        );
                      },
                    );
                  },
                  error: (e, s) => ErrorPage(error: e.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: formulationList.length,
                      itemBuilder: (context, index) {
                        final formulation = formulationList[index];
                        return Column(
                          children: [
                            FormulationCard(formulation: formulation),
                            SizedBox(height: 16),
                          ],
                        );
                      },
                    );
                  },
                );
          },
          error: (error, stackTrace) => ErrorPage(error: error.toString()),
          loading: () => const LoadingPage(),
        );
  }
}
