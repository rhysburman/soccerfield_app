import 'package:form_making_practice/blocs/models/ratings.dart';
import 'package:form_making_practice/blocs/models/user.dart';
import 'package:gsheets/gsheets.dart';

class DataService {
  static const _credentials = r''' {
   "type": "service_account",
  "project_id": "pristine-flames-338922",
  "private_key_id": "12a207b8bf32e4d1ebf4ccd0af3e5131cc16e98e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCw9d1K/0fkMiKX\nEA/Ggfz+k5gARJFE2tO15ClD8DG0f6AJvDoK2/JefS1mhxKKX8V7ThtOcYp94Wyn\nsFOHbPJSPtSs3axVZjBSnc+xAQiONrH5WAYJfygE62e/tyLa31qLma79G8QWb5AU\nMU1yHGzLnMVMehX2+FDRrTJBd5Q3qqcATjWhVombWk2jzycbhawhwTdzX6Qx7H//\nu7aD5bqH7d+vawcZDaxX1L6X4N3vxmqQjUFQxEg4lzg8dz+vEhbokgeqFWUdDADg\nUcKvg0N2FbWRpy7wUHh/hw4WwvVeHy5ndt+B/0TqlDGA+HVfOuJqyJ35y53UFNFO\nYorErAhHAgMBAAECggEAAO01/JkL8Cgftz5zHrJ6jSi1BeIAsrrEm1y3p0Pq4WDp\nCR6uXR/cC95IQ75W/K4rXg3Bey6BWk8OXxhqGjjvUeVDVCkQUx18Xkpg690vWsid\niPU1iYzcEZ6Gm2Hi8at0EWwQwawzYXyxupwBevn8IIV7IP84qI48pMRtPBuGBVPs\nr+TOVRpuY26rxecV9TunXs8pFw1tTQegc5m8jqTvWLBIONqM4+DwNKlnK/bK/3SU\nXakS4YJipbOlZ8ARcOwIWCwbB9IfTd7dEcpBvgcy09/74QV4AU0TeM9951a2i2SY\nlBIXa807sAsnSiw+0+QaXyTOFwrUX+3LrTgw0Rv6pQKBgQDur7vh6LyA7R1y1Xz/\nmk6Z0aPf40H3BnRBIr8UkucBUX023KAJ7ptYTn0P2TSEn4ehTc6zbVCHVPJAHlq+\nUyicIwKGRn2IsG2YeUjjPYBu23auqC7/kSm4/Zm66WqUFQ4zyZM7cP1+tY/TSRTY\ntALX6McNayREbVs4Mk5t8zOl9QKBgQC9y+oPp57Dxy8mOHtJtPpx0+I8LOLaNdfe\n9TczID9CQkeyS7By1kb/an07FzleuR+2TrmsqTC+9ZP67iOS5bEVKe8XA/34CAiC\nBk84gNnIvNQtE/r2eZLWeCHB9Y6tDIk6xaxRtsBCVTaZKDJwLjFBZySTh+AbSn+0\nc5VEQaVTywKBgBfPvESbPUL3ZLqyBZhSQokh2uFZAJmuMSbWWo2o4hbFlGJGvEiB\nX0n9+of8OTsJ1zQGWRqZSzFVDh3LaW4XSbPZ4kSW/6sFPsm5P8Y7unZUupBOAvJH\n/wuPcSiuZI2FVDdiYqfJa+CaKFEBt2yu+KGlfUYfbCzPZAxFKIHbg0mJAoGAS9Ib\nZjebODDpSAaGUhKnfjOcDFgOJAggfeROMfFu9ARQagzMp4Oshzq+Xo3PkGS6I3Vd\nvXk1jQPEIxlhQrzZuk+vQO2KVry20WK94R+wYP32cS+rMS2uGFmTes2jOsRoSf9P\n8LDmK1mpXxPs2l3JtYwD06ATSjO/wpHuDn9/EXMCgYBfcYn80c55SPGmV+x21/eg\nvuLlad1W0B2cGkW1ytV2L+B+OXOSYgzJic11ne9Zxlhb96QxefS1msRGq8ajD4oo\n8SZ19+xZdFoVM9+lYmFpgVbGxcZDJgqte7XUqrHTkK79/mGPdwbzyfKq4mcOuFay\nFp7Bh3xRTgCJvbvfUhPdAw==\n-----END PRIVATE KEY-----\n",
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
