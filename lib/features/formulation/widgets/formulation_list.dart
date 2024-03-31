import 'package:best_bread_formulation/common/error_page.dart';
import 'package:best_bread_formulation/common/loading_page.dart';
import 'package:best_bread_formulation/database/database_helper.dart';
import 'package:best_bread_formulation/database/formulation_database.dart';
import 'package:best_bread_formulation/features/formulation/widgets/formulation_card.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:best_bread_formulation/models/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationList extends ConsumerWidget {
  const FormulationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: FormulationDatabase.ge(),
        builder: (context, AsyncSnapshot<List<Formulation>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final dataset = dataSetList[index];
                  return Column(
                    children: [
                      FormulationCard(
                        dataSet: snapshot.data,
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              );
            }
          }
        });
  }
}
