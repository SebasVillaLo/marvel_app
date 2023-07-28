import 'dart:convert';

class ComicsModel {
  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  Isbn? isbn;
  String? upc;
  DiamondCode? diamondCode;
  String? ean;
  String? issn;
  Format? format;
  int? pageCount;
  List<TextObject>? textObjects;
  String? resourceUri;
  List<Url>? urls;
  Series? series;
  List<Series>? variants;
  List<dynamic>? collections;
  List<Series>? collectedIssues;
  List<Date>? dates;
  List<Price>? prices;
  Thumbnail? thumbnail;
  List<Thumbnail>? images;
  Creators? creators;
  Characters? characters;
  Stories? stories;
  Characters? events;

  ComicsModel({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    this.textObjects,
    this.resourceUri,
    this.urls,
    this.series,
    this.variants,
    this.collections,
    this.collectedIssues,
    this.dates,
    this.prices,
    this.thumbnail,
    this.images,
    this.creators,
    this.characters,
    this.stories,
    this.events,
  });

  factory ComicsModel.fromRawJson(String str) =>
      ComicsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComicsModel.fromJson(Map<String, dynamic> json) => ComicsModel(
        id: json['id'],
        digitalId: json['digitalId'],
        title: json['title'],
        issueNumber: json['issueNumber'],
        variantDescription: json['variantDescription'],
        description: json['description'],
        modified: json['modified'],
        isbn: isbnValues.map[json['isbn']]!,
        upc: json['upc'],
        diamondCode: diamondCodeValues.map[json['diamondCode']]!,
        ean: json['ean'],
        issn: json['issn'],
        format: formatValues.map[json['format']]!,
        pageCount: json['pageCount'],
        textObjects: json['textObjects'] == null
            ? []
            : List<TextObject>.from(
                json['textObjects']!.map((x) => TextObject.fromJson(x))),
        resourceUri: json['resourceURI'],
        urls: json['urls'] == null
            ? []
            : List<Url>.from(json['urls']!.map((x) => Url.fromJson(x))),
        series: json['series'] == null ? null : Series.fromJson(json['series']),
        variants: json['variants'] == null
            ? []
            : List<Series>.from(
                json['variants']!.map((x) => Series.fromJson(x))),
        collections: json['collections'] == null
            ? []
            : List<dynamic>.from(json['collections']!.map((x) => x)),
        collectedIssues: json['collectedIssues'] == null
            ? []
            : List<Series>.from(
                json['collectedIssues']!.map((x) => Series.fromJson(x))),
        dates: json['dates'] == null
            ? []
            : List<Date>.from(json['dates']!.map((x) => Date.fromJson(x))),
        prices: json['prices'] == null
            ? []
            : List<Price>.from(json['prices']!.map((x) => Price.fromJson(x))),
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail']),
        images: json['images'] == null
            ? []
            : List<Thumbnail>.from(
                json['images']!.map((x) => Thumbnail.fromJson(x))),
        creators: json['creators'] == null
            ? null
            : Creators.fromJson(json['creators']),
        characters: json['characters'] == null
            ? null
            : Characters.fromJson(json['characters']),
        stories:
            json['stories'] == null ? null : Stories.fromJson(json['stories']),
        events:
            json['events'] == null ? null : Characters.fromJson(json['events']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'digitalId': digitalId,
        'title': title,
        'issueNumber': issueNumber,
        'variantDescription': variantDescription,
        'description': description,
        'modified': modified,
        'isbn': isbnValues.reverse[isbn],
        'upc': upc,
        'diamondCode': diamondCodeValues.reverse[diamondCode],
        'ean': ean,
        'issn': issn,
        'format': formatValues.reverse[format],
        'pageCount': pageCount,
        'textObjects': textObjects == null
            ? []
            : List<dynamic>.from(textObjects!.map((x) => x.toJson())),
        'resourceURI': resourceUri,
        'urls': urls == null
            ? []
            : List<dynamic>.from(urls!.map((x) => x.toJson())),
        'series': series?.toJson(),
        'variants': variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        'collections': collections == null
            ? []
            : List<dynamic>.from(collections!.map((x) => x)),
        'collectedIssues': collectedIssues == null
            ? []
            : List<dynamic>.from(collectedIssues!.map((x) => x.toJson())),
        'dates': dates == null
            ? []
            : List<dynamic>.from(dates!.map((x) => x.toJson())),
        'prices': prices == null
            ? []
            : List<dynamic>.from(prices!.map((x) => x.toJson())),
        'thumbnail': thumbnail?.toJson(),
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        'creators': creators?.toJson(),
        'characters': characters?.toJson(),
        'stories': stories?.toJson(),
        'events': events?.toJson(),
      };
}

class Characters {
  int? available;
  String? collectionUri;
  List<Series>? items;
  int? returned;

  Characters({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Characters.fromRawJson(String str) =>
      Characters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<Series>.from(json['items']!.map((x) => Series.fromJson(x))),
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

class Series {
  String? resourceUri;
  String? name;

  Series({
    this.resourceUri,
    this.name,
  });

  factory Series.fromRawJson(String str) => Series.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        resourceUri: json['resourceURI'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
      };
}

class Creators {
  int? available;
  String? collectionUri;
  List<CreatorsItem>? items;
  int? returned;

  Creators({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Creators.fromRawJson(String str) =>
      Creators.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<CreatorsItem>.from(
                json['items']!.map((x) => CreatorsItem.fromJson(x))),
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

class CreatorsItem {
  String? resourceUri;
  String? name;
  Role? role;

  CreatorsItem({
    this.resourceUri,
    this.name,
    this.role,
  });

  factory CreatorsItem.fromRawJson(String str) =>
      CreatorsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json['resourceURI'],
        name: json['name'],
        role: roleValues.map[json['role']]!,
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
        'role': roleValues.reverse[role],
      };
}

enum Role {
  COLORIST,
  EDITOR,
  INKER,
  LETTERER,
  PENCILER,
  PENCILLER,
  PENCILLER_COVER,
  WRITER
}

final roleValues = EnumValues({
  'colorist': Role.COLORIST,
  'editor': Role.EDITOR,
  'inker': Role.INKER,
  'letterer': Role.LETTERER,
  'penciler': Role.PENCILER,
  'penciller': Role.PENCILLER,
  'penciller (cover)': Role.PENCILLER_COVER,
  'writer': Role.WRITER
});

class Date {
  DateType? type;
  String? date;

  Date({
    this.type,
    this.date,
  });

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: dateTypeValues.map[json['type']]!,
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'type': dateTypeValues.reverse[type],
        'date': date,
      };
}

enum DateType { DIGITAL_PURCHASE_DATE, FOC_DATE, ONSALE_DATE, UNLIMITED_DATE }

final dateTypeValues = EnumValues({
  'digitalPurchaseDate': DateType.DIGITAL_PURCHASE_DATE,
  'focDate': DateType.FOC_DATE,
  'onsaleDate': DateType.ONSALE_DATE,
  'unlimitedDate': DateType.UNLIMITED_DATE
});

enum DiamondCode { EMPTY, JUL190068 }

final diamondCodeValues =
    EnumValues({'': DiamondCode.EMPTY, 'JUL190068': DiamondCode.JUL190068});

enum Format { COMIC, DIGEST, EMPTY, TRADE_PAPERBACK }

final formatValues = EnumValues({
  'Comic': Format.COMIC,
  'Digest': Format.DIGEST,
  '': Format.EMPTY,
  'Trade Paperback': Format.TRADE_PAPERBACK
});

class Thumbnail {
  String? path;
  Extension? exten;

  Thumbnail({
    this.path,
    this.exten,
  });

  factory Thumbnail.fromRawJson(String str) =>
      Thumbnail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json['path'],
        exten: extensionValues.map[json['extension']]!,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'extension': extensionValues.reverse[exten],
      };
}

enum Extension { JPG }

final extensionValues = EnumValues({'jpg': Extension.JPG});

enum Isbn { EMPTY, THE_0785111298, THE_0785114513, THE_0785115609 }

final isbnValues = EnumValues({
  '': Isbn.EMPTY,
  '0-7851-1129-8': Isbn.THE_0785111298,
  '0-7851-1451-3': Isbn.THE_0785114513,
  '0-7851-1560-9': Isbn.THE_0785115609
});

class Price {
  PriceType? type;
  double? price;

  Price({
    this.type,
    this.price,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        type: priceTypeValues.map[json['type']]!,
        price: json['price']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'type': priceTypeValues.reverse[type],
        'price': price,
      };
}

enum PriceType { DIGITAL_PURCHASE_PRICE, PRINT_PRICE }

final priceTypeValues = EnumValues({
  'digitalPurchasePrice': PriceType.DIGITAL_PURCHASE_PRICE,
  'printPrice': PriceType.PRINT_PRICE
});

class Stories {
  int? available;
  String? collectionUri;
  List<StoriesItem>? items;
  int? returned;

  Stories({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Stories.fromRawJson(String str) => Stories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<StoriesItem>.from(
                json['items']!.map((x) => StoriesItem.fromJson(x))),
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

class StoriesItem {
  String? resourceUri;
  String? name;
  ItemType? type;

  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  factory StoriesItem.fromRawJson(String str) =>
      StoriesItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json['resourceURI'],
        name: json['name'],
        type: itemTypeValues.map[json['type']]!,
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
        'type': itemTypeValues.reverse[type],
      };
}

enum ItemType { COVER, INTERIOR_STORY, PROMO }

final itemTypeValues = EnumValues({
  'cover': ItemType.COVER,
  'interiorStory': ItemType.INTERIOR_STORY,
  'promo': ItemType.PROMO
});

class TextObject {
  TextObjectType? type;
  Language? language;
  String? text;

  TextObject({
    this.type,
    this.language,
    this.text,
  });

  factory TextObject.fromRawJson(String str) =>
      TextObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TextObject.fromJson(Map<String, dynamic> json) => TextObject(
        type: textObjectTypeValues.map[json['type']]!,
        language: languageValues.map[json['language']]!,
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'type': textObjectTypeValues.reverse[type],
        'language': languageValues.reverse[language],
        'text': text,
      };
}

enum Language { EN_US }

final languageValues = EnumValues({'en-us': Language.EN_US});

enum TextObjectType { ISSUE_SOLICIT_TEXT }

final textObjectTypeValues =
    EnumValues({'issue_solicit_text': TextObjectType.ISSUE_SOLICIT_TEXT});

class Url {
  UrlType? type;
  String? url;

  Url({
    this.type,
    this.url,
  });

  factory Url.fromRawJson(String str) => Url.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json['type']]!,
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'type': urlTypeValues.reverse[type],
        'url': url,
      };
}

enum UrlType { DETAIL, IN_APP_LINK, PURCHASE, READER }

final urlTypeValues = EnumValues({
  'detail': UrlType.DETAIL,
  'inAppLink': UrlType.IN_APP_LINK,
  'purchase': UrlType.PURCHASE,
  'reader': UrlType.READER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
