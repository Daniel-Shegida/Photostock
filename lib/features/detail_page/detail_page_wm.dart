import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_model.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';

/// фабрика создания [DetailWidgetModel]
DetailWidgetModel Function(BuildContext context)
    placeDetailWidgetModelFactoryWithParams(CardInfo url) {
  return (context) {
    return DetailWidgetModel(
      url,
      DetailModel(),
    );
  };
}

/// WidgetModel for [DetailScreen]
class DetailWidgetModel extends WidgetModel<DetailScreen, DetailModel>
    with SingleTickerProviderWidgetModelMixin
    implements IDetailWidgetModel {

  DetailWidgetModel(
    this._cardInfo,
    DetailModel model,
  ) : super(model);

  final CardInfo _cardInfo;

  @override
  CardInfo get cardInfo => _cardInfo;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void pop() {
    Navigator.pop(context);
  }
}

/// Interface of [DetailWidgetModel].
abstract class IDetailWidgetModel extends IWidgetModel {
  CardInfo get cardInfo;

  void pop();
}
