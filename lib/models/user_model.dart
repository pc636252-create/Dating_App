class UserModel {
  final String id;
  final String name;
  final int age;
  final String location;
  final String profession;
  final String about;
  final List<String> interests;
  final List<String> photos;
  final bool isOnline;
  final double distanceKm;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.profession,
    required this.about,
    required this.interests,
    required this.photos,
    this.isOnline = false,
    this.distanceKm = 1.0,
  });

  String get mainPhoto => photos.isNotEmpty ? photos.first : '';
}
