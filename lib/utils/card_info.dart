import 'package:flutter/foundation.dart';

/// сущность всекй информации, что содержит карточка
@immutable
class CardInfo {
  /// url изображения
  String imageUrl;

  /// hash
  String hash;

  /// имя пользователя
  String username;

  /// кол-во лайков
  int likes;

  /// CODEREVIEW
  ///
  /// Делать поля класса данных мутабельными - плохое решение.
  ///
  /// Классы данных часто перемещаются по коду и делать их поля final -
  /// гарантия того, что твои данные останутся в том же виде, в каком
  /// ты их инициализировал
  ///
  /// Хорошая привычка - помечать классы как `@immutable`. Дарт сам тебе
  /// подскажет, что все поля класса данных должны быть final.

  /// описания места
  String description;

  /// CODE REVIEW
  ///
  /// Привыкай пользоваться тем, что даёт тебе платформа из корбки.
  ///
  /// Нет никакого смысла хранить дату и время в произвольной String, когда
  /// у тебя есть [DateTime]. То же самое касается, например, хранения
  /// секунд в переменной типа [int] (в этом случае логичнее пользоваться
  /// [Duration]).

  /// дата создания изображения
  String createdAt;

  /// полный конструктор места
  CardInfo({
    required this.imageUrl,
    required this.hash,
    required this.username,
    required this.likes,
    required this.description,
    required this.createdAt,
  });
}
