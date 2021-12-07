import 'dart:io';

import 'package:bloc_basics/model/dic_response.dart';
import 'package:bloc_basics/service/http_service.dart';

class WordRepository {
  Future<List<DicRespose>> getWordsFromDictionary(String query) async {
    try {
      final response = await HttpService.getRequest("en_US/$query");

      if (response.statusCode == 200) {
        final result = dicResposeFromJson(response.body);
        return result;
      } else {
        return [];
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}
