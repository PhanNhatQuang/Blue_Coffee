import 'package:flutter/material.dart';
import 'DataHelper.dart';
class Menu extends StatefulWidget
{
  MyTable m_Table;
  Menu(MyTable table ){
    this.m_Table = table;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    
    return new MenuState(m_Table);
  }
  
}

class MenuState extends State<Menu>
{
  
  MyTable m_Table;
  MenuState(MyTable table)
  {
    this.m_Table = table;
  }
  MyMenu m_Menu = new MyMenu();
  Widget _createMenuItem(String name,int index, int count)
  {
    int itemcount = count;
    return new Container( 
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
            new Container(
                child: new CircleAvatar(maxRadius: 25.0,),
              ),

            new Expanded(
              child: new Container(
                margin: EdgeInsets.only(left: 10.0),
                child: new Text('$name',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.blue,
                ),
                ),
              ),
              ),

            new Container(
              child: new Row(
                children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.remove_circle),
                  color: Colors.red,
                  iconSize: 30.0,
                  onPressed: (){
                    setState(() {
                      if(this?.m_Table?.m_OrderList != null)
                      {
                        Map<Drink,int> _toRemove = new Map<Drink,int> ();
                        m_Table.m_OrderList.forEach((drink,amount){
                          if(drink.m_DrinkID == m_Menu.m_ListDrinks[index].m_DrinkID)
                          {
                            if(amount - 1 > 0)
                            {
                              amount--;
                              m_Table.m_OrderList[drink] = amount;
                            }
                            else 
                            {
                              _toRemove.addAll({drink:amount});
                            }
                          }
                        });
                        m_Table.m_OrderList.removeWhere((e,i)=>_toRemove.containsKey(e));
                      }
                    });
                  },
                ),
                new Container(
                  child: new Text('$itemcount',
                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                ),
                new IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.blue,
                  iconSize: 30.0,
                  onPressed: (){
                    setState(() {
                      if(this?.m_Table?.m_OrderList != null)
                      {
                        if(m_Table.m_OrderList.containsKey(m_Menu.m_ListDrinks[index]))
                        {
                          m_Table.m_OrderList.forEach((drink,amount){
                            if(drink.m_DrinkID == m_Menu.m_ListDrinks[index].m_DrinkID)
                            {
                              amount++;
                              m_Table.m_OrderList[drink] = amount;
                            }
                          });
                        }
                        else
                        {
                          m_Table.m_OrderList.addAll({
                            m_Menu.m_ListDrinks[index]:1,
                          });
                        }
                      }
                      else
                      {
                         m_Table.m_OrderList.addAll({
                            m_Menu.m_ListDrinks[index]:1,
                          });
                      }
                    });
                  },
                )
              ], 
              )
            ) 

        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Menu')),
      body: new ListView.builder(
        itemCount: m_Menu.m_ListDrinks.length,
        itemBuilder: (context, int index){
            int drinkCount = 0;
            if(this?.m_Table?.m_OrderList != null)
            {
              m_Table.m_OrderList.forEach((tableDrink, amount){
                if(m_Menu.m_ListDrinks[index].m_DrinkID == tableDrink.m_DrinkID)
                {
                  drinkCount = amount;
                }
              });
            }
            return _createMenuItem(m_Menu.m_ListDrinks[index].m_DrinkName, index, drinkCount);
        },
        
      ),
      bottomNavigationBar: new Container(
        margin: EdgeInsets.all(10.0),
        child: new RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  child: Text('XONG',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),),
                  onPressed: (){
                    m_Table.m_Date = new DateTime.now();
                    Navigator.of(context).pop(m_Table);
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                ),
      ),
    );
  }
  
}