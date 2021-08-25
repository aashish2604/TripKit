class CountryListModel{
  final String name;
  final String code;

  const CountryListModel({required this.name,required this.code});

  static CountryListModel fromJson(json) => CountryListModel(
      name: json['name'],
      code: json['code']);
}