//+------------------------------------------------------------------+
//|                                                      fibo ea.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//|                                    Developped by ismail el mekki |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Developped by ismail el mekki idea Dr maher alsaif"
#property link      "https://t.me/IsmailMekki"
#property version   "1.00"
#include <lib_fibo_hedge.mqh>
#include  <Trade\Trade.mqh>

input bool autotrade=false;
input bool FREEMARGINCLOSE=true;
input   string   Fibo_Trade_EA_V1_Parameters = "=============== Fibo_Trade_EA_V1 ================================";
input   int      Hour_Start_Trade = 1;
input   int      Hour_Stop_Trade = 23;
input   int      LastMinute = 50;
input double     Commission=5;
input   string   Order_Parameters = "============== Order - Parameters =============================";
input bool Trade_in_level_1=true;
input uint MagicNumber_level1=1111;
input string   op1= "---------- Sell_Limit_Pending_Order_Level1 ----------";
input bool Sell_Limit_Pending_Order_Level1=true;

input double Sell_Limit_Percent_Target_Profit1=20;
input double Sell_Limit_Percent_StopLoss1=20;
input double Sell_Limit_lot_level1=0.01;
input string   op2= "---------- Sell_Stop_Pending_Order_Level1 ----------";
input bool Sell_Stop_Pending_Order_Level1=true;

input double Sell_Stop_Percent_Target_Profit1=20;
input double Sell_Stop_Percent_StopLoss1=20;
input double Sell_Stop_lot_level1=0.01;
input string   op3= "---------- Buy_Limit_Pending_Order_Level1 ----------";
input bool Buy_Limit_Pending_Order_Level1=true;

input double Buy_Limit_Percent_Target_Profit1=20;
input double Buy_Limit_Percent_StopLoss1=20;
input double Buy_Limit_lot_level1=0.01;
input string   op4= "---------- Buy_Stop_Pending_Order_Level1 ----------";
input bool Buy_Stop_Pending_Order_Level1=true;

input double Buy_Stop_Percent_Target_Profit1=20;
input double Buy_Stop_Percent_StopLoss1=20;
input double Buy_Stop_lot_level1=0.01;

input ENUM_TIMEFRAMES Timeframe1 = PERIOD_H1 ; // TimeFrame Fibo Level-1
input int max_trade_level1=10;
input string spt0="===========================================";
input bool Trade_in_level_2=true;
input uint MagicNumber_level2=2222;
input string   op5= "---------- Sell_Limit_Pending_Order_Level2 ----------";
input bool Sell_Limit_Pending_Order_Level2=true;

input double Sell_Limit_Percent_Target_Profit2=20;
input double Sell_Limit_Percent_StopLoss2=20;
input double Sell_Limit_lot_level2=0.01;
input string   op6= "---------- Sell_Stop_Pending_Order_Level2 ----------";
input bool Sell_Stop_Pending_Order_Level2=true;

input double Sell_Stop_Percent_Target_Profit2=20;
input double Sell_Stop_Percent_StopLoss2=20;
input double Sell_Stop_lot_level2=0.01;
input string   op7= "---------- Buy_Limit_Pending_Order_Level2 ----------";
input bool Buy_Limit_Pending_Order_Level2=true;

input double Buy_Limit_Percent_Target_Profit2=20;
input double Buy_Limit_Percent_StopLoss2=20;
input double Buy_Limit_lot_level2=0.01;
input string   op8= "---------- Buy_Stop_Pending_Order_Level2 ----------";
input bool Buy_Stop_Pending_Order_Level2=true;

input double Buy_Stop_Percent_Target_Profit2=20;
input double Buy_Stop_Percent_StopLoss2=20;
input double Buy_Stop_lot_level2=0.01;

input ENUM_TIMEFRAMES Timeframe2 = PERIOD_M15 ; // TimeFrame Fibo Level-2
input int max_trade_level2=10;
input string spt1="===========================================";
input bool Trade_in_level_3=true;
input uint MagicNumber_level3=3333;

input string   op9= "---------- Sell_Limit_Pending_Order_Level3 ----------";
input bool Sell_Limit_Pending_Order_Level3=true;

input double Sell_Limit_Percent_Target_Profit3=20;
input double Sell_Limit_Percent_StopLoss3=20;
input double Sell_Limit_lot_level3=0.01;
input string   op10= "---------- Sell_Stop_Pending_Order_Level3 ----------";
input bool Sell_Stop_Pending_Order_Level3=true;

input double Sell_Stop_Percent_Target_Profit3=20;
input double Sell_Stop_Percent_StopLoss3=20;
input double Sell_Stop_lot_level3=0.01;
input string   op11= "---------- Buy_Limit_Pending_Order_Level3 ----------";
input bool Buy_Limit_Pending_Order_Level3=true;

input double Buy_Limit_Percent_Target_Profit3=20;
input double Buy_Limit_Percent_StopLoss3=20;
input double Buy_Limit_lot_level3=0.01;
input string   op12= "---------- Buy_Stop_Pending_Order_Level3 ----------";
input bool Buy_Stop_Pending_Order_Level3=true;

input double Buy_Stop_Percent_Target_Profit3=20;
input double Buy_Stop_Percent_StopLoss3=20;
input double Buy_Stop_lot_level3=0.01;

input ENUM_TIMEFRAMES Timeframe3 = PERIOD_M1 ; // TimeFrame Fibo Level-3
input int max_trade_level3=10;
input string spt2="===========================================";
//---------------------------------------------------------------------------------------+
//input ENUM_LINE_STYLE InpStyle=STYLE_DASHDOTDOT; // Line style
enum ENUM_METHOD
  {
   METHOD_1=0,//METHOD_1 :Enter the value of the highest and  lowghest Fibo 
   METHOD_2=1,//METHOD_2 :Enter the number of monthly candles 
   METHOD_3=2,//METHOD_3 :Enter the TimeFrame and index of candle
  };
  enum ENUM_STYLE
  {
   STYLE_0 =STYLE_SOLID	    ,//	Solid line
   STYLE_1 =STYLE_DASH 	    ,//	Dashed line
   STYLE_2 =STYLE_DOT	    ,//	Dotted line
   STYLE_3 =STYLE_DASHDOT   ,//	Dash-and-dot line
   STYLE_4 =STYLE_DASHDOTDOT,//	Double dotted dash-and-dot line

  };
    enum ENUM_WIDTH
  {
   WIDTH_0=0,//WIDTH_0 :0
   WIDTH_1=1,//WIDTH_1 :1
   WIDTH_2=2,//WIDTH_2 :2
   WIDTH_3=3,//WIDTH_3 :3
   WIDTH_4=4,//WIDTH_4 :4
  };
input ENUM_METHOD Method=METHOD_3;// Choosing a method for determining the highest and lowest Fibo 
input string sp="-----------------------------  METHOD_1  ------------------------------------";
input string s0="Enter the value of the highest and  lowghest Fibonacci value";
input double HightValue=99999;
input double LowValue=000000;
input string sp1="-----------------------------  METHOD_2  ------------------------------------";
input string s1="Enter the number of monthly candles";
input int Numberofcandles=5;
input string sp2="-----------------------------  METHOD_3  ------------------------------------";
input string TimeFrame="Enter the TimeFrame and index of candle";
input ENUM_TIMEFRAMES Timeframe = PERIOD_MN1 ; // TimeFrame Fibo Level-1
input int index1=1;
input string s001="============================================================================";
input bool display_level1=false;
input string ColorFiboLevel_1="Option Color and width Fibo Level-1";
input color  InpColor1=clrBlue;       // Color Fibo Level-1
input ENUM_WIDTH width_fibo_1=WIDTH_3;// Choosing  Fibo width 
input ENUM_STYLE style_fibo_1=STYLE_1;// Choosing  Fibo style 
input string s2="============================================================================";
input bool display_level2=false;
input string ColorFiboLevel_2="Option Color and width Fibo Level-2";
input color  InpColor2_1=clrAqua;       // Line1
input color  InpColor2_2=clrBlack;       // Line2
input color  InpColor2_3=clrBrown;       // Line3
input color  InpColor2_4=clrCyan;       // Line4
input color  InpColor2_5=clrGold;       // Line5
input ENUM_WIDTH width_fibo_2=WIDTH_1;// Choosing  Fibo width 
input ENUM_STYLE style_fibo_2=STYLE_1;// Choosing  Fibo style 
input string s3="=============================================================================";
input bool display_level3=false;
input string ColorFiboLevel_3="Option Color and width Fibo Level-3";
input color  InpColor3=clrBlue;       // Color Fibo Level-3
input ENUM_WIDTH width_fibo_3=WIDTH_1;// Choosing  Fibo width 
input ENUM_STYLE style_fibo_3=STYLE_1;// Choosing  Fibo style 
//-----------------------------------------------------------------------------------------------+
input ENUM_TIMEFRAMES strper = PERIOD_W1 ;
input double power=80.0;
//-----------------------------------------------------------------------------------------------+
color tab_color[7];  
double tab_percent[12];
double  cHigh=0.0,cLow=0.0;
double hight_index_level=0;
int low_index_level=0;
int LEVEL;
int current_zone=0,last_zone=0;
double up=EMPTY_VALUE,down=EMPTY_VALUE;
MqlRates Priceinformation[];
int Saved_Variable_Old_Period = Period();
bool exist=false;
string zone="";
//-------- Level 1  --------//
double tab_fibo1[13]; 
double tab_fibo2[13];
//-------- Level 2  --------//
Fibo_tab2 F_tab_2_1;
Fibo_tab2 F_tab_2_2;
//-------- Level 3  --------//
Fibo_tab F_tab_3_up[12];
Fibo_tab F_tab_3_down[12];
bool c=false;
//----------------------------
Fibo_Trade Trade_level1[25];
//---------------------------
Fibo_Trade Trade_level2[145];
double tab_trade2_1[73]; 
double tab_trade2_2[73];
//---------------------------
Fibo_Trade Trade_level3[877];
double tab_trade3_1[439]; 
double tab_trade3_2[439];
double point;
int  low_index_price,high_index_price;
CTrade trade;
int count=0;

Order_Trade t[];
MqlDateTime dt_struct;
bool block=false;
//------------------
double Percent_Target_Profit[];
double Percent_StopLoss[];
double H=9999,L=-999;
MqlDateTime dt_structH;
MqlDateTime dt_structL;
//------------------
 datetime timeHigh,timeLow;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--  

Calcul_HighLow_Fibo();
H=cHigh;
L=cLow;
INIT_FIBO();
INIT_EXPERT();
FIBO();
if(Saved_Variable_Old_Period!=Period()){
 //--- intiatitation Fibo 
          INIT_FIBO();
 //--- intiatitation expert
          INIT_EXPERT();
           ObjectsDeleteAll(0);
               FIBO();
               }
//---------------------------------------------------------------
  if(ChartGetInteger(0,CHART_SHOW_OBJECT_DESCR)==1)
     ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
    
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectsDeleteAll(0);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


 //---
   Information_Price();
     static datetime previousBar1;
   if(previousBar1!=iTime(_Symbol,PERIOD_D1,0))
     {
      previousBar1=iTime(_Symbol,PERIOD_D1,0);
   
    Calcul_HighLow_Fibo();
   if(H!=cHigh && L!=cLow)
     {
     H=cHigh;
     L=cLow;
    //--- intiatitation Fibo 
     INIT_FIBO();
     //--- intiatitation expert
     INIT_EXPERT();
        ObjectsDeleteAll(0);
       //--- intiatitation Fibo 
       FIBO();
     }
     }

  static datetime previousBar;
   if(previousBar!=iTime(_Symbol,PERIOD_M15,0))
     {
      previousBar=iTime(_Symbol,PERIOD_M15,0);
       ObjectsDeleteAll(0);
       //--- intiatitation Fibo 
       FIBO();
      if(ChartGetInteger(0,CHART_SHOW_OBJECT_DESCR)==1)
      ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
       ChartRedraw();
     }
   else
     {
  
   datetime dtSer=TimeCurrent(dt_struct); 
   if (IsTradeTime())
   {
     if(autotrade==true && block==false)
       EXPERT();
   }
   if(AccountInfoDouble(ACCOUNT_FREEMARGIN)<(AccountInfoDouble(ACCOUNT_BALANCE)/2) && FREEMARGINCLOSE==true)
   {
   delelete_all_pending_order();
   block=true;
   }else {block=false;}
    //---------------------
     // return;
     }

  }
//+--------------------------------------------------------------------------------------+
// -------- Calcul High Low Fibo-1 ------------------------------------------------------+
//---------------------------------------------------------------------------------------+
void Calcul_HighLow_Fibo()
{

switch(Method)
{
case 0:Method1();break;
case 1:Method2();break;
case 2:Method3();break;
}

}
//--- METHOD_1 ------------------------------------------------------------+
void Method1()
{
cHigh=HightValue;
cLow=LowValue;
}
//--- METHOD_2 ------------------------------------------------------------+
void Method2()
{
// create variable for highewt candle
int Highestcandle;
// create variable for lowewt candle
int lowestcandle;
// create arrays for highest candle
double High[];
// create arrays for lowest candle
double Low[];
// sort High array downwards from the current candle
ArraySetAsSeries(High,true);
// sort Low array downwards from the current candle
ArraySetAsSeries(Low,true);
// Fill array with data for x numner candles
CopyHigh(Symbol(),PERIOD_MN1,0,Numberofcandles,High);
// Fill array with data for x numner candles
CopyLow(Symbol(),PERIOD_MN1,0,Numberofcandles,Low);
Highestcandle=ArrayMaximum(High,0,Numberofcandles);
lowestcandle=ArrayMinimum(Low,0,Numberofcandles);
Information_Price();
cHigh=Priceinformation[Highestcandle].high;
cLow=Priceinformation[lowestcandle].low;
}
//--- METHOD_3 ------------------------------------------------------------------------------------------------------------+
void Method3()
{
 cHigh = NormalizeDouble(iHigh(Symbol(),Timeframe,index1),Digits());
 cLow = NormalizeDouble(iLow(Symbol(),Timeframe,index1),Digits());
}
//----------------------------------------------------------------------+
//----------------------------------------------------------------------+
void Load_color()
{
tab_color[0]=InpColor1;
tab_color[1]=InpColor2_1;
tab_color[2]=InpColor2_2;
tab_color[3]=InpColor2_3;
tab_color[4]=InpColor2_4;
tab_color[5]=InpColor2_5;
tab_color[6]=InpColor3;
}
//----------------------------------------------------------------------------------------------------------------------------------//
void create_fibox(int begin,int end,double &tab[],double &tab_p[],string trend,int level)
{
string com="";
if(level==1)
{
for(int i=begin;i<end;i++)
{
com=create_comment(i,trend);
create_linex(DoubleToString(tab[i]),tab[i],InpColor1,width_fibo_1,style_fibo_1,com);
}

}
//------
if(level==2 )
{

for(int i=begin;i<end;i++)
{
//com="("+DoubleToString(tab_p[i])+" %)";
//if(!ObjectFind(0,DoubleToString(tab[i])))
create_linex(DoubleToString(tab[i]),tab[i],tab_color[i],width_fibo_2,style_fibo_2,com);
}
}
//------
if(level==3)
{
for(int i=begin;i<end;i++)
{
//com="("+DoubleToString(tab_p[i])+" %)";
//if(!ObjectFind(0,DoubleToString(tab[i])))
create_linex(DoubleToString(tab[i]),tab[i],InpColor3,width_fibo_3,style_fibo_3,com);
}
}
}
//--------- create line fibo
void create_linex(string name,double value,color clr,int width,int style,string comment)
{
ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,true);      
ObjectCreate(0,name,OBJ_HLINE,0,0,value);
ObjectSetInteger(0,name,OBJPROP_LEVELS,1);
ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
ObjectSetInteger(0,name,OBJPROP_WIDTH,width);
ObjectSetInteger(0,name,OBJPROP_STYLE,style);
ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
string txth=comment;
ObjectSetString(0,DoubleToString(value),OBJPROP_TEXT,txth);
ObjectSetDouble(0,DoubleToString(value),OBJPROP_LEVELVALUE,0,2.5);
ObjectSetInteger(0,DoubleToString(value),OBJPROP_RAY_RIGHT,true);
}
//-----------------------------------------------------------------------------------------------------------------------------------//
void Information_Price()
{
// sort it from current candle to oldest candle 
ArraySetAsSeries(Priceinformation,true);
// copy price data in to the array 
int data= CopyRates(Symbol(),PERIOD_CURRENT,0,Bars(Symbol(),PERIOD_CURRENT),Priceinformation);
}
//-------------------------------------------------------------------------------------------+
void find_lowlevel_highlevel(double price,double &tab1[],double &tab2[])
{


//--- search betwen low and high fibo up
for(int i=0;i<12;i++)
{
if(price>tab1[i] && price<tab1[i+1])
{
low_index_level=i;
hight_index_level=i+1;
zone="zone1";
break;
}
}
//--- search betwen low and high fibo down
for(int i=0;i<12;i++)
{
if(price>tab2[i] && price<tab2[i+1])
{
low_index_level=i;
hight_index_level=i+1;
zone="zone2";
break;
}
}
}
//-------------------------------------------------------------------------------------------+
void INIT_FIBO()
{
init_tab(tab_percent);  
Calcul_HighLow_Fibo();
Load_color();
//-------------------------------------------------------------------+
//---- calcul fibo level 1
caclul_fibo_up(cHigh,cLow,tab_fibo1,tab_percent,0,12);
caclul_fibo_down(cHigh,cLow,tab_fibo2,tab_percent,0,12);
//-------------------------------------------------------------------+
//---- calcul fibo level 2
F_tab_2_1.calcul_fibo_up(tab_fibo1,tab_percent,0,6);
//-----
F_tab_2_2.calcul_fibo_down(tab_fibo2,tab_percent,0,6);
//-------------------------------------------------------------------+
//---- calcul fibo level 3
 F_tab_3_up[0].calcul_fibo_up(F_tab_2_1.tab_fibo1,tab_percent,0,6);
 F_tab_3_up[1].calcul_fibo_up(F_tab_2_1.tab_fibo2,tab_percent,0,6);
 F_tab_3_up[2].calcul_fibo_up(F_tab_2_1.tab_fibo3,tab_percent,0,6);
 F_tab_3_up[3].calcul_fibo_up(F_tab_2_1.tab_fibo4,tab_percent,0,6);
 F_tab_3_up[4].calcul_fibo_up(F_tab_2_1.tab_fibo5,tab_percent,0,6);
 F_tab_3_up[5].calcul_fibo_up(F_tab_2_1.tab_fibo6,tab_percent,0,6);
 F_tab_3_up[6].calcul_fibo_up(F_tab_2_1.tab_fibo7,tab_percent,0,6);
 F_tab_3_up[7].calcul_fibo_up(F_tab_2_1.tab_fibo8,tab_percent,0,6);
 F_tab_3_up[8].calcul_fibo_up(F_tab_2_1.tab_fibo9,tab_percent,0,6);
 F_tab_3_up[9].calcul_fibo_up(F_tab_2_1.tab_fibo10,tab_percent,0,6);
 F_tab_3_up[10].calcul_fibo_up(F_tab_2_1.tab_fibo11,tab_percent,0,6);
 F_tab_3_up[11].calcul_fibo_up(F_tab_2_1.tab_fibo12,tab_percent,0,6);
 //----------------------------
 F_tab_3_down[0].calcul_fibo_down(F_tab_2_2.tab_fibo1,tab_percent,0,6);
 F_tab_3_down[1].calcul_fibo_down(F_tab_2_2.tab_fibo2,tab_percent,0,6);
 F_tab_3_down[2].calcul_fibo_down(F_tab_2_2.tab_fibo3,tab_percent,0,6);
 F_tab_3_down[3].calcul_fibo_down(F_tab_2_2.tab_fibo4,tab_percent,0,6);
 F_tab_3_down[4].calcul_fibo_down(F_tab_2_2.tab_fibo5,tab_percent,0,6);
 F_tab_3_down[5].calcul_fibo_down(F_tab_2_2.tab_fibo6,tab_percent,0,6);
 F_tab_3_down[6].calcul_fibo_down(F_tab_2_2.tab_fibo7,tab_percent,0,6);
 F_tab_3_down[7].calcul_fibo_down(F_tab_2_2.tab_fibo8,tab_percent,0,6);
 F_tab_3_down[8].calcul_fibo_down(F_tab_2_2.tab_fibo9,tab_percent,0,6);
 F_tab_3_down[9].calcul_fibo_down(F_tab_2_2.tab_fibo10,tab_percent,0,6);
 F_tab_3_down[10].calcul_fibo_down(F_tab_2_2.tab_fibo11,tab_percent,0,6);
 F_tab_3_down[11].calcul_fibo_down(F_tab_2_2.tab_fibo12,tab_percent,0,6);
//---------------------------------------------------------------------------//
}
//-------------------------------------------------------------------------------------------+
void FIBO()
{
//--- create fibolevel 1
if(display_level1==true)
{
create_fibox(0,13,tab_fibo1,tab_percent,"up",1);
create_fibox(0,13,tab_fibo2,tab_percent,"down",1);
}
find_lowlevel_highlevel(iClose(_Symbol,PERIOD_M15,1),tab_fibo1,tab_fibo2);
if(zone=="zone1")
{
//-- 1 the price between 0 and 23.6
if(low_index_level==0 && hight_index_level==1)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo1,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo2,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[0]);
display_all_zone(F_tab_3_up[1]);
}
}
//-- 2 the price between 23.6 and 38.2
if(low_index_level==1 && hight_index_level==2)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo1,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo2,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo3,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[0]);
display_all_zone(F_tab_3_up[1]);
display_all_zone(F_tab_3_up[2]);
}
}
//-- 3 the price between 38.2 and 50
if(low_index_level==2 && hight_index_level==3)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo2,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo3,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo4,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[1]);
display_all_zone(F_tab_3_up[2]);
display_all_zone(F_tab_3_up[3]);
}
}
//-- 4 the price between 50 and 61.8
if(low_index_level==3 && hight_index_level==4)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo3,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo4,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo5,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[2]);
display_all_zone(F_tab_3_up[3]);
display_all_zone(F_tab_3_up[4]);
}
}
//-- 5 the price between 61.8 and 76.0
if(low_index_level==4 && hight_index_level==5)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo4,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo5,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo6,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[3]);
display_all_zone(F_tab_3_up[4]);
display_all_zone(F_tab_3_up[5]);
}
}
//-- 6 the price between 76.0 and 100.0
if(low_index_level==5 && hight_index_level==6)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo5,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo6,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo7,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[4]);
display_all_zone(F_tab_3_up[5]);
display_all_zone(F_tab_3_up[6]);
}
}
//-- 7 the price between 100.0 and 123.6
if(low_index_level==6 && hight_index_level==7)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo6,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo7,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo8,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[5]);
display_all_zone(F_tab_3_up[6]);
display_all_zone(F_tab_3_up[7]);
}
}
//-- 8 the price between 123.6 and 138.2
if(low_index_level==7 && hight_index_level==8)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo7,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo8,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo9,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[6]);
display_all_zone(F_tab_3_up[7]);
display_all_zone(F_tab_3_up[8]);
}
}
//-- 9 the price between 138.2 and 150.0
if(low_index_level==8 && hight_index_level==9)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo8,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo9,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo10,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[7]);
display_all_zone(F_tab_3_up[8]);
display_all_zone(F_tab_3_up[9]);
}
}
//-- 10 the price between 150.0 and 161.8
if(low_index_level==9 && hight_index_level==10)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo9,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo10,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo11,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[8]);
display_all_zone(F_tab_3_up[9]);
display_all_zone(F_tab_3_up[10]);
}
}
//-- 11 the price between 161.8 and 170.0
if(low_index_level==10 && hight_index_level==11)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo10,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo11,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo12,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[9]);
display_all_zone(F_tab_3_up[10]);
display_all_zone(F_tab_3_up[11]);
}
}
//-- 12 the price between 170.0 and 200
if(low_index_level==11 && hight_index_level==12)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_1.tab_fibo11,tab_percent,"up",2);
create_fibox(1,6,F_tab_2_1.tab_fibo12,tab_percent,"up",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_up[10]);
display_all_zone(F_tab_3_up[11]);
}
}
}
//-------------------------------------------------------------
if(zone=="zone2")
{
//-- 1 the price between 0 and -23.6
if(low_index_level==0 && hight_index_level==1)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo1,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo2,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[0]);
display_all_zone(F_tab_3_down[1]);
}
}
//-- 2 the price between -23.6 and -38.2
if(low_index_level==1 && hight_index_level==2)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo1,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo2,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo3,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[0]);
display_all_zone(F_tab_3_down[1]);
display_all_zone(F_tab_3_down[2]);
}

}
//-- 3 the price between -38.2 and -50.0
if(low_index_level==2 && hight_index_level==3)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo2,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo3,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo4,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[1]);
display_all_zone(F_tab_3_down[2]);
display_all_zone(F_tab_3_down[3]);
}
}
//-- 4 the price between -50.0 and -61.8
if(low_index_level==3 && hight_index_level==4)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo3,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo4,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo5,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[2]);
display_all_zone(F_tab_3_down[3]);
display_all_zone(F_tab_3_down[4]);
}
}
//-- 5 the price between -61.8 and -76.0
if(low_index_level==4 && hight_index_level==5)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo4,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo5,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo6,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[3]);
display_all_zone(F_tab_3_down[4]);
display_all_zone(F_tab_3_down[5]);
}
}
//-- 6 the price between -76.0 and -100.0
if(low_index_level==5 && hight_index_level==6)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo5,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo6,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo7,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[4]);
display_all_zone(F_tab_3_down[5]);
display_all_zone(F_tab_3_down[6]);
}
}
//-- 7 the price between -100.0 and -123.6
if(low_index_level==6 && hight_index_level==7)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo6,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo7,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo8,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[5]);
display_all_zone(F_tab_3_down[6]);
display_all_zone(F_tab_3_down[7]);
}
}
//-- 8 the price between -123.6 and -138.2
if(low_index_level==7 && hight_index_level==8)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo7,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo8,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo9,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[6]);
display_all_zone(F_tab_3_down[7]);
display_all_zone(F_tab_3_down[8]);
}
}
//-- 9 the price between -138.2 and -150.0
if(low_index_level==8 && hight_index_level==9)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo8,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo9,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo10,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[7]);
display_all_zone(F_tab_3_down[8]);
display_all_zone(F_tab_3_down[9]);
}
}
//-- 10 the price between -150.0 and -161.8
if(low_index_level==9 && hight_index_level==10)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo9,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo10,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo11,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[8]);
display_all_zone(F_tab_3_down[9]);
display_all_zone(F_tab_3_down[10]);
}
}
//-- 11 the price between -161.8 and -170.0
if(low_index_level==10 && hight_index_level==11)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo10,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo11,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo12,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[9]);
display_all_zone(F_tab_3_down[10]);
display_all_zone(F_tab_3_down[11]);
}
}
//-- 12 the price between -170.0 and -200.0
if(low_index_level==11 && hight_index_level==12)
{
if(display_level2==true)
{
create_fibox(1,6,F_tab_2_2.tab_fibo11,tab_percent,"down",2);
create_fibox(1,6,F_tab_2_2.tab_fibo12,tab_percent,"down",2);
}
if(display_level3==true)
{
display_all_zone(F_tab_3_down[10]);
display_all_zone(F_tab_3_down[11]);
}
}
}
}
//--- Display Function ---------------------------------------------------------------------------------------------------------------+
void display_all_zone(Fibo_tab &F_tab)
{
create_fibox(1,6,F_tab.tab_fibo1,tab_percent,"",3);
create_fibox(1,6,F_tab.tab_fibo2,tab_percent,"",3);
create_fibox(1,6,F_tab.tab_fibo3,tab_percent,"",3);
create_fibox(1,6,F_tab.tab_fibo4,tab_percent,"",3);
create_fibox(1,6,F_tab.tab_fibo5,tab_percent,"",3);
create_fibox(1,6,F_tab.tab_fibo6,tab_percent,"",3);

}
string create_comment(int in,string trend)
{
string com="";
switch(in)
{
case 0:com="(0.0)";break;
case 1:if(trend=="up")com="(23.6)";else com="(-23.6)";break;
case 2:if(trend=="up")com="(38.2)";else com="(-38.2)";break;
case 3:if(trend=="up")com="(50.0)";else com="(-50.0)";break;
case 4:if(trend=="up")com="(61.8)";else com="(-61.8)";break;
case 5:if(trend=="up")com="(76)";else com="(-76)";break;
case 6:if(trend=="up")com="(100)";else com="(-100)";break;
case 7:if(trend=="up")com="(123.6)";else com="(-123.6)";break;
case 8:if(trend=="up")com="(138.2)";else com="(-138.2)";break;
case 9:if(trend=="up")com="(150.0)";else com="(-150.0)";break;
case 10:if(trend=="up")com="(161.8)";else com="(-161.8)";break;
case 11:if(trend=="up")com="(176)";else com="(-176)";break;
case 12:if(trend=="up")com="(200)";else com="(-200)";break;

}
return(com);
}
//-------------------------------------------------------------------------------------+
void INIT_EXPERT()
{
if(Digits()==3 || Digits()==5 || Digits()==2)
point=10*Point();
else point=Point();
//-------------------------------------------------------------------+
concat_down(12,Trade_level1,tab_fibo2);
concat_up(12,Trade_level1,tab_fibo1);
//-------------------------------------------------------------------+
calcul_target(Trade_level1,0,24,point,
Buy_Limit_Percent_Target_Profit1,Sell_Limit_Percent_Target_Profit1,Buy_Stop_Percent_Target_Profit1,Sell_Stop_Percent_Target_Profit1,
Commission,
Buy_Limit_Percent_StopLoss1,Sell_Limit_Percent_StopLoss1,Buy_Stop_Percent_StopLoss1,Sell_Stop_Percent_StopLoss1);
//--------------------------- level 2 -------------------------------
concat_up_level2(0,6,tab_trade2_1,F_tab_2_1.tab_fibo1);
concat_up_level2(7,12,tab_trade2_1,F_tab_2_1.tab_fibo2);
concat_up_level2(13,18,tab_trade2_1,F_tab_2_1.tab_fibo3);
concat_up_level2(19,24,tab_trade2_1,F_tab_2_1.tab_fibo4);
concat_up_level2(25,30,tab_trade2_1,F_tab_2_1.tab_fibo5);
concat_up_level2(31,36,tab_trade2_1,F_tab_2_1.tab_fibo6);
concat_up_level2(37,42,tab_trade2_1,F_tab_2_1.tab_fibo7);
concat_up_level2(43,48,tab_trade2_1,F_tab_2_1.tab_fibo8);
concat_up_level2(49,54,tab_trade2_1,F_tab_2_1.tab_fibo9);
concat_up_level2(55,60,tab_trade2_1,F_tab_2_1.tab_fibo10);
concat_up_level2(61,66,tab_trade2_1,F_tab_2_1.tab_fibo11);
concat_up_level2(67,72,tab_trade2_1,F_tab_2_1.tab_fibo12);
concat_up(72,Trade_level2,tab_trade2_1);
//----------
concat_down_level2(0,6,tab_trade2_2,F_tab_2_2.tab_fibo1);
concat_down_level2(7,12,tab_trade2_2,F_tab_2_2.tab_fibo2);
concat_down_level2(13,18,tab_trade2_2,F_tab_2_2.tab_fibo3);
concat_down_level2(19,24,tab_trade2_2,F_tab_2_2.tab_fibo4);
concat_down_level2(25,30,tab_trade2_2,F_tab_2_2.tab_fibo5);
concat_down_level2(31,36,tab_trade2_2,F_tab_2_2.tab_fibo6);
concat_down_level2(37,42,tab_trade2_2,F_tab_2_2.tab_fibo7);
concat_down_level2(43,48,tab_trade2_2,F_tab_2_2.tab_fibo8);
concat_down_level2(49,54,tab_trade2_2,F_tab_2_2.tab_fibo9);
concat_down_level2(55,60,tab_trade2_2,F_tab_2_2.tab_fibo10);
concat_down_level2(61,66,tab_trade2_2,F_tab_2_2.tab_fibo11);
concat_down_level2(67,72,tab_trade2_2,F_tab_2_2.tab_fibo12);
concat_down(72,Trade_level2,tab_trade2_2);
//-------------------------------------------------------------------+
calcul_target(Trade_level2,0,144,point,
Buy_Limit_Percent_Target_Profit2,Sell_Limit_Percent_Target_Profit2,Buy_Stop_Percent_Target_Profit2,Sell_Stop_Percent_Target_Profit2,
Commission,
Buy_Limit_Percent_StopLoss2,Sell_Limit_Percent_StopLoss2,Buy_Stop_Percent_StopLoss2,Sell_Stop_Percent_StopLoss2);
//+------------------------------------------------------------------+
//--------------------------- level 3 -------------------------------
int begin=0,end=6;
for(int i=0;i<12;i++)
{
begin=concat_up_level3(begin,end,tab_trade3_1,F_tab_3_up[i]);
end=begin+5;
//Comment(IntegerToString(end));
}
concat_up(438,Trade_level3,tab_trade3_1);

//---------
begin=0;end=6;
for(int i=0;i<12;i++)
{
begin=concat_down_level3(begin,end,tab_trade3_2,F_tab_3_up[i]);
end=begin+5;
//Comment(IntegerToString(end));
}
concat_down(438,Trade_level3,tab_trade3_2);
//-------------------------------------------------------------------+
calcul_target(Trade_level3,0,876,point,
Buy_Limit_Percent_Target_Profit3,Sell_Limit_Percent_Target_Profit3,Buy_Stop_Percent_Target_Profit3,Sell_Stop_Percent_Target_Profit3,
Commission,
Buy_Limit_Percent_StopLoss3,Sell_Limit_Percent_StopLoss3,Buy_Stop_Percent_StopLoss3,Sell_Stop_Percent_StopLoss3);
//+------------------------------------------------------------------+

}
//-------------------------------------------------------------------------------------------------------------------+
void EXPERT()
{


if(Trade_in_level_1==true)
{
  static datetime previousBar1;
   if(previousBar1!=iTime(_Symbol,Timeframe1,0))
     {
      previousBar1=iTime(_Symbol,Timeframe1,0);
if(find_ptice(0,24,iClose(_Symbol,Timeframe1,1),Trade_level1))
{
if(Sell_Limit_Pending_Order_Level1)
open_pending_selllimit(high_index_price+1,Trade_level1,24,Sell_Limit_lot_level1,max_trade_level1,MagicNumber_level1);
if(Buy_Stop_Pending_Order_Level1)
open_pending_buystop(high_index_price+1,Trade_level1,24,Buy_Stop_lot_level1,max_trade_level1,MagicNumber_level1);
//--------------
if( Buy_Limit_Pending_Order_Level1)
open_pending_buylimit(low_index_price-1,Trade_level1,0,Buy_Limit_lot_level1,max_trade_level1,MagicNumber_level1);
if( Sell_Stop_Pending_Order_Level1)
open_pending_sellstop(low_index_price-1,Trade_level1,0,Sell_Stop_lot_level1,max_trade_level1,MagicNumber_level1);
}
     }
}

if(Trade_in_level_2==true)
{

  static datetime previousBar2;
   if(previousBar2!=iTime(_Symbol,Timeframe2,0))
     {
      previousBar2=iTime(_Symbol,Timeframe2,0);
if(find_ptice(0,144,iClose(_Symbol,Timeframe2,1),Trade_level2))
{
if(Sell_Limit_Pending_Order_Level2)
open_pending_selllimit(high_index_price+1,Trade_level2,144,Sell_Limit_lot_level2,max_trade_level2,MagicNumber_level2);
if( Buy_Stop_Pending_Order_Level2)
open_pending_buystop(high_index_price+1,Trade_level2,144,Buy_Stop_lot_level2,max_trade_level2,MagicNumber_level2);
//---------------------------
if( Buy_Limit_Pending_Order_Level2)
open_pending_buylimit(low_index_price-1,Trade_level2,0,Buy_Limit_lot_level2,max_trade_level2,MagicNumber_level2);
if( Sell_Stop_Pending_Order_Level2)
open_pending_sellstop(low_index_price-1,Trade_level2,0,Sell_Stop_lot_level2,max_trade_level2,MagicNumber_level2);
}

     }
}

if(Trade_in_level_3==true)
{
  static datetime previousBar3;
   if(previousBar3!=iTime(_Symbol,Timeframe3,0))
     {
      previousBar3=iTime(_Symbol,Timeframe3,0);
    
if(find_ptice(0,876,iClose(_Symbol,Timeframe3,1),Trade_level3))
{
if( Sell_Limit_Pending_Order_Level3)
open_pending_selllimit(high_index_price+1,Trade_level3,876,Sell_Limit_lot_level3,max_trade_level3,MagicNumber_level3);
if( Buy_Stop_Pending_Order_Level3)
open_pending_buystop(high_index_price+1,Trade_level3,876,Buy_Stop_lot_level3,max_trade_level3,MagicNumber_level3);
//---------
if( Buy_Limit_Pending_Order_Level3)
open_pending_buylimit(low_index_price-1,Trade_level3,0,Buy_Limit_lot_level3,max_trade_level3,MagicNumber_level3);
if( Sell_Stop_Pending_Order_Level3)
open_pending_sellstop(low_index_price-1,Trade_level3,0,Sell_Stop_lot_level3,max_trade_level3,MagicNumber_level3);
}
     }


}
}
//----------------------------
bool find_ptice(int begin,int end,double price,Fibo_Trade &tab[])
{
bool result=false;

//--- search betwen low and high fibo up
for(int i=begin;i<end;i++)
{
if(price>tab[i].value && price<tab[i+1].value)
{
low_index_price=i;
high_index_price=i+1;
result=true;return(result);
break;
}else result=false;
}

return(result);
}
void target(int begin,int end,Fibo_Trade &tab[])
{

for(int i=begin;i<=end ;i++)
{
if(tab[i].target_buylimit!=0)
create_linex(DoubleToString(tab[i].target_buylimit),tab[i].target_buylimit,clrBlack,1,2,"Target_buy_limit");
if(tab[i].target_selllimit!=EMPTY_VALUE)
create_linex(DoubleToString(tab[i].target_selllimit),tab[i].target_selllimit,clrBlack,1,2,"Target_sell_limit");
}
}
//---------------------------------

//---------------------------------------------------------------------------------------------
void open_pending_selllimit(int index_tab,Fibo_Trade &tab[],int end,double lot,int max_trade,int magic)
{
int h=0;
for(int i=index_tab;i<=end && h<max_trade;i++)
{
if(find_selllimit(DoubleToString(tab[i].value)+IntegerToString(magic))==false && tab[i].target_selllimit!=EMPTY_VALUE)
{
trade.SellLimit(lot,tab[i].value,_Symbol,tab[i].StopLoss_selllimit,tab[i].target_selllimit,0,1,DoubleToString(tab[i].value)+IntegerToString(magic));
trade.SetExpertMagicNumber(magic);
}
h++;
}
}
//-----------------
void open_pending_buylimit(int index_tab,Fibo_Trade &tab[],int begin,double lot,int max_trade,int magic)
{
int h=0;
for(int i=index_tab;i>=begin && h<max_trade;i--)
{
if(find_buylimit(DoubleToString(tab[i].value)+IntegerToString(magic))==false && tab[i].target_buylimit!=EMPTY_VALUE)
{
trade.BuyLimit(lot,tab[i].value,_Symbol,tab[i].StopLoss_buylimit,tab[i].target_buylimit,0,1,DoubleToString(tab[i].value)+IntegerToString(magic));
trade.SetExpertMagicNumber(magic);
}
h++;
}
}
//-------------------- buystop
void open_pending_buystop(int index_tab,Fibo_Trade &tab[],int end,double lot,int max_trade,int magic)
{
int h=0;
for(int i=index_tab;i<=end && h<max_trade;i++)
{

if(find_buystop(DoubleToString(tab[i].value)+IntegerToString(magic))==false && tab[i].target_buystop!=EMPTY_VALUE)//
{
trade.BuyStop(lot,tab[i].value,_Symbol,tab[i].StopLoss_buystop,tab[i].target_buystop,0,1,DoubleToString(tab[i].value)+IntegerToString(magic));
trade.SetExpertMagicNumber(magic);
}
h++;
}
}
//-----------------
//----------------- sellstop
void open_pending_sellstop(int index_tab,Fibo_Trade &tab[],int begin,double lot,int max_trade,int magic)
{
int h=0;
for(int i=index_tab;i>=begin && h<max_trade;i--)
{
if(find_sellstop(DoubleToString(tab[i].value)+IntegerToString(magic))==false && tab[i].target_sellstop!=EMPTY_VALUE)
{
trade.SellStop(lot,tab[i].value,_Symbol,tab[i].StopLoss_sellstop,tab[i].target_sellstop,0,1,DoubleToString(tab[i].value)+IntegerToString(magic));
trade.SetExpertMagicNumber(magic);
}
h++;
}
}
//--------------------------------------------
int concat_up_level3(int begin,int end,double &tab[],Fibo_tab &ftab)
{

int iz=0;
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo1);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo2);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo3);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo4);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo5);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo6);begin=(end+1);end=(end+6);
iz=begin;
return(iz);

}

int concat_down_level3(int begin,int end,double &tab[],Fibo_tab &ftab)
{

int iz=0;
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo1);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo2);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo3);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo4);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo5);begin=(end+1);end=(end+6);
concat_up_level2(begin,end,tab_trade3_1,ftab.tab_fibo6);begin=(end+1);end=(end+6);
iz=begin;
return(iz);

}
//----------------------------------------------------------------------
bool find_selllimit(string price)
{
bool r=false;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
        if(OrderGetString(ORDER_SYMBOL)==_Symbol)
          {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_LIMIT)
              {
                if(price==OrderGetString(ORDER_COMMENT))
                    {
                    r=true;return(r);
                    break;
                    }
}
}
}
}

return(r);
}
//----------------------------------------------------------------------
bool find_buylimit(string price)
{
bool r=false;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
        if(OrderGetString(ORDER_SYMBOL)==_Symbol)
          {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_LIMIT)
              {
                if(price==OrderGetString(ORDER_COMMENT))
                    {
                    r=true;return(r);
                    break;
                    }
}
}
}
}

return(r);
}
///----------
bool find_buystop(string price)
{
bool r=false;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
        if(OrderGetString(ORDER_SYMBOL)==_Symbol)
          {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_STOP)
              {
                if(price==OrderGetString(ORDER_COMMENT))
                    {
                    r=true;return(r);
                    break;
                    }
}
}
}
}

return(r);
}
//--------------------------------------------
bool find_sellstop(string price)
{
bool r=false;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
        if(OrderGetString(ORDER_SYMBOL)==_Symbol)
          {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_STOP)
              {
                if(price==OrderGetString(ORDER_COMMENT))
                    {
                    r=true;return(r);
                    break;
                    }
}
}
}
}

return(r);
}
///----------
double profit()
{

double profit=0;
CPositionInfo pos_info;
ArrayResize(t,PositionsTotal());
    for (int i=PositionsTotal()-1; i>=0 && pos_info.SelectByIndex(i); --i) {
     if(pos_info.Symbol()==_Symbol)
          {
      
     profit=profit+pos_info.Profit();

          }
          }
          return(profit);
}
//------------------------------
void update_stat(Order_Trade &order,Fibo_Trade &tab[])
{
for(int i=0;i<ArraySize(tab);i++)
{
if(order.value==tab[i].value)
{
tab[i].stat=false;
break;
}
}
}
//------------------------------------------
void delelete_buystop()
{
int nbr=0;
 ulong ticket=0;
   for(int i=0; i<=OrdersTotal()-1; i++)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_STOP)
                  {
                  if(OrderGetString(ORDER_SYMBOL)==_Symbol)
                              trade.OrderDelete(ticket);
                  }
}
}
}
//----------------------------------------
void delelete_sellstop()
{
int nbr=0;
 ulong ticket=0;
   for(int i=0; i<=OrdersTotal()-1; i++)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_STOP)
                  {
                  if(OrderGetString(ORDER_SYMBOL)==_Symbol)
                              trade.OrderDelete(ticket);
                  }
}
}
}
//------------------------------------------
//------------------------------------------
void delelete_buylimit()
{
int nbr=0;
 ulong ticket=0;
   for(int i=0; i<=OrdersTotal()-1; i++)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_LIMIT)
                  {
                  if(OrderGetString(ORDER_SYMBOL)==_Symbol)
                              trade.OrderDelete(ticket);
                  }
}
}
}
//----------------------------------------
void delelete_selllimit()
{
int nbr=0;
 ulong ticket=0;
   for(int i=0; i<=OrdersTotal()-1; i++)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_LIMIT)
                  {
                  if(OrderGetString(ORDER_SYMBOL)==_Symbol )
                              trade.OrderDelete(ticket);
                  }
}
}
}
//----------------------------------------
void delelete_all_pending_order()
{
int nbr=0;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if(( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_LIMIT ||OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_LIMIT || OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_STOP)&& OrderGetString(ORDER_SYMBOL)==_Symbol)
               trade.OrderDelete(ticket);
}
}
}
//-----------------------------------------
void close_all_order()
{
CPositionInfo m_position;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current position
      if(m_position.SelectByIndex(i))     // selects the position by index for further access to its properties
         if(m_position.Symbol()==Symbol())
            trade.PositionClose(m_position.Ticket()); 
}
//-----------------------------------------
void close_all_sell()
{
CPositionInfo m_position;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current position
      if(m_position.SelectByIndex(i))     // selects the position by index for further access to its properties
         if(m_position.Symbol()==Symbol() && m_position.PositionType()==POSITION_TYPE_SELL)
            trade.PositionClose(m_position.Ticket()); 
}
//-----------------------------------------
void close_all_buy()
{
CPositionInfo m_position;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current position
      if(m_position.SelectByIndex(i))     // selects the position by index for further access to its properties
         if(m_position.Symbol()==Symbol() && m_position.PositionType()==POSITION_TYPE_BUY)
            trade.PositionClose(m_position.Ticket()); 
}
//-----------------------------------------
int count_selllimit(uint magic)
{
int nbr=0;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_SELL_LIMIT )
                  {
                  if(OrderGetInteger(ORDER_MAGIC)==magic && OrderGetString(ORDER_SYMBOL)==_Symbol)
                              nbr++;
                  }
}
}
return(nbr);
}
//-------------------------------------
int count_buylimit(uint magic)
{
int nbr=0;
 ulong ticket=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     ticket=OrderGetTicket(i);
      if(ticket>0)
        {
 if( OrderGetInteger(ORDER_TYPE)==ORDER_TYPE_BUY_LIMIT)
                  {
                  if(OrderGetInteger(ORDER_MAGIC)==magic && OrderGetString(ORDER_SYMBOL)==_Symbol)
                              nbr++;
                  }
}
}
return(nbr);
}
//------------------------------------------------
bool IsTradeTime()
{
if ((Hour_Start_Trade < Hour_Stop_Trade) && (  (dt_struct.hour  < Hour_Start_Trade) || (dt_struct.hour >= Hour_Stop_Trade))) return(false);
if ((Hour_Start_Trade > Hour_Stop_Trade) && (dt_struct.hour < Hour_Start_Trade) && (dt_struct.hour >= Hour_Stop_Trade)) return(false);
//if (Hour_Stop_Trade == 0) Hour_Stop_Trade = 24;
if ((dt_struct.hour == Hour_Stop_Trade - 1) && (dt_struct.min >= LastMinute)) return(false);
return(true);
}

