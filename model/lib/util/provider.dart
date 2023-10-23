import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// T provider<T>(BuildContext context){
//   return Provider.of<T>(context, listen: false);
// }


T provider<T>(BuildContext context,[bool? listen]) {
  return Provider.of<T>(context, listen: listen ?? false);
}

T gProvider<T>(){
  return Provider.of<T>(gContext, listen: false);
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

final BuildContext gContext = scaffoldKey.currentContext!;


