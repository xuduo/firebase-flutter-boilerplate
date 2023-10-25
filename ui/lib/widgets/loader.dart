
import 'package:model/data/data.dart';
import 'package:flutter/material.dart';

Widget load(Data data,Widget Function() func){
  if(data.errorMessage != null){
    return Center(
      child: Text(
        data.errorMessage!,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
    );
  }
  if(data.data == null){
    return Center(child: CircularProgressIndicator());
  }
  return func();
}