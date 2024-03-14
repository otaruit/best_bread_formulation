import 'package:best_bread_formulation/common/error_page.dart';
import 'package:best_bread_formulation/common/loading_page.dart';
import 'package:best_bread_formulation/features/formulation_list/controller/formulation_controller.dart';
import 'package:best_bread_formulation/features/formulation_list/widgets/formulation_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationList extends ConsumerWidget {
  const FormulationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFormulationListProvider).when(
        data: (formulationList) {
          return ListView.builder(itemBuilder: (context, index) {
            final formulation = formulationList[index];
            return FormulationCard(formulation: formulation);
          });
        },
        error: (e, s) => ErrorPage(error: e.toString()),
        loading: () => LoadingPage());
    // return Scaffold(
    //   body: ElevatedButton(
    //     onPressed: () {
    //       ref.read(authControllerProvider.notifier).logout(context);
    //       showSnackBarcontext, "ログアウトに成功しました！");
    //       Navigator.push(context, SignUpView.route());
    //     },
    //     child: const Text('ログアウト'),
    //   ),
    // );
    // },
    // );
  }
}
