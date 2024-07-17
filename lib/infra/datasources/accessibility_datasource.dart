// import 'package:accessibly/accessibly.dart';
// import 'package:accessibly/infra/models/accessibility_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class AccessiblyDatasource {
//   static const int _version = 1;
//   static const String _dbName = "Accessibly.db";

//   static Future<Database> getDB() async {
//     return openDatabase(
//       join(await getDatabasesPath(), _dbName),
//       version: _version,
//       onCreate: (db, version) async {
//         await db.execute("CREATE TABLE accessibility_settings ("
//             "id INTEGER PRIMARY KEY,"
//             "currentFontSize REAL,"
//             "colorBlindMode INTEGER,"
//             "impairedMode INTEGER,"
//             "textScaleFactor REAL,"
//             "headingColor TEXT,"
//             "textColor TEXT,"
//             "textBgColor TEXT,"
//             "scaldBgColor TEXT,"
//             "lineHeight REAL,"
//             "letterSpacing REAL,"
//             "imageColor TEXT,"
//             "imageVisibility INTEGER,"
//             "textAlignment TEXT,"
//             "monochrome INTEGER,"
//             "systemMode INTEGER,"
//             "isDark INTEGER,"
//             "originalTextColor String,"
//             "originalHeadingColor String,"
//             "originalImageColor String"
//             ")");
//       },
//     );
//   }

//   static Future<int> addAccessibly(
//       AccessiblyModel accessibilityModel) async {
//     final db = await getDB();
//     return await db.insert("AccessbilityModel", accessibilityModel.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<int> updateAccessibly(
//       AccessiblyModel accessibilityModel) async {
//     final db = await getDB();
//     return await db.update("Accessibly", accessibilityModel.toJson(),
//         where: "id=?",
//         whereArgs: [accessibilityModel.id],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   // static Future<int> deleteAccessibly(
//   //     AccessiblyModel accessibilityModel) async {
//   //   final db = await getDB();
//   //   return await db.delete(
//   //     "Accessibly",
//   //     where: "id=?",
//   //     whereArgs: [accessibilityModel.id],
//   //   );
//   // }

//   static Future<List<AccessiblyModel>?> getAllAccessibly() async {
//     final db = await getDB();

//     final List<Map<String, dynamic>> maps =
//         await db.query("AccessiblyModel");
//     if (maps.isEmpty) {
//       return null;
//     }
//     return List.generate(
//         maps.length, (index) => AccessiblyModel.fromJson(maps[index]));
//   }

//   Future<void> updateAccessiblySettings(
//       Accessibly settings) async {
//     final db = await getDB();
//     final accessibilityModel = AccessiblyModel(
//       id: 1,
//       headingColor: settings.headingColor,
//       impairedMode: settings.impairedMode,
//       textColor: settings.textColor,
//       textBgColor: settings.textBgColor,
//       isDark: settings.isDark,
//       systemMode: settings.systemMode,
//       // monochrome:settings.monochrome,
//       textAlignment: settings.textAlignment,
//       imageVisibility: settings.imageVisibility,
//       imageColor: settings.imageColor,
//       letterSpacing: settings.letterSpacing,
//       scaldBgColor: settings.scaldBgColor,
//       lineHeight: settings.lineHeight,
//       currentFontSize: settings.currentFontSize,
//       colorBlindMode: settings.colorBlindMode,
//       textScaleFactor: settings.textScaleFactor,
//       // monochrome: settings.monochrome,
//       originalTextColor: settings.originalTextColor,
//       originalHeadingColor: settings.originalHeadingColor,
//       originalImageColor: settings.orginalImageColor,
//     );

//     // Assuming there's only one record, update it
//     await db.update(
//       "accessibility_settings",
//       accessibilityModel.toJson(),
//     );
//   }
// }
