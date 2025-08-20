

import 'package:flutter/material.dart';



class NavController extends ChangeNotifier{
  // index of the current page.
  int index = 0;
  
  //getter
  int get currentIndex => index;

  //setter
  void setIndex (int i ){
    if(i == index) return;
    index = i;
    notifyListeners();

  }
  

}