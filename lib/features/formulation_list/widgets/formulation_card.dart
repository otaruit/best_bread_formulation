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
       crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
      Text(formulation.recipeName),
      Text(formulation.uid.toString()),
      Text('${formulation.strongFlour.toString()}g'),
      Text('${formulation.weakFlour.toString()}g'),
      Text('${formulation.butter.toString()}g'),
      Text('${formulation.sugar.toString()}g'),
      Text('${formulation.salt.toString()}g'),
      Text('${formulation.skimMilk.toString()}g'),
      Text('${formulation.water.toString()}g'),
      Text('${formulation.east.toString()}g'),
      Text('${formulation.skimMilk.toString()}g'),
      Text('${formulation.revisionDate.toString()}に更新'),
      Text('${formulation.creationDate.toString()}に投稿'),
    ]);
  }
}
