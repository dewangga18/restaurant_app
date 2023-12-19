import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:restaurant_app/data/models/arguments/add_review.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/data/models/restaurant_response.dart';
import 'package:restaurant_app/data/models/review_result_response.dart';
import 'package:restaurant_app/data/models/search_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getListData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/list'),
      );
      log(response.request?.url.toString() ?? '-', name: 'GET');
      log(response.body, name: 'RESULT');
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      if (error == SocketException) {
        return RestaurantResponse(
          error: true,
          message: 'Network Error',
        );
      } else {
        return RestaurantResponse(error: true, message: 'Unknown Erorr');
      }
    }
  }

  Future<RestaurantDetailResponse> getDetailData(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/detail/$id'),
      );
      log(response.request?.url.toString() ?? '-', name: 'GET');
      log(response.body, name: 'RESULT');
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      if (error == SocketException) {
        return RestaurantDetailResponse(
          error: true,
          message: 'Network Error',
        );
      } else {
        return RestaurantDetailResponse(error: true, message: 'Unknown Erorr');
      }
    }
  }

  Future<SearchResponse> searchData(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search?q=$query'),
      );
      log(response.request?.url.toString() ?? '-', name: 'GET');
      log(response.body, name: 'RESULT');
      return SearchResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      if (error == SocketException) {
        return SearchResponse(error: true);
      } else {
        return SearchResponse(error: true);
      }
    }
  }

  Future<ReviewResultResponse> addReviewData(AddReview review) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/review'),
        body: review.toJson(),
      );
      log(response.request?.url.toString() ?? '-', name: 'POST');
      log(response.body, name: 'RESULT');
      return ReviewResultResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      if (error == SocketException) {
        return ReviewResultResponse(
          error: true,
          message: 'Network Error',
        );
      } else {
        return ReviewResultResponse(error: true, message: 'Unknown Erorr');
      }
    }
  }
}
