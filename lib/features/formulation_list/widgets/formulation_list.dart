import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationList extends ConsumerWidget {
  const FormulationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(getFormulationCardsProvider).when(data: (cards) {
    // ListView.builder(
    // itemCount: cards.length,
    // itemBuilder: (BuildContext context, int index) {
    // final card = cards[index];
    return Text('Formulation');
    // },
    // );
  }
}
