class Professional {
  final String id;
  final String name;
  final String phone;
  final String profession;
  final String province;
  final String district;
  final String neighborhood;
  final String experience;
  final String description;
  final List<String> workPhotos;

  Professional({
    required this.id,
    required this.name,
    required this.phone,
    required this.profession,
    required this.province,
    required this.district,
    required this.neighborhood,
    this.experience = '',
    this.description = '',
    this.workPhotos = const [],
  });
}
