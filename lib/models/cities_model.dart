import 'package:json_annotation/json_annotation.dart';
part 'cities_model.g.dart';


@JsonSerializable()
class Cities {
  int id;
  String name;
  String namePrepositional;

  Cities(this.id, this.name, this.namePrepositional);

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
  Map<String, dynamic> toJson() => _$CitiesToJson(this);
}