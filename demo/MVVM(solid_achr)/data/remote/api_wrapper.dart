import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zero_admin/data/data.dart';

import '../../models/models.dart';
import '../../res/res.dart';
import '../../utils/utils.dart';

/// API WRAPPER to call all the APIs and handle the status codes
class ApiWrapper {
  final dbWrapper = Get.find<DBWrapper>();

  /// Method to make all the requests inside the app like GET, POST, PUT, Delete
  Future<ResponseModel> makeRequest(
    String api, {
    String? baseUrl,
    required Request type,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    dynamic payload,
    String field = '',
    String filePath = '',
    bool showLoader = false,
    bool showDialog = true,
  }) async {
    assert(
      type != Request.upload ||
          (type == Request.upload &&
              payload is! Map<String, String> &&
              field.isNotEmpty &&
              filePath.isNotEmpty),
      'if type is passed as [Request.upload] then payload must be of type Map<String, String> and field & filePath must not be empty',
    );

    // /// To see whether the network is available or not
    // var uri = (baseUrl ?? Apis.baseUrl) + api;
    // AppLog.info('[Request] - $type - $uri\n$payload');
    // if (headers['authorization'].isNullOrEmpty) {
    //   AppLog.error('Authorization error - $headers');
    //   return ResponseModel.message('Token not found', statusCode: 400);
    // }

    if (showLoader) Utility.showLoader();
    if (await Utility.isNetworkAvailable) {
      try {
        // Handles API call
        var start = DateTime.now();
        var response = await _handleRequest(
          api,
          type: type,
          headers: headers,
          payload: payload,
          field: field,
          filePath: filePath,
        );

        // Handles response based on status code
        var res = await _processResponse(
          response,
          showDialog: showDialog,
          startTime: start,
        );
        if (showLoader) {
          Utility.closeLoader();
        }
        if (res.statusCode != 406) {
          return res;
        }
        return makeRequest(
          api,
          baseUrl: baseUrl,
          type: type,
          headers: headers,
          payload: payload,
          field: field,
          filePath: filePath,
          showDialog: showDialog,
          showLoader: showDialog,
        );
      } on TimeoutException catch (e, st) {
        AppLog.error('TimeOutException - $e', st);
        if (showLoader) {
          Utility.closeLoader();
        }
        await Future.delayed(const Duration(milliseconds: 100));
        var res = ResponseModel.message(StringConstants.timeoutError);
        if (showDialog) {
          await Utility.showInfoDialog(res);
        }
        return res;
      } catch (e, st) {
        AppLog.error(e, st);
        if (showLoader) {
          Utility.closeLoader();
        }
        await Future.delayed(const Duration(milliseconds: 100));
        var res = ResponseModel.message(StringConstants.somethingWentWrong);

        if (showDialog) {
          await Utility.showInfoDialog(res);
        }
        return res;
      }
    } else {
      AppLog.error('No Internet Connection', StackTrace.current);
      if (showLoader) {
        Utility.closeLoader();
      }
      await Future.delayed(const Duration(milliseconds: 100));
      var res = ResponseModel.message(StringConstants.noInternet);

      if (showDialog) {
        await Utility.showInfoDialog(res);
      }
      return res;
    }
  }

  Future<http.Response> _handleRequest(
    String api, {
    required Request type,
    required Map<String, String> headers,
    required String field,
    required String filePath,
    dynamic payload,
  }) async {
    AppLog.info('url -> $api\n body -> $payload');
    switch (type) {
      case Request.get:
        return _get(api, headers: headers);
      case Request.post:
        return _post(api, payload: payload, headers: headers);
      case Request.postWithoutEncode:
        return _postWithoutEncode(api, payload: payload, headers: headers);
      case Request.put:
        return _put(api, payload: payload, headers: headers);
      case Request.patch:
        return _patch(api, payload: payload, headers: headers);
      case Request.delete:
        return _delete(api, payload: payload, headers: headers);
      case Request.upload:
        return _upload(
          api,
          payload: payload,
          headers: headers,
          field: field,
          filePath: filePath,
        );
    }
  }

  Future<http.Response> _get(
    String api, {
    required Map<String, String> headers,
  }) async =>
      await http
          .get(
            Uri.parse(api),
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  Future<http.Response> _post(
    String api, {
    required dynamic payload,
    required Map<String, String> headers,
  }) async =>
      await http
          .post(
            Uri.parse(api),
            body: jsonEncode(payload),
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  Future<http.Response> _postWithoutEncode(
    String api, {
    required dynamic payload,
    required Map<String, String> headers,
  }) async =>
      await http
          .post(
            Uri.parse(api),
            body: payload,
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  Future<http.Response> _put(
    String api, {
    required dynamic payload,
    required Map<String, String> headers,
  }) async =>
      await http
          .put(
            Uri.parse(api),
            body: jsonEncode(payload),
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  Future<http.Response> _patch(
    String api, {
    required dynamic payload,
    required Map<String, String> headers,
  }) async =>
      await http
          .patch(
            Uri.parse(api),
            body: payload == null ? null : jsonEncode(payload),
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  Future<http.Response> _delete(
    String api, {
    required dynamic payload,
    required Map<String, String> headers,
  }) async =>
      await http
          .delete(
            Uri.parse(api),
            body: payload == null ? null : jsonEncode(payload),
            headers: headers,
          )
          .timeout(AppConstants.timeOutDuration);

  /// Method to make all the requests inside the app like GET, POST, PUT, Delete
  Future<http.Response> _upload(
    String api, {
    required Map<String, String> payload,
    required Map<String, String> headers,
    required String field,
    required String filePath,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api),
    )
      ..headers.addAll(headers)
      ..fields.addAll(payload)
      ..files.add(
        await http.MultipartFile.fromPath(field, filePath),
      );

    var response = await request.send();

    return await http.Response.fromStream(response);
  }

  Future<ResponseModel> _processResponse(
    http.Response response, {
    required bool showDialog,
    required DateTime startTime,
  }) async {
    try {
      var diff = DateTime.now().difference(startTime).inMilliseconds / 1000;
      AppLog(
          '[Response] - $diff s ${response.request?.method} statusCode-${response.statusCode}\n${response.request?.url}\n${response.body}');

      switch (response.statusCode) {
        case 200:
        case 201:
          return ResponseModel(
            data: utf8.decode(response.bodyBytes),
            hasError: false,
            statusCode: response.statusCode,
          );
        case 498:

          /// Token expired and navigate to the splash screen
          dbWrapper.deleteBox();
          RouteManagement.goOfAllSplash();
          return ResponseModel(
            data: utf8.decode(response.bodyBytes),
            hasError: true,
            statusCode: response.statusCode,
          );

        case 500:
          // Server error - Show dialog if required
          var res = ResponseModel.message(
            'Server error',
            statusCode: response.statusCode,
          );
          if (showDialog) {
            await Utility.showInfoDialog(res);
          }
          return res;

        default:
          return ResponseModel(
            data: utf8.decode(response.bodyBytes),
            hasError: true,
            statusCode: response.statusCode,
          );
      }
    } catch (error) {
      // Handle unexpected errors here
      AppLog('[Error] - ${error.toString()}');
      return const ResponseModel(
        data: 'An unexpected error occurred',
        hasError: true,
        statusCode: 500,
      );
    }
  }
}
