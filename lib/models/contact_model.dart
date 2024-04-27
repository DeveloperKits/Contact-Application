class ContactModel{
  int? id;
  String name;
  String mobile;
  String? email;
  String? address;
  String? image;
  bool favorite;

  ContactModel({
    this.id,
    required this.name,
    required this.mobile,
    this.email,
    this.address,
    this.image,
    this.favorite = false
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      colName: name,
      colMobile: mobile,
      colEmail: email,
      colAddress: address,
      colImage: image,
      colFavorite: favorite ? 1 : 0
    };

    if(id != null){
      map[colId] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
    id: map[colId],
    name: map[colName],
    mobile: map[colMobile],
    email: map[colEmail],
    address: map[colAddress],
    image: map[colImage],
    favorite: map[colFavorite] == 1 ? true : false,
  );
}

const String tblContact = "contacts";
const String colId = "id";
const String colName = "name";
const String colMobile = "mobile";
const String colEmail = "email";
const String colAddress = "address";
const String colImage = "image";
const String colFavorite = "favorite";