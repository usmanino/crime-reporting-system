import 'package:assault/models/complaint_model.dart';
import 'package:assault/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  //////////////////////////////
  ///
  static const String Table_Crime = 'crime';
  static const String C_Id = 'id';
  static const String C_FullName = 'full_name';
  static const String C_Gender = 'gender';
  static const String C_Height = 'height';
  static const String C_Age = 'age';
  static const String C_Date = 'date';
  static const String C_EyeColor = 'eye_colour';
  static const String C_Ethnicity = 'ethnicity';
  static const String C_HairColor = 'hair_Color';
  static const String C_SkinColor = 'skin_color';
  static const String C_TattooDescription = 'tattoo_Description';
  static const String C_FacialHair = 'facial_Hair';

  static const String crime_Table_Two = 'crime_table_two';
  static const String C_Description = 'description';
  static const String C_Town = 'town';
  static const String C_city = 'city';
  static const String C_state = 'state';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(
      path,
      version: Version,
      onCreate: _onCreate,
    );

    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");

    await db.execute("CREATE TABLE $Table_Crime ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $C_FullName TEXT, "
        " $C_Gender TEXT, "
        " $C_Height TEXT,"
        " $C_Age TEXT, "
        " $C_Date TEXT, "
        " $C_EyeColor TEXT, "
        " $C_Ethnicity TEXT, "
        " $C_HairColor TEXT, "
        " $C_SkinColor TEXT, "
        " $C_TattooDescription TEXT, "
        " $C_FacialHair TEXT, "
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }
  // insert in to crime table

  Future<void> saveDatatoCrime(ComplaintModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_Crime, user.toMap());
    return res;
  }

  Future<UserModel> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$email' AND "
        "$C_Password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  // Future<List<Map<String, dynamic>>> getMapComplaintList() async {
  //   Database db = await this.db;
  //   final List<Map<String, dynamic>> result = await db.query(crime_Table);
  //   return result;
  // }

  // Future<List<ComplaintModel>> getComplaintList() async {
  //   final List<Map<String, dynamic>> complaintMapList =
  //       await getMapComplaintList();
  //   final List<ComplaintModel> complaintList = [];
  //   complaintMapList.forEach((complaintMap) {
  //     complaintList.add(ComplaintModel.fromMap(complaintMap));
  //   });
  //   complaintList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
  //   return complaintList;
  // }

  ///////////////////////////

  // void _createComplainttwo(Database dbl, int version) async {
  //   await dbl.execute(
  //     "CREATE TABLE $crime_Table_Two ($C_Description TEXT,$C_Town TEXT,$C_state TEXT,$C_city TEXT,),",
  //   );
  // }

  // Future<List<Map<String, dynamic>>> getMapComplaintListTwo() async {
  //   Database dbl = await this.dbl;
  //   final List<Map<String, dynamic>> result = await dbl.query(crime_Table_Two);
  //   return result;
  // }

  // Future<List<ComplaintModelL>> getComplaintListTwo() async {
  //   final List<Map<String, dynamic>> complaintMapList =
  //       await getMapComplaintListTwo();
  //   final List<ComplaintModelL> complaintList = [];
  //   complaintMapList.forEach((complaintMap) {
  //     complaintList.add(ComplaintModelL.fromMap(complaintMap));
  //   });
  //   //  complaintList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
  //   return complaintList;
  // }

  // Future<int> insertComplainttwo(ComplaintModelL complaint2) async {
  //   Database dbl = await this.dbl;
  //   final int result = await dbl.insert(crime_Table_Two, complaint2.toMap());
  //   return result;
  // }

//////////////////////////////
  Future<int> deleteUser(String userId) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [userId]);
    return res;
  }
}
