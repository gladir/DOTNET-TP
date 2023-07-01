{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/dotnet-tp)
  @abstract(Target: Turbo Pascal, Free Pascal)
  @Description: Unit‚ centrale des classes .NET en Turbo Pascal
}

Unit DOTNET;

INTERFACE

Type
 ValueType=(vtObject,vtByte,Int16,Int32,Int64,SByte,UInt16,UInt32,UInt64,BigInteger,Decimal,Double,Single);

Type
 Object_=Object
  Function GetType:ValueType;Virtual;
  Function MemberwiseClone:Pointer;Virtual;
  Function ToString:String;Virtual;
  Destructor Finalize;Virtual;
 End;

 ConsoleObj=Object
   BackgroundColor,ForegroundColor:Byte;
   Constructor Init;
   Procedure Beep;
   Procedure Beep__(Frequency,Duration:Integer);
   Procedure Clear;
   Function GetCursorPositionX:Integer;
   Function GetCursorPositionY:Integer;
   Function KeyAvailable:Boolean;
   Function Read:Integer;
   Function ReadLine:String;
   Function ReadKey:Char;
   Procedure ResetColor;
   Procedure SetCursorPosition(Left,Top:Integer);
   Procedure SetWindowPosition(Left,Top:Integer);
   Procedure SetWindowSize(Width,Height:Integer);
   Function WindowHeight:Integer;
   Function WindowWidth:Integer;
   Procedure Write(S:String);
   Procedure WriteLine(S:String);
   Destructor Done;
  Private
   X1,Y1,X2,Y2:Integer;
 End;

Var
 Console:ConsoleObj;

IMPLEMENTATION

Uses Crt;

{ Classe Object }

Function Object_.GetType:ValueType;Begin
 GetType:=vtObject;
End;

Function Object_.MemberwiseClone:Pointer;Begin
{ MemberwiseClone:=New Object_;}
End;

Function Object_.ToString:String;Begin
 ToString:='';
End;

Destructor Object_.Finalize;Begin
End;

{ Classe Console }

Constructor ConsoleObj.Init;Begin
 BackgroundColor:=0;
 ForegroundColor:=7;
 X1:=1;
 Y1:=1;
 X2:=80;
 Y2:=25;
End;

Procedure ConsoleObj.Beep;Begin
 Sound(1550);
 Delay(182);
 NoSound;
End;

Procedure ConsoleObj.Beep__(Frequency,Duration:Integer);Begin
 Sound(Frequency);
 Delay(Duration);
 NoSound;
End;

Procedure ConsoleObj.Clear;Begin
 ClrScr;
End;

Function ConsoleObj.GetCursorPositionX:Integer;Begin
 GetCursorPositionX:=WhereX;
End;

Function ConsoleObj.GetCursorPositionY:Integer;Begin
 GetCursorPositionY:=WhereY;
End;

Function ConsoleObj.KeyAvailable:Boolean;Begin
 KeyAvailable:=Keypressed;
End;

Function ConsoleObj.Read:Integer;Begin
 If(Not KeyPressed)Then Read:=-1
                   Else Read:=Ord(ReadKey);
End;

Function ConsoleObj.ReadKey:Char;Begin
 ReadKey:=Crt.ReadKey;
End;

Function ConsoleObj.ReadLine:String;
Var
 S:String;
Begin
 ReadLn(S);
 ReadLine:=S;
End;

Procedure ConsoleObj.ResetColor;Begin
 BackgroundColor:=0;
 ForegroundColor:=7;
 TextColor(7);
 TextBackground(Black);
End;

Procedure ConsoleObj.SetCursorPosition(Left,Top:Integer);Begin
 GotoXY(Left,Top);
End;

Procedure ConsoleObj.SetWindowPosition(Left,Top:Integer);Begin
 X1:=Left;
 Y1:=Top;
 Window(X1,Y1,X2,Y2);
End;

Procedure ConsoleObj.SetWindowSize(Width,Height:Integer);Begin
 X2:=X1+Width-1;
 Y2:=Y1+Height-1;
 Window(X1,Y1,X2,Y2);
End;

Function ConsoleObj.WindowHeight:Integer;Begin
 WindowHeight:=Y2-Y1+1;
End;

Function ConsoleObj.WindowWidth:Integer;Begin
 WindowWidth:=X2-X1+1;
End;

Procedure ConsoleObj.Write(S:String);Begin
 TextBackground(BackgroundColor);
 TextColor(ForegroundColor);
 System.Write(S);
End;

Procedure ConsoleObj.WriteLine(S:String);Begin
 TextBackground(BackgroundColor);
 TextColor(ForegroundColor);
 WriteLn(S);
End;

Destructor ConsoleObj.Done;Begin
End;

BEGIN
 Console.Init;
END.