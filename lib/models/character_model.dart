import 'dart:convert';


class CharacterModel {
  int? id;
  String? name;
  String? description;
  String? modified;
  ThumbnailCharacter? thumbnail;
  String? resourceUri;
  ComicsCharacter? comics;
  ComicsCharacter? series;
  StoriesCharacter? stories;
  ComicsCharacter? events;
  List<UrlCharacter>? urls;

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.thumbnail,
    this.resourceUri,
    this.comics,
    this.series,
    this.stories,
    this.events,
    this.urls,
  });

  factory CharacterModel.fromRawJson(String str) => CharacterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        modified: json['modified'],
        thumbnail: json['thumbnail'] == null
            ? null
            : ThumbnailCharacter.fromJson(json['thumbnail']),
        resourceUri: json['resourceURI'],
        comics: json['comics'] == null ? null : ComicsCharacter.fromJson(json['comics']),
        series: json['series'] == null ? null : ComicsCharacter.fromJson(json['series']),
        stories:
            json['stories'] == null ? null : StoriesCharacter.fromJson(json['stories']),
        events: json['events'] == null ? null : ComicsCharacter.fromJson(json['events']),
        urls: json['urls'] == null
            ? []
            : List<UrlCharacter>.from(json['urls']!.map((x) => UrlCharacter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'modified': modified,
        'thumbnail': thumbnail?.toJson(),
        'resourceURI': resourceUri,
        'comics': comics?.toJson(),
        'series': series?.toJson(),
        'stories': stories?.toJson(),
        'events': events?.toJson(),
        'urls': urls == null
            ? []
            : List<dynamic>.from(urls!.map((x) => x.toJson())),
      };
}

class ComicsCharacter {
  int? available;
  String? collectionUri;
  List<ComicsItem>? items;
  int? returned;

  ComicsCharacter({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory ComicsCharacter.fromRawJson(String str) => ComicsCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComicsCharacter.fromJson(Map<String, dynamic> json) => ComicsCharacter(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<ComicsItem>.from(
                json['items']!.map((x) => ComicsItem.fromJson(x))),
        returned: json['returned'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
        'collectionURI': collectionUri,
        'items': items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        'returned': returned,
      };
}

class ComicsItem {
  String? resourceUri;
  String? name;

  ComicsItem({
    this.resourceUri,
    this.name,
  });

  factory ComicsItem.fromRawJson(String str) =>
      ComicsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComicsItem.fromJson(Map<String, dynamic> json) => ComicsItem(
        resourceUri: json['resourceURI'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
      };
}

class StoriesCharacter {
  int? available;
  String? collectionUri;
  List<StoriesItemCharacter>? items;
  int? returned;

  StoriesCharacter({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory StoriesCharacter.fromRawJson(String str) => StoriesCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesCharacter.fromJson(Map<String, dynamic> json) => StoriesCharacter(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<StoriesItemCharacter>.from(
                json['items']!.map((x) => StoriesItemCharacter.fromJson(x))),
        returned: json['returned'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
        'collectionURI': collectionUri,
        'items': items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        'returned': returned,
      };
}

class StoriesItemCharacter {
  String? resourceUri;
  String? name;
  ItemTypeCharacter? type;

  StoriesItemCharacter({
    this.resourceUri,
    this.name,
    this.type,
  });

  factory StoriesItemCharacter.fromRawJson(String str) =>
      StoriesItemCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesItemCharacter.fromJson(Map<String, dynamic> json) => StoriesItemCharacter(
        resourceUri: json['resourceURI'],
        name: json['name'],
        type: itemTypeValuesCharacter.map[json['type']]!,
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
        'type': itemTypeValuesCharacter.reverse[type],
      };
}

enum ItemTypeCharacter { COVER, EMPTY, INTERIOR_STORY }

final itemTypeValuesCharacter = EnumValuesCharacter({
  'cover': ItemTypeCharacter.COVER,
  '': ItemTypeCharacter.EMPTY,
  'interiorStory': ItemTypeCharacter.INTERIOR_STORY
});

class ThumbnailCharacter {
  String? path;
  ExtensionCharacter? exten;

  ThumbnailCharacter({
    this.path,
    this.exten,
  });

  factory ThumbnailCharacter.fromRawJson(String str) =>
      ThumbnailCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThumbnailCharacter.fromJson(Map<String, dynamic> json) => ThumbnailCharacter(
        path: json['path'],
        exten: extensionValuesCharacter.map[json['extension']]!,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'extension': extensionValuesCharacter.reverse[exten],
      };
}

enum ExtensionCharacter { GIF, JPG }

final extensionValuesCharacter =
    EnumValuesCharacter({'gif': ExtensionCharacter.GIF, 'jpg': ExtensionCharacter.JPG});

class UrlCharacter {
  UrlTypeCharacter? type;
  String? url;

  UrlCharacter({
    this.type,
    this.url,
  });

  factory UrlCharacter.fromRawJson(String str) => UrlCharacter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UrlCharacter.fromJson(Map<String, dynamic> json) => UrlCharacter(
        type: urlTypeValuesCharacter.map[json['type']]!,
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'type': urlTypeValuesCharacter.reverse[type],
        'url': url,
      };
}

enum UrlTypeCharacter { COMICLINK, DETAIL, WIKI }

final urlTypeValuesCharacter = EnumValuesCharacter({
  'comiclink': UrlTypeCharacter.COMICLINK,
  'detail': UrlTypeCharacter.DETAIL,
  'wiki': UrlTypeCharacter.WIKI
});

class EnumValuesCharacter<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValuesCharacter(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
