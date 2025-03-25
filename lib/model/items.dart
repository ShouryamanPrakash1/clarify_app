import 'dart:convert';

// Convert JSON string to Catalogue object
Catalogue catalogueFromJson(String str) => Catalogue.fromJson(json.decode(str));
String catalogueToJson(Catalogue data) => json.encode(data.toJson());

class Catalogue {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  Catalogue({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
    products: (json["products"] as List?)
        ?.map((x) => Product.fromJson(x))
        .toList(),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": products?.map((x) => x.toJson()).toList(),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  int? id;
  String? title;
  String? description;
  Category? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  AvailabilityStatus? availabilityStatus;
  List<Review>? reviews;
  ReturnPolicy? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;

  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: categoryValues.map[json["category"]],
    price: (json["price"] as num?)?.toDouble(),
    discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
    rating: (json["rating"] as num?)?.toDouble(),
    stock: json["stock"],
    tags: (json["tags"] as List?)?.map((x) => x.toString()).toList(),
    brand: json["brand"],
    sku: json["sku"],
    weight: json["weight"],
    dimensions: json["dimensions"] == null
        ? null
        : Dimensions.fromJson(json["dimensions"]),
    warrantyInformation: json["warrantyInformation"],
    shippingInformation: json["shippingInformation"],
    availabilityStatus:
    availabilityStatusValues.map[json["availabilityStatus"]],
    reviews: (json["reviews"] as List?)
        ?.map((x) => Review.fromJson(x))
        .toList(),
    returnPolicy: returnPolicyValues.map[json["returnPolicy"]],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    images: (json["images"] as List?)?.map((x) => x.toString()).toList(),
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": categoryValues.reverse[category],
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": tags,
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "dimensions": dimensions?.toJson(),
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus":
    availabilityStatusValues.reverse[availabilityStatus],
    "reviews": reviews?.map((x) => x.toJson()).toList(),
    "returnPolicy": returnPolicyValues.reverse[returnPolicy],
    "minimumOrderQuantity": minimumOrderQuantity,
    "meta": meta?.toJson(),
    "images": images,
    "thumbnail": thumbnail,
  };
}

// ✅ Define missing classes

enum Category { Electronics, Clothing, HomeAppliances }

final categoryValues = EnumValues({
  "Electronics": Category.Electronics,
  "Clothing": Category.Clothing,
  "Home Appliances": Category.HomeAppliances,
});

class Dimensions {
  double? width;
  double? height;
  double? depth;

  Dimensions({this.width, this.height, this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: (json["width"] as num?)?.toDouble(),
    height: (json["height"] as num?)?.toDouble(),
    depth: (json["depth"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "depth": depth,
  };
}

enum AvailabilityStatus { InStock, OutOfStock, PreOrder }

final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.InStock,
  "Out of Stock": AvailabilityStatus.OutOfStock,
  "Pre Order": AvailabilityStatus.PreOrder,
});

class Review {
  String? user;
  String? comment;
  double? rating;

  Review({this.user, this.comment, this.rating});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    user: json["user"],
    comment: json["comment"],
    rating: (json["rating"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "comment": comment,
    "rating": rating,
  };
}

enum ReturnPolicy { NoReturns, SevenDaysReturn, ThirtyDaysReturn }

final returnPolicyValues = EnumValues({
  "No Returns": ReturnPolicy.NoReturns,
  "7 Days Return": ReturnPolicy.SevenDaysReturn,
  "30 Days Return": ReturnPolicy.ThirtyDaysReturn,
});

class Meta {
  String? manufacturer;
  DateTime? releaseDate;

  Meta({this.manufacturer, this.releaseDate});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    manufacturer: json["manufacturer"],
    releaseDate: json["releaseDate"] == null
        ? null
        : DateTime.parse(json["releaseDate"]),
  );

  Map<String, dynamic> toJson() => {
    "manufacturer": manufacturer,
    "releaseDate": releaseDate?.toIso8601String(),
  };
}

// Helper class for enum mappings
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
