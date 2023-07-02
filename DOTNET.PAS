{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/dotnet-tp)
  @abstract(Target: Turbo Pascal 7, Free Pascal)
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

 ConsoleClass=Object
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

 MathClass=Object
  Constructor Init;
  Function Abs(a:Real):Real;
  Function ACos(a:Real):Real;
  Function ASin(a:Real):Real;
  Function Atan(X:Real):Real;
  Function ATan2(y,x:Real):Real;
  Function BigMul(a,b:LongInt):LongInt;
  Function Ceiling(d:Real):Integer;
  Function Cos(X:Real):Real;
  Function Cosh(x:Real):Real;
  Function Exp(x:Real):Real;
  Function Floor(d:Real):Real;
  Function IEEERemainder(x,y:Real):Real;
  Function Log(x:Real):Real;
  Function Log_(x,n:Real):Real;
  Function Log10(x:Real):Real;
  Function Max(a,b:Real):Real;
  Function Min(a,b:Real):Real;
  Function PI:Real;
  Function POW(a,b:Real):Real;
  Function Round(a:Real):Real;
  Function Sin(X:Real):Real;
  Function SinH(X:Real):Real;
  Function Sqrt(x:Real):Real;
  Function Tan(X:Real):Real;
  Function TanH(X:Real):Real;
  Function ToString:String;Virtual;
  Function Truncate(d:Real):Real;
 End;

Var
 Console:ConsoleClass;
 Math:MathClass;

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

Constructor ConsoleClass.Init;Begin
 BackgroundColor:=0;
 ForegroundColor:=7;
 X1:=1;
 Y1:=1;
 X2:=80;
 Y2:=25;
End;

Procedure ConsoleClass.Beep;Begin
 Sound(1550);
 Delay(182);
 NoSound;
End;

Procedure ConsoleClass.Beep__(Frequency,Duration:Integer);Begin
 Sound(Frequency);
 Delay(Duration);
 NoSound;
End;

Procedure ConsoleClass.Clear;Begin
 ClrScr;
End;

Function ConsoleClass.GetCursorPositionX:Integer;Begin
 GetCursorPositionX:=WhereX;
End;

Function ConsoleClass.GetCursorPositionY:Integer;Begin
 GetCursorPositionY:=WhereY;
End;

Function ConsoleClass.KeyAvailable:Boolean;Begin
 KeyAvailable:=Keypressed;
End;

Function ConsoleClass.Read:Integer;Begin
 If(Not KeyPressed)Then Read:=-1
                   Else Read:=Ord(ReadKey);
End;

Function ConsoleClass.ReadKey:Char;Begin
 ReadKey:=Crt.ReadKey;
End;

Function ConsoleClass.ReadLine:String;
Var
 S:String;
Begin
 ReadLn(S);
 ReadLine:=S;
End;

Procedure ConsoleClass.ResetColor;Begin
 BackgroundColor:=0;
 ForegroundColor:=7;
 TextColor(7);
 TextBackground(Black);
End;

Procedure ConsoleClass.SetCursorPosition(Left,Top:Integer);Begin
 GotoXY(Left,Top);
End;

Procedure ConsoleClass.SetWindowPosition(Left,Top:Integer);Begin
 X1:=Left;
 Y1:=Top;
 Window(X1,Y1,X2,Y2);
End;

Procedure ConsoleClass.SetWindowSize(Width,Height:Integer);Begin
 X2:=X1+Width-1;
 Y2:=Y1+Height-1;
 Window(X1,Y1,X2,Y2);
End;

Function ConsoleClass.WindowHeight:Integer;Begin
 WindowHeight:=Y2-Y1+1;
End;

Function ConsoleClass.WindowWidth:Integer;Begin
 WindowWidth:=X2-X1+1;
End;

Procedure ConsoleClass.Write(S:String);Begin
 TextBackground(BackgroundColor);
 TextColor(ForegroundColor);
 System.Write(S);
End;

Procedure ConsoleClass.WriteLine(S:String);Begin
 TextBackground(BackgroundColor);
 TextColor(ForegroundColor);
 WriteLn(S);
End;

Destructor ConsoleClass.Done;Begin
End;

 { Classe Math }
Constructor MathClass.Init;Begin
End;

Function MathClass.Abs(a:Real):Real;Begin
 If a<0.0 Then a:=-a;
 Abs:=a;
End;

Function MathClass.ACos(a:Real):Real;Begin
 If Math.Abs(a)=1.0 Then ACos := (1-a)*PI/2.0
                    Else ACos := Math.Atan(-a/Math.Sqrt(1-a*a))+2*Math.Atan(1);
End;

Function MathClass.ASin(a:Real):Real;Begin
 If Math.Abs(a)=1.0Then ASin:=PI/2.0
                   Else ASin:=Math.ATan(a/Math.Sqrt(1.0-a*a));
End;

Function MathClass.Atan(X:Real):Real;
Var
 A,B:Real;
 N:Integer;
Begin
 A := 1.0 / Math.Sqrt(1.0 + (X * X));
 B := 1.0;
 For N:=1 to 11 do Begin
  A := (A + B) / 2.0;
  B := Math.Sqrt(A * B);
 End;
 Atan:=X/(Math.Sqrt(1.0+(X*X))*A);
End;

Function MathClass.ATan2(y,x:Real):Real;
Var
 R:Real;
Begin
 If(x=0)Then Begin
  If y=0 Then R:=0.0 Else
  If y>0 Then R:=pi/2 Else
  If y<0 Then R:=-pi/2;
 End
  Else
 R:=ArcTan(y/x);
 If x<0.0 Then R:=R+PI;
 If R>PI Then R:=R-2*PI;
 ATan2:=R;
End;

Function MathClass.BigMul(a,b:LongInt):LongInt;Begin
 BigMul:=LongInt(LongInt(a)*LongInt(b));
End;

Function MathClass.Ceiling(d:Real):Integer;
Var
 R:Integer;
Begin
 R:=Trunc(d);
 If Frac(d)>0 Then R:=R+1;
 Ceiling:=R;
End;

Function MathClass.Cos(X:Real):Real;
Var
 R,S:Real;
 I:Byte;
Begin
 R:=X*X;
 S:=42.0;
 For I:=10 downto 1 do S:=4.0*I-2.0+(-R)/S;
 S:=S*S;
 Cos:=(S-R)/(S+R);
End;

Function MathClass.Cosh(x:Real):Real;Begin
 x:=Math.Abs(x);
 If x > 88.029691931 Then
  Cosh:=0 { Infini }
 Else
  Cosh:=(Math.Exp(x)+Math.Exp(-x))/ 2.0;
End;

Function MathClass.Exp(x:Real):Real;
Var
 Inverse:Boolean;
 n,i:Integer;
 dl,q:Real;
Begin
 Inverse := False;
 n := 0;
 dl := 1;
 i := 1;
 If x < 0 Then Begin
  Inverse := True;
  x := -x;
 End;
 While x >= 2 do Begin
  x := x / 2;
  n := n + 1;
 End;
 x := x / 16;
 n := n + 4;
 q := x;
 While q > 1.0E-15 do Begin
  dl := dl + q;
  i := i + 1;
  q := q * x / i;
 End;
 For i := 1 to n do dl := dl * dl;
 If Inverse Then dl := 1 / dl;
 Exp := dl;
End;

Function MathClass.Floor(d:Real):Real;
Var
 R:Real;
Begin
 R:=Trunc(d);
 If Frac(d)<0 then R:=R-1;
 Floor:=R;
End;


Function MathClass.Log(x:Real):Real;
Var
 negatif:Boolean;
 fois,i:Integer;
 ajout,savx,xp,quotient,dl:Real;
Begin
 negatif := False;
 fois := 1;
 ajout := 0;
 If x <= 0.0 Then Begin
  Log:=0;
  Exit;
 End;
 If x < 1.0 Then Begin
  negatif := True;
  x := 1.0 / x;
 End;
 While x >= 10.0 do Begin
  x := x / 10.0;
  ajout := ajout + 2.302585092994046;
 End;
 While x >= 1.1 do Begin
  x := Math.Sqrt(x);
  fois := fois * 2;
 End;
 x := x - 1;
 savx := x;
 i := 2;
 xp := x * x;
 quotient := (xp / i);
 dl := x - quotient;
 While 1.0E-15 < quotient do Begin
  i := i + 1;
  xp := xp * x;
  dl := dl + (xp / i);
  i := i + 1;
  xp := xp * x;
  quotient := (xp / i);
  dl := dl - quotient;
 End;
 dl := dl * fois;
 dl := dl + ajout;
 If(negatif)Then dl := - dl;
 Log:=dl;
End;

Function MathClass.Log_(x,n:Real):Real;Begin
 Log_:=Ln(x)/Ln(n);
End;

Function MathClass.Log10(x:Real):Real;Begin
 Log10:=Math.Log(x)/2.3025850930;
End;

Function MathClass.Max(a,b:Real):Real;Begin
 If a>b Then Max:=a Else Max:=b;
End;

Function MathClass.Min(a,b:Real):Real;Begin
 If a<b Then Min:=a Else Min:=b;
End;

Function MathClass.IEEERemainder(x,y:Real):Real;Begin
 IEEERemainder:=Trunc(x) mod Trunc(y);
End;

Function MathClass.PI:Real;Begin
 PI:=3.141592653589793;
End;

Function MathClass.POW(a,b:Real):Real;
Var
 p:Real;
 I:Integer;
Begin
 p:=1;
 For i:=1 to Trunc(b) do Begin
  p:=p*a;
 End;
 Pow:=p;
End;

Function MathClass.Round(a:Real):Real;Begin
 Round:=System.Round(a);
End;

Function MathClass.Sin(X:Real):Real;
Var
 R,S:Real;
 I:Byte;
Begin
 R:=X*X;
 S:=42.0;
 For I:=10 downto 1 do S:=4.0*I-2.0+(-R)/S;
 Sin:=2.0*X*S/(R+S*S);
End;

Function MathClass.SinH(X:Real):Real;Begin
 SinH:=(Math.Exp(X)-Math.Exp(-X))/2;
End;

Function MathClass.Sqrt(X:Real):Real;
Var
 A,B,M,XN:Real;
Begin
 If X=0.0Then Begin
  Sqrt:=0.0;
 End
  Else
 Begin
  M := 1.0;
  XN := X;
  While XN >= 2.0 do Begin
   XN := 0.25 * XN;
   M := 2.0 * M;
  End;
  While XN < 0.5 do Begin
   XN:=4.0 * XN;
   M:=0.5 * M;
  End;
  A:=XN;
  B:=1.0-XN;
  Repeat
   A:=A*(1.0+0.5*B);
   B:=0.25*(3.0+B)*B*B;
  Until B<1.0E-15;
  Sqrt:=A*M;
 End;
End;

Function MathClass.Tan(X:Real):Real;Begin
 Tan:=Math.Sin(X)/Math.Cos(X);
End;

Function MathClass.TanH(X:Real):Real;Begin
 TanH:=(Math.Exp(X)-Math.Exp(-X))/(Math.Exp(X)+Math.Exp(-X));
End;

Function MathClass.ToString:String;Begin
 ToString:='Math';
End;

Function MathClass.Truncate(d:Real):Real;Begin
 Truncate:=Trunc(d);
End;

BEGIN
 Console.Init;
 Math.Init;
END.