import 'package:english_words/english_words.dart';
import 'dart:math';
class Drink{
  int m_DrinkID;
  String m_DrinkName;
  int m_Price;
  Drink(int ID, String Name, int Price)
  {
    this.m_DrinkID = ID;
    this.m_DrinkName = Name;
    this.m_Price = Price;    
  }
}
class MyMenu{
  List<Drink> m_ListDrinks;
  MyMenu(){
    m_ListDrinks = new List<Drink>();
     var listName = generateWordPairs().take(20);
      listName.toList().asMap().forEach((index,Name){
        var drink = new Drink(index,Name.asPascalCase,Random().nextInt(20000));
        m_ListDrinks.add(drink);
      });
  }

  
}

class MyTable{
  int m_TableID;
  Map<Drink,int> m_OrderList;
  DateTime m_Date;
  bool m_IsPaid;
  MyTable(int id)
  {
    this.m_TableID = id;
    m_OrderList = new Map<Drink,int>();
  }
}