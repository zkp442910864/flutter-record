// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudData _$CloudDataFromJson(Map<String, dynamic> json) => CloudData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CloudDataToJson(CloudData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
