import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationCard extends ConsumerWidget {
  final Formulation formulation;
  const FormulationCard({required this.formulation, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [Text(formulation.recipeName), Text(formulation.uid)],
        )
      ],
    );
  }
}
