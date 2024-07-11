import 'package:flutter_test/flutter_test.dart';

import 'calculater.dart';
void main(){
  Calculater cal=Calculater();;
  // setUpAll(() {
  //   cal=Calculater();
  // },);

 group("i want to test my calculator", () {
   test("i want test addition", () {
     int result=cal.add(5, 5);
     expect(result, 10);
   },);
   test("i want test mulltiply", () {
     int result=cal.mul(5, 5);
     expect(result, 25);
   },);
   test("i want test mulltiply", () {
     int result=cal.sub(5, 5);
     expect(result, 0);
   },);
   
 },);
}