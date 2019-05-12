import 'package:flutter/material.dart';
import 'TableDetail.dart';
import 'Menu.dart';
import 'DataHelper.dart';
import 'dart:math';
class ListTable extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListTableState();
  }
  
}

class ListTableState extends State<ListTable>
{
  ListTableState()
  {
    m_ListTable = new List<MyTable>();
  }
  List<MyTable> m_ListTable = new List<MyTable>();
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  Widget _createListItem(BuildContext context, int index)
  {
    int _drinkCount=0 ;
    int _toTalMonney=0;
    int _tableNumber = this.m_ListTable[index].m_TableID;
    this.m_ListTable[index].m_OrderList.forEach((drink,amount){
      _toTalMonney+= amount*drink.m_Price;
      _drinkCount+=amount;
    });
    return new InkWell( 
      onTap: (){
        Navigator.of(context).push<MyTable>(new MaterialPageRoute(builder: (context){
                     return new TableDetail(m_ListTable[index]);
                     }))..then<MyTable>((onValue){
                      if(onValue.m_IsPaid)
                       {
                          this.m_ListTable.remove(onValue);
                       }
                    });
      },
      child: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(right: 20.0),
              child: new CircleAvatar(child: new Text('$_tableNumber'),maxRadius: 25.0, ),
            ),
            new Expanded(            
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text('Bàn số $_tableNumber', 
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
                  new Text('Tổng tiền: $_toTalMonney',
                  style: new TextStyle(
                    color: Colors.green,
                    fontSize: 18
                  ),),
                ],
              ),
            ),
            new Column(
              children: <Widget>[
                new IconButton(
                  iconSize: 30.0,
                  onPressed: (){
                    Navigator.of(context).push<MyTable>(new MaterialPageRoute(builder: (context){
                     return new TableDetail(m_ListTable[index]);
                     }))..then<MyTable>((onValue){
                       print(onValue.m_TableID);
                      if(onValue?.m_OrderList!=null)
                       {
                          this.m_ListTable.remove(onValue);
                       }
                    });


                  },
                  icon: Icon(Icons.attach_money)
                ),
                new Container(
                  child: new Text('Tính tiền',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),),
                )
              ],
            )
          ],
        ),
      )
    );
  }
   int _itemCount = 0;
    if(this?.m_ListTable != null)
    {
      _itemCount = m_ListTable.length; 
    }
    var scaffold = Scaffold(
          floatingActionButton: new IconButton(
                onPressed:(){
                   Navigator.of(context).push<MyTable>(new MaterialPageRoute(builder: (context){
                     var table = new MyTable(Random().nextInt(99));
                     return new Menu(table);
                     }))..then<MyTable>((onValue){
                       if(onValue?.m_OrderList!=null)
                       {
                        int _drinkCount=0 ;
                        onValue.m_OrderList.forEach((drink,amount){
                          _drinkCount+=amount;
                          print(amount);
                        });
                        if(_drinkCount > 0)
                          this.m_ListTable.add(onValue);
                       }
                    });
                 
                },
                icon: new Icon(Icons.add_circle),
                iconSize: 60.0,
                color: Colors.green,
              ),
          appBar: new AppBar(title: new Text( "Danh sách bàn."),),
          body: new ListView.builder(
                  itemCount:_itemCount, 
                  itemBuilder: (context, int index){
                    return _createListItem(context,index); 
                  },
              ),  
          
        );
       
    return scaffold;
  }

}