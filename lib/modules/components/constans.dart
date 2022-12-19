import 'package:flutter/material.dart';

void NavigateTo(context, dynamic route) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => route,
    ));
void NavigateAndReplase(context, dynamic route) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => route), (route) => false);

dynamic token = '';
