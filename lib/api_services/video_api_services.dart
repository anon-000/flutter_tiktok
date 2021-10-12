import 'package:alap/api_services/base_api.dart';
import 'package:alap/config/enums.dart';
import 'package:alap/data_models/video_data.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:14 PM
///

Future<VideoData> getAllVideos({required int skip, required int limit}) async {
  String path = r'?$skip=' + skip.toString() + r'&$limit=' + limit.toString();

  print("api call");
  var result = await ApiCall.generalApiCall(path, RequestMethod.get,
      isAuthNeeded: false);

  return videoDataFromJson(result.data);
}
