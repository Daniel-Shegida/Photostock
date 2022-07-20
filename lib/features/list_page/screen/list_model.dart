import 'dart:convert';
import 'package:elementary/elementary.dart';
import 'package:endgame/utils/card_info.dart';
import 'package:http/http.dart' as http;

const int imagesPerPage = 3;

/// Модель экрана просмотра фото
class ListPageModel extends ElementaryModel {
  ListPageModel() : super();

  /// CODE REVIEW
  ///
  /// Разумная тактика для парсинга данных:
  ///
  /// 1. Посмотреть в документацию и изучить поля. Обратить внимание на то,
  ///    какие поля могут быть пустыми, а какие нет. В данном случае в
  ///    документации это не указано и у вас нет явного контракта с бэкендом.
  ///    В таком случае действительно разумно воспринимать любое поле как null
  ///    по умолчанию.
  /// 2. Выделить, какие данные в твоём приложении необходимы, а какие достаточны.
  ///    В данном случае у тебя возвращается массив карточек с фотографиями.
  ///    В случае с Elementary абсолютно нелогично возвращать
  ///    из метода search именнно nullable-тип. Для этого случая у тебя есть
  ///    [handleError].
  /// 3. Поняли, что необходимые данные - возвращаемый массив карточек
  ///    с фотографиями (в т.ч. пустой). Теперь проходимся по полям.
  ///    Думаю, что единственное необходимое поле - imageUrl. Если не приходит
  ///    это поле, нет смысла отображать весь элемент на экране. Поэтому
  ///    логично карточку без этого поля просто отфильтровать в массиве.
  /// 4. Все остальные поля при этом достаточны. Их можно сделать nullable и
  ///    обрабатывать их отсутствие непосредственно в UI.
  ///
  /// Конечно же, это не универсальные правила, а пример рассуждений.

  /// CODE REVIEW
  /// 
  /// Критика с позиции того, что ты решил использовать в приложении
  /// архитектурный паттерн.
  /// 
  /// В этом классе слишком много ответственностей, которые не должны здесь
  /// быть:
  /// * Хранение базового URL
  /// * Склеивание URL
  /// * "Инициализация" HTTP-клиента (знаю, что он просто импортируется, но
  ///   это, помимо, прочего ещё нарушение буквы D из SOLID)
  /// * Прямое обращение к серверу
  /// * Декодинг данных и логика парсинга
  /// * Обработка ошибок
  /// 
  /// Класс просто невозможно будет поддерживать в какой-то момент, если
  /// к нему будет добавляться новая логика.

  /// получить список 3 деталей фото (должен быть дио но нет времени)
  Future<List<CardInfo>?> search(int pageNumber) async {
    try {
      var url = Uri.parse(
          "https://api.unsplash.com/photos/?per_page=$imagesPerPage&page=$pageNumber&client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043");
      final res = await http.get(url).timeout(const Duration(seconds: 3));
      final body = jsonDecode(res.body);

      DateTime data0 = DateTime.parse(body[0]['created_at']);
      DateTime data1 = DateTime.parse(body[1]['created_at']);
      DateTime data2 = DateTime.parse(body[2]['created_at']);

      /// CODE REVIEW
      ///
      /// Думаю, ты и сам тут должен понимать, что это очень плохой подход
      /// к вытаскиванию данных. Какие проблемы тут вижу:
      ///
      /// * Копипаста, код тяжело менять и поддерживать
      /// * Неэффективная обработка исключений. Оператор `??` - явно
      ///   плохой подход к обработке ошибок. Иногда лучше допустить ошибку
      ///   и отобразить её пользователю, чем скрыть её за ширмой случайных
      ///   данных.
      /// * Неавтоматизированный подход к парсингу. Из-за чего ломается вся
      ///   система при малейшем изменении.
      List<CardInfo> cardList = [
        CardInfo(
          imageUrl: body[0]['urls']['regular'],
          hash: body[0]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[0]['user']['username'] ?? "nobody",
          likes: body[0]['likes'] ?? 0,
          description: body[0]['description'] ?? "no desc",

          /// CODE REVIEW
          ///
          /// Если честно, не вижу не одной причины в подобном хранении даты.
          ///
          /// Можно было напрямую использовать [DateTime].
          ///
          /// Вероятно, причина в способе отображения этих данных на UI, но
          /// что бы ты делал в случае, если бы на одном их экранов тебе
          /// нужно было отобразить дату в формате `dd.MM.yyyy HH:mm:ss`, а
          /// на другом просто `dd.MM.yyyy`? Форматировать дату имеет смысл уже
          /// на этапе WM в твоём случае
          createdAt: "${data0.day}.${data0.month}.${data0.year}",
        ),
        CardInfo(
          imageUrl: body[1]['urls']['regular'],
          hash: body[1]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[1]['user']['username'] ?? "nobody",
          likes: body[1]['likes'] ?? 0,
          description: body[1]['description'] ?? "no desc",
          createdAt: '${data1.day}.${data1.month}.${data1.year}',
        ),
        CardInfo(
          imageUrl: body[2]['urls']['regular'],
          hash: body[2]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[2]['user']['username'] ?? "nobody",
          likes: body[2]['likes'] ?? 0,
          description: body[2]['description'] ?? "no desc",
          createdAt: '${data2.day}.${data2.month}.${data2.year}',
        ),
      ];
      return cardList;
    } catch (e) {
      return null;
    }
  }
}
