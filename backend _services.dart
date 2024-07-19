import 'package:flutter/material.dart';
import 'dart:async';

class BackendService {
  // Simulate fetching data from a backend
  Future<String> fetchData(String endpoint) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'Data from $endpoint';
  }
}
