import 'dart:convert';
import 'package:flutter_test_app/exceptions/BackendConnectionServiceException.dart';
import 'package:http/http.dart' as http;

class BackendConnectionService {
	/// url для получения объявлений
	final url = "https://elki.rent/test/house.json";

	/// Заголовки для запроса
	Map<String, String> headers = {
		"Content-Type": "application/json",
		"Accept": "application/json",
	};

	/// Полноценный запрос
  ///
  /// В случае ошибки возвращает [BackendConnectionServiceException]
  /// В случае успешного запроса - пытается преобразовать данные
  /// из JSON и вернуть их.
  ///
  /// **Если получаемые данные не содержат корретных JSON данных - будет
  /// выбрашено исключение**
	static request({required String url, String type = 'get', body}) async {
    return BackendConnectionService()._request(url: url, type: type, body: body);
  }

	/// Основной метод запроса
  _request({required String url, String type = 'get', body}) async {
    try {
      var response = await _selectRequest(url: url, type: type, body: body);
      if (response.statusCode == 200) return json.decode(response.body);
			
      BackendConnectionServiceException be = BackendConnectionServiceException(response.toString());
      be.setCode(response.statusCode);
      throw be;
    } on BackendConnectionServiceException catch (except) {
			/// Если случилась какая-то ошибка,
			/// например, произошел неверный запрос,
			/// то пробрасываем экспешн на уровень выше
      throw except;
    } catch (except) {
			/// Другая ошибка - например, пришел неправильный json
      BackendConnectionServiceException be = BackendConnectionServiceException(except.toString());

			/// Явно обозначим ее нулем,
			/// тогда мы будем понимать, что проблема не с сервером
      be.setCode(0);
      throw be;
    }
  }

	/// Выбор типа реквеста
  _selectRequest({required url, type, body}) async {
		switch (type){
			case 'post':
				return await http.post(Uri.parse(url), headers: headers, body: body);
			case 'get':
				return await http.get(Uri.parse(url), headers: headers);
			case 'delete':
				return await http.delete(Uri.parse(url), headers: headers, body: body);
			default:
				throw BackendConnectionServiceException("Unknown request type");
		}
  }
}

