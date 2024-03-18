import 'package:best_bread_formulation/features/formulation/views/revise_formulation_view.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormulationDetailsView extends ConsumerWidget {
  static route(Formulation formulation) => MaterialPageRoute(
        builder: (context) => FormulationDetailsView(
          formulation: formulation,
        ),
      );
  final Formulation formulation;
  const FormulationDetailsView({required this.formulation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レシピ詳細'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200, // 画像の高さ
              child: formulation.imageLinks.isNotEmpty
                  ? Image.network(
                      formulation.imageLinks.first,
                      fit: BoxFit.cover,
                    )
                  : Placeholder(), // 画像がない場合のプレースホルダー
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text(
                        '${formulation.recipeName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              ReviseFormulationView.route(
                                  formulation: formulation));
                        },
                      ),
                    ]),
                  ),
                  SizedBox(height: 8),
                  _buildItem(
                    label: 'UID',
                    value: formulation.uid.toString(),
                  ),
                  _buildItem(
                    label: '強力粉',
                    value: '${formulation.strongFlour.toString()}g',
                  ),
                  _buildItem(
                    label: '薄力粉',
                    value: '${formulation.weakFlour.toString()}g',
                  ),
                  _buildItem(
                    label: 'バター',
                    value: '${formulation.butter.toString()}g',
                  ),
                  _buildItem(
                    label: '砂糖',
                    value: '${formulation.sugar.toString()}g',
                  ),
                  _buildItem(
                    label: '塩',
                    value: '${formulation.salt.toString()}g',
                  ),
                  _buildItem(
                    label: 'スキムミルク',
                    value: '${formulation.skimMilk.toString()}g',
                  ),
                  _buildItem(
                    label: '水',
                    value: '${formulation.water.toString()}g',
                  ),
                  _buildItem(
                    label: 'イースト',
                    value: '${formulation.east.toString()}g',
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${_formDate(formulation.revisionDate)}に更新',
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        ' ${_formDate(formulation.creationDate)}に投稿',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formDate(DateTime? date) {
    if (date != null) {
      return '${date.year}/${date.month}/${date.day}';
    } else {
      return '';
    }
  }

  Widget _buildItem({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.right, // 右寄せに設定
          ),
        ),
      ],
    );
  }
}
