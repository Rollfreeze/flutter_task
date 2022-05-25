class BackendConnectionServiceException implements Exception {  
  String cause; BackendConnectionServiceException(this.cause);
  int code = 0;
  setCode(int c) => code = c;  
}