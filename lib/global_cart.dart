import 'package:flutter/material.dart';

// সাধারণ লিস্টের বদলে এটা এখন ValueNotifier (স্মার্ট লিস্ট)!
ValueNotifier<List<Map<String, dynamic>>> globalCartItems = ValueNotifier([]);