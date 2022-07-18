/// сущность всекй информации, что содержит карточка
class CardInfo {
  /// url изображения
  String imageUrl;

  /// hash
  String hash;

  /// имя пользователя
  String username;

  /// кол-во лайков
  int likes;

  /// описания места
  String description;

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
