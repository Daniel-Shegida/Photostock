import 'dart:convert';
import 'package:elementary/elementary.dart';
import 'package:endgame/utils/card_info.dart';
import 'package:http/http.dart' as http;

const int imagesPerPage = 3;

/// Модель экрана просмотра фото
class ListPageModel extends ElementaryModel {
  ListPageModel() : super();


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
      List<CardInfo> cardList = [
        CardInfo(
          imageUrl: body[0]['urls']['regular'],
          hash: body[0]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[0]['user']['username'] ?? "nobody",
          likes: body[0]['likes'] ?? 0,
          description: body[0]['description'] ?? "no desc",
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
