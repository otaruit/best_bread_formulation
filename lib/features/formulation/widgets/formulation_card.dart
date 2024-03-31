import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/features/formulation/views/formulation_details_view.dart';
import 'package:best_bread_formulation/models/data_set.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class FormulationCard extends ConsumerWidget {
  final DataSet dataSet;

  const FormulationCard({required this.dataSet, Key? key})
      : super(key: key);

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
          width: 100, // ラベルの幅を固定
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, FormulationDetailsView.route(dataSet.formulation));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.redColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150, // 画像の幅を設定
              height: 150,
              child: dataSet.recipe.imageLinks.isNotEmpty
                  ? Image.network(
                      dataSet.recipe.imageLinks.first,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      AssetsConstants.bread2,
                    ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem(label: 'レシピ名', value: dataSet.recipe.recipeName),
                  _buildItem(label: 'ドキュメントID', value: dataSet.formulation.id),
                  _buildItem(
                      label: '強力粉',
                      value: '${dataSet.formulation.strongFlour.toString()}g'),
                  _buildItem(
                      label: '薄力粉',
                      value: '${dataSet.formulation.weakFlour.toString()}g'),
                  _buildItem(
                      label: 'バター',
                      value: '${dataSet.formulation.butter.toString()}g'),
                  _buildItem(
                      label: '砂糖',
                      value: '${dataSet.formulation.sugar.toString()}g'),
                  _buildItem(
                      label: '塩',
                      value: '${dataSet.formulation.salt.toString()}g'),
                  _buildItem(
                      label: 'スキムミルク',
                      value: '${dataSet.formulation.skimMilk.toString()}g'),
                  _buildItem(
                      label: '水',
                      value: '${dataSet.formulation.water.toString()}g'),
                  _buildItem(
                      label: 'イースト',
                      value: '${dataSet.formulation.east.toString()}g'),
                  SizedBox(height: 8), // ラベルの間に隙間を入れる
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_formDate(dataSet.formulation.creationDate)}投稿',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
