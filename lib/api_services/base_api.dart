import 'dart:io';

import 'package:alap/config/api_routes.dart';
import 'package:alap/config/enums.dart';
import 'package:alap/data_models/rest_error.dart';
import 'package:alap/utils/utkal_snackbar.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 7:57 PM
///
///

class ApiCall {
  static Future<Response> generalApiCall(
    String path,
    RequestMethod requestMethod, {
    String id = '',
    String basePath = ApiRoutes.baseUrl,
    Map<String, String> query = const {},
    Map<String, dynamic> body = const {},
    bool isAuthNeeded = true,
  }) async {
    final Dio dio = Dio();
    dio.options.contentType = 'application/json';
    if (isAuthNeeded) {}
//      dio.options.headers['Authorization'] = SharedPreferenceHelper.accessToken;
    try {
      Response response;
      switch (requestMethod) {
        case RequestMethod.get:
          response = await dio.get('$basePath/$path');
          break;
        case RequestMethod.create:
          response = await dio.post('$basePath/$path',
              data: body, queryParameters: query);
          break;
        case RequestMethod.patch:
          response = await dio.patch('$basePath/$path/$id',
              data: body, queryParameters: query);
          break;
        default:
          response =
              await dio.delete('$basePath/$path/$id', queryParameters: query);
          break;
      }
      print(response.toString());
      return response;
    } on SocketException {
      throw 'No Internet Connection';
    } catch (error) {
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          print(error.response.statusMessage);
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {
//            Get.offAll(SocialSignInPage());
            UtkalSnackbar.show("ERROR", "You must login to continue");
          }
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }
//
//  static Future<String> singleFileUpload(Uint8List file, String name,
//      {String path = ApiRoutes.upload,
//        RequestMethod requestMethod = RequestMethod.create}) async {
//    try {
//      if (SharedPreferenceHelper.accessToken == null ||
//          SharedPreferenceHelper.accessToken.isEmpty) {
//        return null;
//      } else {
//        final Dio dio = Dio();
//        dio.options.headers['Authorization'] =
//            SharedPreferenceHelper.accessToken;
//        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
//            data: FormData.fromMap({
//              "photo": await MultipartFile.fromBytes(file, filename: name)
//            }));
//        if (response.data['result'] ?? false) {
//          return response.data['file'];
//        } else {
//          throw response.data;
//        }
//      }
//    } on SocketException {
//      throw 'No Internet Connection';
//    } catch (error) {
//      if (error is DioError) {
//        if (error.response.statusCode == 502) {
//          throw 'Server unreachable';
//        } else {
//          final restError = RestError.fromJson(error.response.data);
//          if (restError.code == 401) {}
//          throw restError;
//        }
//      } else {
//        throw error.toString();
//      }
//    }
//  }

//  static Future<List<String>> multipleFileUpload(List<File> files) async {
//    try {
//      if (await NetworkUtils.isNetworkAvailable()) {
//        if (SharedPreferenceHelper.accessToken == null ||
//            SharedPreferenceHelper.accessToken.isEmpty) {
//          Toast.show("Login Expired");
//          SharedPreferenceHelper.preferences.clear();
//          NavigationService.navigatorKey.currentState.pushAndRemoveUntil(
//              MaterialPageRoute(builder: (context) => AuthStartPage()),
//              (route) => false);
//          return null;
//        } else {
//          final Dio dio = Dio();
//          dio.options.headers['Authorization'] =
//              SharedPreferenceHelper.accessToken;
////          dio.options.contentType = 'application/json';
//          Map<String, MultipartFile> body = {};
//
//          for(int i=0; i<files.length; i++){
//            body['photo$i'] =
//            await MultipartFile.fromFile(files[i].path, filename: files[i].path);
//          }
//
//          Response response =
//              await dio.post(upload_url, data: FormData.fromMap(body));
//
//          if (response.data['result'] ?? false) {
//            if(files.length == 1){
//              List<String> list = [];
//              list.add(response.data['file']);
//              return list;
//            }else{
//              return List<String>.from(response.data["files"].map((x) => x));
//            }
//          } else {
//            throw response.data;
//          }
//        }
//      } else {
//        throw NoInternetError('No internet connection');
//      }
//    } catch (error) {
//      if (error is DioError) {
//        if (error.response.statusCode == 502) {
//          throw 'Server unreachable';
//        } else {
//          throw FitwalletResponse.fromJson(error.response.data);
//        }
//      } else if (error is NoInternetError) {
//        throw error.message;
//      } else {
//        throw error.toString();
//      }
//    }
//  }

//  static Future<ReverseGeoCoder> decodeFromLatLang(LocationData latLng) async {
//    Response response = await generalApiCall('', RequestMethod.get,
//        basePath: ApiRoutes.geoCoderApi,
//        query: {
//          'key': MyStrings.mapApiKey,
//          'latlng': '${latLng.latitude}.${latLng.longitude}'
//        });
//    return ReverseGeoCoder.fromJson(response.data);
//  }
}
