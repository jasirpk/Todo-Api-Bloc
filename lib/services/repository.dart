import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchdata() async {
  try {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['items'];
    }
    return [];
  } catch (e) {
    throw Exception(e.toString());
  }
}

submitData(String title, String description) async {
  final body = {"title": title, "description": description};
  final url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  try {
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      print('Success');
      return 'success';
    }
  } catch (e) {
    throw Exception(e);
  }
}

updateData(String id, String title, String descritpion) async {
  try {
    final body = dataProviderEditData(title, descritpion);
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return 'success';
    } else {}
  } catch (e) {
    return 'failure';
  }
}

Future<http.Response> deletebyid(String id) async {
  try {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response;
  } catch (e) {
    return http.Response('error deleting data:$e', 500);
  }
}

deleteData(String id) async {
  try {
    final response = await deletebyid(id);
    if (response.statusCode == 200) {
      return 'success';
    }
  } catch (e) {
    return 'failure';
  }
}

Map<String, String> dataProviderEditData(String title, String description) {
  final body = {"title": title, "description": description};
  return body;
}
