import 'package:form_making_practice/blocs/models/ratings.dart';
import 'package:form_making_practice/blocs/models/user.dart';
import 'package:gsheets/gsheets.dart';

class DataService {
  static const _credentials = r''' {
   "type": "service_account",
  "project_id": "pristine-flames-338922",
  "private_key_id": "12a207b8bf32e4d1ebf4ccd0af3e5131cc16e98e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nrhysburman_private_key\n-----END PRIVATE KEY-----\n",
  "client_email": "ratings-gsheets@pristine-flames-338922.iam.gserviceaccount.com",
  "client_id": "113937805599848003875",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ratings-gsheets%40pristine-flames-338922.iam.gserviceaccount.com"
  }
  ''';

  static const _spreadsheetId = '1WTrZ4t5U6oQqI144QVsQy4cgeIqv2lYYWk6Ud2f032Q';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Worksheet? _rattingSheet;
  
  static Future init() async {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Locations');
      _rattingSheet = await _getWorkSheet(spreadsheet, title: 'Ratings');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
      final firstRow1 = RatingFields.getRatings();
      _rattingSheet!.values.insertRow(1, firstRow1);
  }

  static Future<Worksheet> _getWorkSheet (
    Spreadsheet spreadsheet, {
      required String title,
    }) async {
      try {
        return await spreadsheet.addWorksheet(title);
      }catch (e){
        return spreadsheet.worksheetByTitle(title)!;
      }
    }

    static Future<Field?> getById(int id) async{
      if (_userSheet == null) return null;

      final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
      return json == null ? null: Field.fromJson(json);
    }

  static Future<Ratings?> getByID(int id) async{
    if (_rattingSheet == null) return null;

    final json = await _rattingSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null: Ratings.fromJson(json);
  }

    static Future insert(List<Map<String, dynamic>> rowList) async{
      if (_userSheet == null) return;

      _userSheet!.values.map.appendRows(rowList);
    }

  static Future insert1(List<Map<String, dynamic>> rowList) async{
    if (_rattingSheet == null) return;

    _rattingSheet!.values.map.appendRows(rowList);
  }

    static Future<int> getRowCount1() async {
      if (_rattingSheet == null) return 0;

      final lastRow = await _rattingSheet!.values.lastRow();
      return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
    }


    static Future<int> getRowCount() async {
      if (_userSheet == null) return 0;

      final lastRow = await _userSheet!.values.lastRow();
      return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
    }

    static Future<List<Ratings>> getAll() async {
      if (_rattingSheet == null) return <Ratings> [];

      final ratings = await _rattingSheet!.values.map.allRows(fromRow: 2);
      return ratings == null ? <Ratings> [] : ratings.map(Ratings.fromJson).toList();
    }
}
