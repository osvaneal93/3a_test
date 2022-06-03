// To parse this JSON data, do
//
//     final githyModel = githyModelFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart' as http;

GiftRepo githyModelFromJson(String str) => GiftRepo.fromJson(json.decode(str));

String githyModelToJson(GiftRepo data) => json.encode(data.toJson());

class GithyList{
  List<Images> items = [];
  GithyList.fromJsonList(List jsonList){
    if(jsonList == null) return;
    
    for (var item in jsonList) {
      final movieTemp = Images.fromJson(item['images']);
      items.add(movieTemp);
    }
  }
}

class GiftRepo {
    GiftRepo({
        required this.data,
    });

    List<Datum> data;

    factory GiftRepo.fromJson(Map<String, dynamic> json) => GiftRepo(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.type,
        this.id,
        this.url,
        this.slug,
        this.bitlyGifUrl,
        this.bitlyUrl,
        this.embedUrl,
        required this.images,
    });

    String? type;
    String? id;
    String? url;
    String? slug;
    String? bitlyGifUrl;
    String? bitlyUrl;
    String? embedUrl;
    Images images;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
        bitlyGifUrl: json["bitly_gif_url"],
        bitlyUrl: json["bitly_url"],
        embedUrl: json["embed_url"],
        images: Images.fromJson(json["images"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "url": url,
        "slug": slug,
        "bitly_gif_url": bitlyGifUrl,
        "bitly_url": bitlyUrl,
        "embed_url": embedUrl,
        "images": images!.toJson(),
    };
}

class Images {
    Images({
        required this.original,
    });

    Original original;

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: Original.fromJson(json["original"]),
    );

    Map<String, dynamic> toJson() => {
        "original": original.toJson(),
    };
}

class Original {
    Original({
        this.height,
        this.width,
        this.size,
        this.url,
    });

    String? height;
    String? width;
    String? size;
    String? url;

    factory Original.fromJson(Map<String, dynamic> json) => Original(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "size": size,
        "url": url,
    };
}

class GithyRepo {
  final uri =
      Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=icSy8CKYBNthrWm6WmrK7DnlwDYCJhew&q=restaurant&limit=3&offset=0&rating=g&lang=en');

      Future<List<Images>> getGit() async{
        final resp = await http.get(uri);
        final decodedData = json.decode(resp.body);
        print(decodedData);
        final githyList = GithyList.fromJsonList(decodedData['data']);
        print(githyList.items);
        return githyList.items;
      }
}