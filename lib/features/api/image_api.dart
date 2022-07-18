// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
//
// part 'image_api.g.dart';
//
// /// апи со всеми функциями для обработки мест
// @RestApi(
//     // baseUrl: baseUrl
// )
// abstract class PlaceApi {
//   /// фабрика для ретрофита
//   factory ImageApi(Dio dio, {String baseUrl}) = _ImageApi;
//
//   /// получает список мест с сервера по фильтру
//   @POST(PlaceUrls.filteredPlaces)
//   Future<List<PlaceDto>> getFilteredPlaces(
//       @Body() PlacesFilterRequestDto body,
//       );
// }
