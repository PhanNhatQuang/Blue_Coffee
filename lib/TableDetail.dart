import 'dart:math';

import 'package:flutter/material.dart';
import 'DataHelper.dart';
import 'package:intl/intl.dart';

import 'Menu.dart';
class TableDetail extends StatefulWidget
{
  MyTable m_Table;
  TableDetail(MyTable table)
  {
    this.m_Table = table;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TableDetailState(m_Table);
  }
  
}

class TableDetailState extends State<TableDetail>
{
  MyTable m_Table;
  TableDetailState(MyTable table)
  {
    this.m_Table = table;
  }
  Widget _createListItem(BuildContext context, int index, Drink drink)
  {
    String _drinkName = drink.m_DrinkName;
    int _drinkCount = m_Table.m_OrderList[drink];
    int _drinkPrice = drink.m_Price;
    int _totalMonney = _drinkPrice*_drinkCount;
    return new InkWell( 
      onTap: (){
        Route route = MaterialPageRoute(builder: (context) => TableDetail(m_Table));
        Navigator.of(context).push(route);
      },
      child: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(right: 20.0),
              child: new CircleAvatar(child: new Text('$index'),maxRadius: 25.0, ),
            ),
            new Expanded(            
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text('$_drinkName', 
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                      ),
                      ),
                  new Row(
                    children: <Widget>[
                      new Icon(Icons.local_bar),
                      new Text(': $_drinkCount')
                    ],
                  ),
                  new Text('Giá tiền: $_drinkPrice',
                  style: new TextStyle(
                    color: Colors.green,
                    fontSize: 18
                  ),),
                ],
              ),
            ),
            new Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: new IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: (){
                        if(m_Table.m_OrderList[drink] - 1 > 0)
                        {
                          setState(() {
                            m_Table.m_OrderList[drink]--;
                          });
                          
                    
                        }
                        else
                        {
                          setState(() {
                          m_Table.m_OrderList.remove(drink);
                          });
                        }
                    },
                    iconSize: 25.0,
                    color: Colors.red,
                  )
                ),

            new Column(
                children: <Widget>[
                new Container(
                    child: new Text('$_totalMonney',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 20
                    ),),
                  ),
                  new Container(
                    child: new Text('Thành tiền',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),),
                  )
                ],
              ),

          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    int _tableNumber = m_Table.m_TableID;
    int _drinkCount = 0, _totalMonney = 0;
    String _Date;
    if(m_Table?.m_Date == null)
    {
      m_Table.m_Date = new DateTime.now();
    }
    _Date = DateFormat('kk:mm  dd-MM-yyyy').format(m_Table.m_Date);
    m_Table.m_OrderList.forEach((drink,amount){
      _drinkCount+=amount;
      _totalMonney+=drink.m_Price*amount;
    });
    return new Scaffold(
      floatingActionButton: new IconButton(
                onPressed:(){
                    Navigator.of(context).push<MyTable>(new MaterialPageRoute(builder: (context){
                     return new Menu(m_Table);
                     })).then<MyTable>((onValue){
                       if(onValue?.m_OrderList!=null)
                       {
                        m_Table = onValue; 
                        // int _drinkCount=0 ;
                        // onValue.m_OrderList.forEach((drink,amount){
                        //   _drinkCount+=amount;
                        // });
                        // if(_drinkCount > 0)
                        //   this.m_ListTable.add(onValue);
                       }
                    });
                },
                icon: new Icon(Icons.add_circle),
                iconSize: 60.0,
                color: Colors.green,
              ),
      appBar: new AppBar(title: new Text('BÀN SỐ $_tableNumber')),
      bottomNavigationBar: new Container(
        margin: EdgeInsets.all(10.0),
        child: new RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Tính tiền',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),),
                  onPressed: (){
                    m_Table.m_IsPaid = true;
                    Navigator.of(context).pop(m_Table);
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                ),
      ),
      body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(5.0),
                  child: new Text('Số lượng đã gọi:  $_drinkCount ',
                    style: new TextStyle(
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                      ),
                    ),
                ),

                new Container(
                  padding: EdgeInsets.all(5.0),
                  child: new Text('Giờ bắt đầu: $_Date ',
                    style: new TextStyle(
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                      ),
                    ),
                ),

                new Container(
                  padding: EdgeInsets.all(5.0),
                  child: new Text('Các món đã gọi: ',
                    style: new TextStyle(
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                      ),
                    ),
                ),

                new Flexible(
                  child:new ListView.builder(
                  itemCount: m_Table.m_OrderList.length,
                  itemBuilder: (context, int index){
                  List<Drink> _listDrink = new List<Drink>();
                   m_Table.m_OrderList.forEach(
                     (drink,amout){
                      _listDrink.add(drink);
                    });
                    return _createListItem(context,index,_listDrink[index]);
                  },
                  ),
                ),
                
                new Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Text('Tổng tiền: $_totalMonney ',
                    style: new TextStyle(
                      fontSize: 30.0, 
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                      ),
                    ),
                ),
                

              ],

            )
    );
  }
  
}