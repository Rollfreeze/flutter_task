/// Собственный объект эксепшена,
/// предназачен для того, чтобы сохранять статус ошибки,
/// а также получать в некоторых случаях более точную индикацию
class BackendConnectionServiceException implements Exception {  
  String cause; BackendConnectionServiceException(this.cause);
  int code = 0;
  setCode(int c) => code = c;  
}

