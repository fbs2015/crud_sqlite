class Contact{
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colPhoneNumber = 'phoneNumber';


  Contact({
    this.id,
    required this.name,
    required this.phoneNumber
  });

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    phoneNumber = map[colPhoneNumber];
  }

  String? id;
  String name = '';
  String phoneNumber = '';

  Map<String, dynamic> toMap(){
    return {
      colId: id,
      colName: name,
      colPhoneNumber: phoneNumber
    };    
  }
}