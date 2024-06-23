import 'package:http/http.dart' as http;

void httpResponseHandler(http.Response response) {
  if (response.statusCode != 200) {
    throw Exception(
        'Error!. Status code: ${response.statusCode}. Response body: ${response.body}');
  }
}
