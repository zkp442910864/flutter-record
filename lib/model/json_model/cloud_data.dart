import 'package:json_annotation/json_annotation.dart';

part 'cloud_data.g.dart';


@JsonSerializable()
class CloudData {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "data")
  Data? data;

  CloudData({
    this.id,
    this.name,
    this.data,
  });

  factory CloudData.fromJson(Map<String, dynamic> json) =>
      _$CloudDataFromJson(json);

  Map<String, dynamic> toJson() => _$CloudDataToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Data({
    this.id,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
