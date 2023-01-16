import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  //
  final accessToken = 'pk.eyJ1IjoiZXBldGUiLCJhIjoiY2xjcXN4bnc2MDI0YzN3cGM3cm1ieDR4bSJ9.A1MB2eV0xHC7uByrDp3_BA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });

    super.onRequest(options, handler);
  }
}
