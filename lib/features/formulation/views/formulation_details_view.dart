import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/features/formulation/views/revise_formulation_view.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormulationDetailsView extends ConsumerStatefulWidget {
  static route(Formulation formulation) => MaterialPageRoute(
        builder: (context) => FormulationDetailsView(
          formulation: formulation,
        ),
      );
  final Formulation formulation;
  const FormulationDetailsView({required this.formulation, Key? key})
      : super(key: key);

  @override
  ConsumerState<FormulationDetailsView> createState() =>
      _FormulationDetailsViewState();
}

class _FormulationDetailsViewState
    extends ConsumerState<FormulationDetailsView> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200, // 画像の高さ
              child: widget.formulation.imageLinks.isNotEmpty
                  ? Image.network(
                      widget.formulation.imageLinks.first,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      AssetsConstants.bread2,
                    ), // 画像がない場合のプレースホルダー
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                      Text(
                      '${widget.formulation.recipeName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                 
                    SizedBox(width: 8),
                    Text(
                      'var ${widget.formulation.versions}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        textBaseline: TextBaseline.alphabetic, // ベースラインを揃える
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            ReviseFormulationView.route(
                                formulation: widget.formulation));
                      },
                    ),
                  ]),
                  SizedBox(height: 8),
                  _buildItem(
                    label: 'ID',
                    value: widget.formulation.id,
                  ),
                  _buildItem(
                    label: '強力粉',
                    value: '${widget.formulation.strongFlour.toString()}g',
                  ),
                  _buildItem(
                    label: '薄力粉',
                    value: '${widget.formulation.weakFlour.toString()}g',
                  ),
                  _buildItem(
                    label: 'バター',
                    value: '${widget.formulation.butter.toString()}g',
                  ),
                  _buildItem(
                    label: '砂糖',
                    value: '${widget.formulation.sugar.toString()}g',
                  ),
                  _buildItem(
                    label: '塩',
                    value: '${widget.formulation.salt.toString()}g',
                  ),
                  _buildItem(
                    label: 'スキムミルク',
                    value: '${widget.formulation.skimMilk.toString()}g',
                  ),
                  _buildItem(
                    label: '水',
                    value: '${widget.formulation.water.toString()}g',
                  ),
                  _buildItem(
                    label: 'イースト',
                    value: '${widget.formulation.east.toString()}g',
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${_formDate(widget.formulation.revisionDate)}更新',
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        ' ${_formDate(widget.formulation.creationDate)}投稿',
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
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsConstants.bread2,
                width: 30.0, height: 30.0),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsConstants.bread3,
                width: 30.0, height: 30.0),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsConstants.croissant,
                width: 30.0, height: 30.0),
          ),
        ],
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
        Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            fontSize: 18,
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
