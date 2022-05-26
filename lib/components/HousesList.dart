import 'package:flutter_test_app/components/BackendConnectionService.dart';
import 'package:flutter_test_app/models/House.dart';

/// Класс представляет собой данные -
/// список объявлений.
class HousesList {
  static List<House> housesList = [];
  static List<House> housesListOFrame = [];
  static List<House> housesListAFrame = [];

  /// Получаем список объявлений
  static fetchAdvertismentCards(url) async {
    /// Небольшой хак с кешем. Если данные уже были получены,
    /// а затем мы перезаходим на страничку,
    /// мы можем не создавать еще один запрос к серверу,
    /// тем самым экономя время и рессурсы,
    /// поэтому, если список === null, то прогружаем,
    /// а если данные уже есть, то возвращаем из статики

    try {
      if (HousesList.housesList.isEmpty) {
        var requestJson = await BackendConnectionService.request(url: url);

        for (int i = 0; i < requestJson.length; i++) {
          HousesList.housesList.add(House.fromMap(map: requestJson[i]));
        }
      }

      return HousesList.housesList;
    } catch (e) {
      throw Exception('Ошибка инициализации данных');
    }
  }

  /// Изначально пользователю загружается целый список
  /// всех домов, включая o-frame и a-frame.
  ///
  /// Нет нужды делать отдельный http запрос еще раз,
  /// мы можем использовать метод извлекающий нужные данные
  /// из перваначального массива, потому как там
  /// и так уже есть все нужные данные
  static fetchOFrameCards() async {
    if (HousesList.housesListOFrame.isEmpty) {
      housesList.forEach((element) {
        if (element.type == 'o-frame') housesListOFrame.add(element);
      });
    }

		return HousesList.housesListOFrame;
  }

  static fetchAFrameCards() async {
    if (HousesList.housesListAFrame.isEmpty) {
      housesList.forEach((element) {
        if (element.type == 'a-frame') housesListAFrame.add(element);
      });
    }

		return HousesList.housesListAFrame;
  }
}
