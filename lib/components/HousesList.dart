import 'package:flutter_test_app/components/BackendConnectionService.dart';
import 'package:flutter_test_app/models/House.dart';

/// Класс представляет собой данные -
/// список объявлений. 
class HousesList {
	static List<House> housesList = [];

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
}