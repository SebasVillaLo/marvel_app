
class CharacterModel {
  int? id;
  String? name;
  String? description;
  String? modified;
  ThumbnailCharacter? thumbnail;

  CharacterModel({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.thumbnail,
  });


  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        modified: json['modified'],
        thumbnail: json['thumbnail'] == null
            ? null
            : ThumbnailCharacter.fromJson(json['thumbnail']),
      );
}

class ThumbnailCharacter {
  String? path;
  ExtensionCharacter? exten;

  ThumbnailCharacter({
    this.path,
    this.exten,
  });

  factory ThumbnailCharacter.fromJson(Map<String, dynamic> json) => ThumbnailCharacter(
        path: json['path'],
        exten: extensionValues.map[json['extension']]!,
      );
}

enum ExtensionCharacter { JPG }

final extensionValues = EnumValuesCharacter({'jpg': ExtensionCharacter.JPG});

class EnumValuesCharacter<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValuesCharacter(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
