
import 'package:flutter/cupertino.dart';

class Cal {

  String _output = "";
  String _curnum = "";
  String get OutPut => this._output;
  List<String> _s1=[],_s2=[];
  List<double>_s3=[];
  double result = 0;

  static const Key = [
    "9", "8", "7", //
    "6", "5", "4", //
    "3", "2", "1", //
    "0", ".", //
  ];

  //顶部的按钮
  static const TKeys = [
    "C",
    "D",
    "?"
  ];

  static const RKeysMap={
    "/":2,"*":2,"+":1,"-":1
  };//运算级的优先顺序

  //右侧按钮
  static const RKeys = ["/", "*", "-", "+", "="];

  static const EQ = "=";

  void addKey(String key){
    //处理数字到_s1
    if(Key.contains(key)){
      _output +=key;
      _curnum +=key;
    }else{
      _s1.add(_curnum);
      _curnum = "";
      _output += key;
    }

    //处理符号
    if(RKeys.contains(key)){
      if(_s2.length == 0){
        _s2.add(key);
      }else{
        String lastkey = _s2[_s2.length-1];
        if(RKeysMap[key]<=RKeysMap[lastkey]){
          while(_s2.length>0){
            _s1.add(_s2.removeLast());//将_s2中的元素去出存储到_s1
          }
        }
        _s2.add(key);
      }
    }

    if(EQ==key){
      while(_s2.length>0){
        _s1.add(_s2.removeLast());//将_s2中的元素去出存储到_s1
      }

      for(int i=0;i<_s1.length;i++){
        String k = _s1[i];
        if(!RKeys.contains(k)){//RKeys不存在时
          _s3.add(double.parse(k));
        }else{
          switch(k){
            case "+":
              _s3.add(_s3.removeLast()+_s3.removeLast());//最后两个相加
              break;
            case "*":
              _s3.add(_s3.removeLast()*_s3.removeLast());//最后两个相乘
              break;
            case "-":
              double r1 = _s3.removeLast(),r2 = _s3.removeLast();
              _s3.add(r2 - r1);//最后两个相减
              break;
            case "/":
              double r1 = _s3.removeLast(),r2 = _s3.removeLast();
              _s3.add(r2 / r1);//最后两个相除
              break;
          }
        }
      }
      result = _s3[0];
      _output += "$result";
      _s3 = [];
      _s2 = [];
      _s1 = [];
    }
  }
}