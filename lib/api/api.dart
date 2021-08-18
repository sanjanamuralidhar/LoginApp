import 'package:LoginApp/Models/model_result.dart';
import 'package:LoginApp/util/util.dart';

class Api {
  static Future<ResultApiModel> validateToken() async {
    final result = await UtilAsset.loadJson("assets/data/validate.json");
    print(result['data']);
    return ResultApiModel.fromJson(result['data']);
  }

  static Future<dynamic> login({String username, String password}) async {
    await Future.delayed(Duration(seconds: 1));
    if (username == 'admin' && password == 'admin') {
      final result = await UtilAsset.loadJson("assets/data/login$username$password.json");
      return ResultApiModel.fromJson(result);
    } else {
      final result = await UtilAsset.loadJson("assets/data/loginfail.json");
      return ResultApiModel.fromJson(result);
    }
  }

  static Future<ResultApiModel> logOut() async {
    final result = await UtilAsset.loadJson("assets/data/validate.json");
    print(result['data']);
    return ResultApiModel.fromJson(result['data']);
  }
}
