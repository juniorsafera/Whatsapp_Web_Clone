import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {


    final Widget mobile;
    final Widget? tablet;
    final Widget desktop;
  const Responsivo({ Key? key,

    required this.mobile,
    this.tablet,
    required this.desktop,

  
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraits){
              if( constraits.maxWidth >= 1200){
                return desktop;
              } else if( constraits.maxWidth >= 800){
                 Widget? resTablet = this.tablet;
                if( resTablet != null){
                  return resTablet;
                }else{
                  return desktop;
                }
                
              }else{
                return mobile;
              } 
    } 
  )  ;
  }
}