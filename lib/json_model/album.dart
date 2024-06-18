import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'album.g.dart';

Future<Album> fetchAlbum() async {
  final res = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer my-token 123123',
    },
    // body: jsonEncode(<String, String>{
    //   'title': 'title',
    // }),
    body: jsonEncode({
      'title': 'title',
    })
  );
  final data = Album.fromJson(jsonDecode(res.body));
  return data;
}


@JsonSerializable()
class Album {
  @JsonKey(name: "userId")
  int? userId;

  /// id值
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  Album({
    this.userId,
    this.id,
    this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
