///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:13 PM
///


import 'dart:convert';

VideoData videoDataFromJson(String str) => VideoData.fromJson(json.decode(str));

String videoDataToJson(VideoData data) => json.encode(data.toJson());

class VideoData {
  VideoData({
    this.skip,
    this.limit,
    this.data,
  });

  int skip;
  int limit;
  List<VideoDatum> data;

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
    skip: json["skip"],
    limit: json["limit"],
    data: List<VideoDatum>.from(json["data"].map((x) => VideoDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "skip": skip,
    "limit": limit,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VideoDatum {
  VideoDatum({
    this.id,
    this.name,
    this.video,
    this.thumbnail,
  });

  String id;
  String name;
  String video;
  String thumbnail;

  factory VideoDatum.fromJson(Map<String, dynamic> json) => VideoDatum(
    id: json.containsKey('_id')
        ? json["_id"] != null ? json["_id"] : ''
        : '',
    name: json.containsKey('name')
        ? json["name"] != null ? json["name"] : ''
        : '',
    video: json.containsKey('video')
        ? json["video"] != null ? json["video"] : ''
        : '',
    thumbnail: json.containsKey('thumbnail')
        ? json["thumbnail"] != null ? json["thumbnail"] : ''
        : '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "video": video,
    "thumbnail": thumbnail,
  };
}
