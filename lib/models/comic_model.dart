import 'dart:convert';

class ComicModel {
  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  Isbn? isbn;
  String? upc;
  DiamondCodeComics? diamondCode;
  String? ean;
  String? issn;
  FormatComics? format;
  int? pageCount;
  List<TextObject>? textObjects;
  String? resourceUri;
  List<Url>? urls;
  SeriesComics? series;
  List<SeriesComics>? variants;
  List<dynamic>? collections;
  List<SeriesComics>? collectedIssues;
  List<DateComics>? dates;
  List<PriceComics>? prices;
  ThumbnailComics? thumbnail;
  List<ThumbnailComics>? images;
  CreatorsComics? creators;
  CharactersComics? characters;
  StoriesComics? stories;
  CharactersComics? events;

  ComicModel({
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

  factory ComicModel.fromRawJson(String str) =>
      ComicModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
        id: json['id'],
        digitalId: json['digitalId'],
        title: json['title'],
        issueNumber: json['issueNumber'],
        variantDescription: json['variantDescription'],
        description: json['description'] == null || json['description'] == ''
            ? 'Not available description'
            : json['description'],
        modified: json['modified'],
        isbn: isbnValues.map[json['isbn']],
        upc: json['upc'],
        diamondCode: diamondCodeValuesComics.map[json['diamondCode']],
        ean: json['ean'],
        issn: json['issn'],
        format: formatValuesComics.map[json['format']],
        pageCount: json['pageCount'],
        textObjects: json['textObjects'] == null
            ? []
            : List<TextObject>.from(
                json['textObjects']!.map((x) => TextObject.fromJson(x))),
        resourceUri: json['resourceURI'],
        urls: json['urls'] == null
            ? []
            : List<Url>.from(json['urls']!.map((x) => Url.fromJson(x))),
        series: json['series'] == null
            ? null
            : SeriesComics.fromJson(json['series']),
        variants: json['variants'] == null
            ? []
            : List<SeriesComics>.from(
                json['variants']!.map((x) => SeriesComics.fromJson(x))),
        collections: json['collections'] == null
            ? []
            : List<dynamic>.from(json['collections']!.map((x) => x)),
        collectedIssues: json['collectedIssues'] == null
            ? []
            : List<SeriesComics>.from(
                json['collectedIssues']!.map((x) => SeriesComics.fromJson(x))),
        dates: json['dates'] == null
            ? []
            : List<DateComics>.from(
                json['dates']!.map((x) => DateComics.fromJson(x))),
        prices: json['prices'] == null
            ? []
            : List<PriceComics>.from(
                json['prices']!.map((x) => PriceComics.fromJson(x))),
        thumbnail: json['thumbnail'] == null
            ? null
            : ThumbnailComics.fromJson(json['thumbnail']),
        images: json['images'] == null
            ? []
            : List<ThumbnailComics>.from(
                json['images']!.map((x) => ThumbnailComics.fromJson(x))),
        creators: json['creators'] == null
            ? null
            : CreatorsComics.fromJson(json['creators']),
        characters: json['characters'] == null
            ? null
            : CharactersComics.fromJson(json['characters']),
        stories: json['stories'] == null
            ? null
            : StoriesComics.fromJson(json['stories']),
        events: json['events'] == null
            ? null
            : CharactersComics.fromJson(json['events']),
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
        'diamondCode': diamondCodeValuesComics.reverse[diamondCode],
        'ean': ean,
        'issn': issn,
        'format': formatValuesComics.reverse[format],
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

class CharactersComics {
  int? available;
  String? collectionUri;
  List<SeriesComics>? items;
  int? returned;

  CharactersComics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory CharactersComics.fromRawJson(String str) =>
      CharactersComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharactersComics.fromJson(Map<String, dynamic> json) =>
      CharactersComics(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<SeriesComics>.from(
                json['items']!.map((x) => SeriesComics.fromJson(x))),
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

class SeriesComics {
  String? resourceUri;
  String? name;

  SeriesComics({
    this.resourceUri,
    this.name,
  });

  factory SeriesComics.fromRawJson(String str) =>
      SeriesComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeriesComics.fromJson(Map<String, dynamic> json) => SeriesComics(
        resourceUri: json['resourceURI'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
      };
}

class CreatorsComics {
  int? available;
  String? collectionUri;
  List<CreatorsItemComics>? items;
  int? returned;

  CreatorsComics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory CreatorsComics.fromRawJson(String str) =>
      CreatorsComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatorsComics.fromJson(Map<String, dynamic> json) => CreatorsComics(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<CreatorsItemComics>.from(
                json['items']!.map((x) => CreatorsItemComics.fromJson(x))),
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

class CreatorsItemComics {
  String? resourceUri;
  String? name;
  RoleComics? role;

  CreatorsItemComics({
    this.resourceUri,
    this.name,
    this.role,
  });

  factory CreatorsItemComics.fromRawJson(String str) =>
      CreatorsItemComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatorsItemComics.fromJson(Map<String, dynamic> json) =>
      CreatorsItemComics(
        resourceUri: json['resourceURI'],
        name: json['name'],
        role: roleValuesComics.map[json['role']],
      );

  Map<String, dynamic> toJson() => {
        'resourceURI': resourceUri,
        'name': name,
        'role': roleValuesComics.reverse[role],
      };
}

enum RoleComics {
  COLORIST,
  EDITOR,
  INKER,
  LETTERER,
  PENCILER,
  PENCILLER,
  PENCILLER_COVER,
  WRITER
}

final roleValuesComics = EnumValues({
  'colorist': RoleComics.COLORIST,
  'editor': RoleComics.EDITOR,
  'inker': RoleComics.INKER,
  'letterer': RoleComics.LETTERER,
  'penciler': RoleComics.PENCILER,
  'penciller': RoleComics.PENCILLER,
  'penciller (cover)': RoleComics.PENCILLER_COVER,
  'writer': RoleComics.WRITER
});

class DateComics {
  DateTypeComics? type;
  String? date;

  DateComics({
    this.type,
    this.date,
  });

  factory DateComics.fromRawJson(String str) =>
      DateComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DateComics.fromJson(Map<String, dynamic> json) => DateComics(
        type: dateTypeValuesComics.map[json['type']]!,
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'type': dateTypeValuesComics.reverse[type],
        'date': date,
      };
}

enum DateTypeComics {
  DIGITAL_PURCHASE_DATE,
  FOC_DATE,
  ONSALE_DATE,
  UNLIMITED_DATE
}

final dateTypeValuesComics = EnumValues({
  'digitalPurchaseDate': DateTypeComics.DIGITAL_PURCHASE_DATE,
  'focDate': DateTypeComics.FOC_DATE,
  'onsaleDate': DateTypeComics.ONSALE_DATE,
  'unlimitedDate': DateTypeComics.UNLIMITED_DATE
});

enum DiamondCodeComics { EMPTY, JUL190068 }

final diamondCodeValuesComics = EnumValues(
    {'': DiamondCodeComics.EMPTY, 'JUL190068': DiamondCodeComics.JUL190068});

enum FormatComics { COMIC, DIGEST, EMPTY, TRADE_PAPERBACK }

final formatValuesComics = EnumValues({
  'Comic': FormatComics.COMIC,
  'Digest': FormatComics.DIGEST,
  '': FormatComics.EMPTY,
  'Trade Paperback': FormatComics.TRADE_PAPERBACK
});

class ThumbnailComics {
  String? path;
  ExtensionComics? exten;

  ThumbnailComics({
    this.path,
    this.exten,
  });

  factory ThumbnailComics.fromRawJson(String str) =>
      ThumbnailComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThumbnailComics.fromJson(Map<String, dynamic> json) =>
      ThumbnailComics(
        path: json['path'],
        exten: extensionValuesComics.map[json['extension']]!,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'extension': extensionValuesComics.reverse[exten],
      };
}

enum ExtensionComics { JPG }

final extensionValuesComics = EnumValues({'jpg': ExtensionComics.JPG});

enum Isbn { EMPTY, THE_0785111298, THE_0785114513, THE_0785115609 }

final isbnValues = EnumValues({
  '': Isbn.EMPTY,
  '0-7851-1129-8': Isbn.THE_0785111298,
  '0-7851-1451-3': Isbn.THE_0785114513,
  '0-7851-1560-9': Isbn.THE_0785115609
});

class PriceComics {
  PriceTypeComics? type;
  double? price;

  PriceComics({
    this.type,
    this.price,
  });

  factory PriceComics.fromRawJson(String str) =>
      PriceComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PriceComics.fromJson(Map<String, dynamic> json) => PriceComics(
        type: priceTypeValuesComics.map[json['type']]!,
        price: json['price']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'type': priceTypeValuesComics.reverse[type],
        'price': price,
      };
}

enum PriceTypeComics { DIGITAL_PURCHASE_PRICE, PRINT_PRICE }

final priceTypeValuesComics = EnumValues({
  'digitalPurchasePrice': PriceTypeComics.DIGITAL_PURCHASE_PRICE,
  'printPrice': PriceTypeComics.PRINT_PRICE
});

class StoriesComics {
  int? available;
  String? collectionUri;
  List<StoriesItemComics>? items;
  int? returned;

  StoriesComics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory StoriesComics.fromRawJson(String str) =>
      StoriesComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesComics.fromJson(Map<String, dynamic> json) => StoriesComics(
        available: json['available'],
        collectionUri: json['collectionURI'],
        items: json['items'] == null
            ? []
            : List<StoriesItemComics>.from(
                json['items']!.map((x) => StoriesItemComics.fromJson(x))),
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

class StoriesItemComics {
  String? resourceUri;
  String? name;
  ItemType? type;

  StoriesItemComics({
    this.resourceUri,
    this.name,
    this.type,
  });

  factory StoriesItemComics.fromRawJson(String str) =>
      StoriesItemComics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesItemComics.fromJson(Map<String, dynamic> json) =>
      StoriesItemComics(
        resourceUri: json['resourceURI'],
        name: json['name'],
        type: itemTypeValues.map[json['type']],
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
        type: textObjectTypeValues.map[json['type']],
        language: languageValues.map[json['language']],
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
