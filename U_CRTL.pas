unit U_CRTL;
//Ustin'z common runtime library, Copyright � 2003-2008 Ustin
//History applicated @ I_ConstsAndTypes.PIN
interface
{$WRITEABLECONST  ON }    //assignable typed constants
{$LONGSTRINGS     ON }    //use huge strings

Uses windows,messages,U_CRTL_EXT;


function IsDebuggerPresent : boolean; stdcall; external kernel32 name 'IsDebuggerPresent';

//����������� ������ ����� ������

{$i inc_crtl\I_H_ConstsAndTypes.PIN}

{$i inc_crtl\i_H_progressProc.pin}


(* INC_CRTL\I_Mid.PIN *)
Function PasStr(P:PChar):String;
//������� ������ �� PChar
Function PtrToStr(lpBuffer:Pointer;cbBuf:Cardinal):string;
//������� �� ������������� ������ ������
Function CopyFromStr(var S:String; const pos:integer; var buf; const count:Integer):Integer;
//����������� �� ������ � ������������ �����. ����� ���������� ������������� ����.
//�� ������� TStream.Read
Function CutFromStr(var S:String; const pos:integer; var buf; const count:Integer):Integer;
//����������� �� ������ � ����������� ���������� ��������������. ����� ���������� ���������� ����.
Function PasteToStr(const AVar; Size: Longint): String;
//������������ ���������� � ������ - ������ move
Function Mid(Const S:String;Start:Integer):Char;OverLoad;
//����� ������ � Start, ����� Chr(0)
Function Mid(Const S:String;Start,V_Lenght:Integer):String;Overload;
//����� ������ ������� �� Start ������ V_Lenght
//�.�. mid('123456',3,2)='34',mid('123456',3,5)='3456'
Function SubStr(S:String;Start,Finish:Integer):String;
//����� ��������� ������ S �� Start �� Finish
Function SubStrEx(S:String;Start,Finish:Integer):String;
//����� ��������� ������ S �� Start �� Finish
//���� Start ��� Finish ����� �� ��������� ������, ��� ���������
//��������������� �������� (1 ��� Len(S))
//���� Start > Finish, �� _!!!������� ������ � �������� �������!!!_
function UCase(const S: string): string;
function LCase(const S: string): string;
//������ S � �������\������ �������� ��������������.
//������� �� AnsiUpperCase\AnsiLowerCase.
Function InStr(Expr,SbStr:String;Start:Integer=1;Finish:Integer=0;CaseSensitive:Boolean=true):Integer;
//����� ����� ������� _������_ ��������� SubStr � Expr,
//������� ����� �� Start � ���������� �������� � Finish.
//����� ��� � ��� �������, �.�. Start>Finish ��������������
//���� ��������� ���, ����� 0.
//����� 0 �������, ���� (Start>Finish � Finish=Len(Expr))
Function LastInstr(Expr,SbStr:String;CaseSensitive:Boolean=True):Integer;
//����� ��������� ��������� SbStr � Expr
Function InStrCount(Expr,SubStr:String;Start:Integer=1;Finish:Integer=0;CaseSensitive:Boolean=True):Integer;
//����� ����� ��������� SubStr � Expr[Start..Finish].
//���� Finish=0, �� Finish:=Length(Exrp)
Function StrReverse(Expr:String):String;
//������� ������������ ��� ���������� �������� ������ � �������� �������.
Function Quote(Expr,OpenQuote:String;CloseQuote:String=''):String;
//�������� Expr � ������� ���������� ����
Function UnQuote(Expr,OpenQuote:String;CloseQuote:String=''):String;
//����� ������� ���������� ���� � ��������� Expr.
//-:��������� ������� ���� ��������...
{ TODO : Review logic of quote\unquote }
Function TruncateSpaces(Expr:String;TruncType:Byte):String;
//����� ������� �� ������. ����� ����� ���� � ����. ����������� ������� ������
//������� ���� TruncType:
//0: TSpTT_DEL_START    ������ ������� � ������
//1: TSpTT_DEL_END      ������ ������� � �����
//2: TSpTT_DEL_DOUBLE   ������ ��������� ������� �������� � ������
//3: TSpTT_DEL_TABS     ��������� 2 ������� ���� � #9
//4: TSpTT_DEL_CRLF     ��������� 2 ������� ���� � #13#10


//���������� ����������� ��������
const
TSpTT_DEL_START  = 1;
TSpTT_DEL_END    = 2;
TSpTT_DEL_BOTH   = TSpTT_DEL_START or TSpTT_DEL_END;//3
TSpTT_DEL_DOUBLE = 4;
TSpTT_DEL_TABS	 = 8;
TSpTT_DEL_CRLF	 = 16;
TSpTT_DEL_ANY	 = TSpTT_DEL_CRLF or TSpTT_DEL_TABS or TSpTT_DEL_BOTH;


Function ChArr2String(var C:TChArray):String;
Procedure Str2ByteArr(S:String;var B:TByteArray);
Procedure Str2ChArr(S:String;var B:TCHArray);
//��������� ���������� �����, �� �������� ������� ��� ���� ����������

Function StrEq(S1,S2:String;CaseSens:Boolean=False):Boolean;
//������� ��������� ����� ��� ����� �������� ���� CaseSens=true

(*INC_CRTL\I_KOL.PIN   *)
function Int2Hex( Value : Int64; Digits : Integer =0) : String;
//�������� Integer to String � 16������ �������
//���� ����� ���������� ������ Digits, �������� ������ �����
function StrSatisfy( const S, Mask: String ): Boolean;
{* Returns True, if S is satisfying to a given Mask (which can contain
   wildcard symbols '*' and '?' interpeted correspondently as 'any
   set of characters' and 'single any character'. If there are no
   such wildcard symbols in a Mask, result is True only if S is maching
   to Mask string.) }


(*INC_CRTL\I_MidEx.Pin*)
Function Replace(Var Expr:String;SearchSubStr,ReplaceSubStr:String;ProgressProc:TProgressProc=nil):Integer;
//����� ����� ����� SearchSubStr �� ReplaceSubStr, ��������� � Expr.
Function Modify(Expr,SearchSubStr,ReplaceSubStr:String;ProgressProc:TProgressProc=nil):String;
//����� ������-��������� ������ SearchSubStr �� ReplaceSubStr � Expr.
function Modify2(const S, SearchSubStr,ReplaceSubStr:String;IgnoreCase:Boolean=False;ReplaceAll:Boolean=True): string;
//�� ������� �������������� ��������
Function FindPair(Expr:String;Bra:String;Cket:String;CursorPos:Integer;casesens:Boolean=True):String;
//����� ������, ���������� ���� ����� �������� Bra � Cket � ������
//��������� ��������� ��� ������. ���������� ������� Colorer by Cail Lomecb
//"�������� ���� �� ��������" + CtrlIns
Function FindFirstInnerBracket(Expr,Bra,Cket:String):String;
//����� ������ ���������� (����� ���������) ������ ��������� �� ��������
Function EOLtoCRLF(Expr:String):String;
//����� ������ � ����������� EOL (CR,LF,LFCR->CRLF)
Function GetParamValue(Expr,ParamName:String;EqMark:String='=';Start:Integer=1;Delimiter:String=' '):String;
//����� �����, ������� �� ParamName+EqMark �� Delimiter (�� ������� Delimiter)
Function MidEx(S:String;Start,V_Lenght:Integer;ExMode:Integer;S_Start:String='';S_End:String=''):String;
//����������� ������� ������� Mid.
//MidEx ���������� ��������� ������ S, ������� ��������� �����
//���������� ��� �������� ��������������� �������� (��� Mid, ���� �������),
//��� � ������� (������) ��������� � ������ �������� (�����������).
//��� �������� ��� ��� ���� ������� ������������ ��������� S_Start � S_End
//��� ������ � ����� ������� ��������������.
//������ ���������� �������������� ������ ������������ ���������� ExMode.
//������� ���� ExMode:
//
//MIDEX_DIFF_START(0):
//       ����� ��������� ������ ����� ������ �������������� ������ (Start):
//          0-�������� ������ ������ �������������� ������ � ����� Start
//          1-�������������� ������ �������������� ������ �� ���������
//            ������ ��������� - ������� ������ �������
//
//MIDEX_INCREASE_START(1):
//       ������ ������ ��������� ������ ����� Start:
//          0-������ ����� (��������� �����)
//          1-������ �����  (��������� �����)
//
//MIDEX_DEL_STARTSUBST(3):
//       ��������� ������ ������� �������������� ������:
//          0-�� ������ ��������� (� ������ ����������)
//          1-�� ����� ���������  (��� �������)
//
//MIDEX_DIFF_END(4):
//       ����� ��������� ������ ��������� �������������� ������:
//          0-�������� ������ ����� �������������� ������
//          1-�������������� ����� �������������� ������ �� ���������
//            ������ ��������� - ������� ������� �������
//
//MIDEX_INCREASE_END(5):
//       ������ ������ ��������� ������ ��������� �������������� ������:
//          0-������ �����  (��������� �����)
//          1-������ ����� (��������� �����)
//
//MIDEX_DEL_ENDSUBST(6):
//       ��������� ������� ������� �������������� ������:
//          0-�� ����� ���������  (������� �)
//          1-�� ������ ��������� (��� ������ ���������)
//
//MIDEX_LENGTH_AS_NUMBER(7):
//       �������� ��������� V_Lenght:
//          0-����� �������������� ������ (��� ��� Mid)
//          1-����� ���������� ������� �������������� ������ (��� ��� SubStr)
//
//MIDEX_EMPTY_IF_BORDERCROSS(8):
//       ��������� ��� ���������� ��������� ��� ��� ����������� ������
//   (������ ����������� ���� ������� ��� ��������):
//          0-��������� ��������� ������� � ���������
//            (��������� � ���������) ��������
//          1-������� ������ ������
//   ����������� ������ ����������, ����
//  - �������� ������ ������� �� ������ ���������
//    ������� (Start+V_Lenght ��� V_Lenght)
//  - �������� ������� ������� �� ������ ��������� ������ (Start)
//�.��, ���� � ������ ���������� ��������� ����� ��������� ���������
//("�������� ��������") ���������� ����������� ������.
//
//MIDEX_IGNORE_NEGATIVE(9):
//       ��������� � ������ �������� �������������� ��������
//   (������� ������ ���������� � ������):
//          0-������������� ����������� ������
//            (���������� �������� ��������)
//          1-������������ ����������� ������
//
//MIDEX_IGNORE_POSITIVE(10):
//       ��������� � ������ �������� �������������� ��������
//   (������� ������ ���������� � �����):
//          0-������������� ����������� ������
//          1-������������ ����������� ������
//

//���������� ����������� ��������:
Const
 MIDEX_DIFF_START           =$01;
 MIDEX_DIFF_END             =$08;
 MIDEX_INCREASE_START       =$02;
 MIDEX_INCREASE_END         =$10;
 MIDEX_DEL_STARTSUBST       =$04;
 MIDEX_DEL_ENDSUBST         =$20;
 MIDEX_LENGTH_AS_NUMBER     =$40;
 MIDEX_EMPTY_IF_BORDERCROSS =$80;
 MIDEX_IGNORE_NEGATIVE      =$100;
 MIDEX_IGNORE_POSITIVE      =$200;
// � ���������, ����� �� �����������


Function TruncateString(Expr:String;NeedLength:Integer;TruncType:Byte=0):String;
//����� ������ - ��������� �������� Expr �� ����� NeedLength.
//+-------------+------------------+----------------------------------------------+
//� ����������� �Trunc             � ������������ ��������                        �
//�   ����      �Type              �                                              �
//+-------------+------------------+----------------------------------------------+
//�Length(Expr) �TSTT_TRUNC_START  � ������ NeedLength �������� Expr              �
//�>NeedLength  +------------------+----------------------------------------------+
//�             �TSTT_TRUNC_END    � ��������� NeedLength �������� Expr           �
//�             +------------------+----------------------------------------------+
//�             �TSTT_TRUNC_START3D� ������ NeedLength-3 �������� Expr + '...'    �
//�             +------------------+----------------------------------------------+
//�             �TSTT_TRUNC_END3D  � ��������� NeedLength-3 �������� Expr + '...' �
//�             +------------------+----------------------------------------------+
//�             �TSTT_TRUNC_MID3D  � �������������� �����, �����                  �
//�             �                  � ������� � ���������� ��������� - '...'       �
//�             �                  � � �������� � ��������� ������ ���� ����      �
//�             �                  � �������, ���� � _�����_ ������ �� 1          �
//+-------------+------------------+----------------------------------------------+
//�Length(Expr) �TSTT_TRUNC_START  � Expr, ����������� ���������                  �
//�<=NeedLength �TSTT_TRUNC_START3D� � ����� �� ����� NeedLength                  �
//�             +                  +----------------------------------------------+
//�             �TSTT_TRUNC_END    � Expr, ����������� ���������                  �
//�             �TSTT_TRUNC_END3D  � � ������ �� ����� NeedLength                 �
//�             +                  +----------------------------------------------+
//�             �TSTT_TRUNC_MID3D  � Expr, �������������� ���������               �
//�             �                  � �� ����� NeedLength. ������ ������ - � ����� �
//+-------------+------------------+----------------------------------------------+
//� ������ NeedLength<5 ������� Expr

//���������� ����������� ��������:
Const
TSTT_TRUNC_START   = 0;
TSTT_TRUNC_END     = 1;
TSTT_TRUNC_START3D = 2;
TSTT_TRUNC_END3D   = 3;
TSTT_TRUNC_MID     = 4;
TSTT_TRUNC_MID3D   = 4;

Function VerticalIndent(Expr:String;IndentCount:Byte):String;
//������� ������ �� ������ ������ ������ Expr �� IndentCount ��������

(* INC_CRTL\I_Parse.PIN *)
Function Split(Expr:String;Delimiter:String;var Rslt:TStrArray;LoseDelimiter:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//����� ����� ��������� Delimiter � Expr, ��� �� ����������������
//������ ������� ������� Rslt �� 1, � ���������� ������ Rslt ��������
//����������� ������� Expr �� Delimiter'�.
//��������!!! Delimiter ��������� � ����� ���������� ������!!!
//���� ������� LoseDelimiter=True, �� Delimiter "��������������"
//FE:����� Split('123///456','//',s) S[0]='123//',S[1]='/456'
//���� Delimiter='', �� S[0]=Expr
Function FastSplit(Expr:String;Delimiter:String;var Rslt:TStrArray;LoseDelimiter:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//������ ���������� ������ Split, �������� ��� ������� Expr
Function SplitToEqParts(Expr:String;PartSize:Integer;var Rslt:TStrArray;ProgressProc:TProgressProc=nil):Integer;
//�������� ������ �� ���������� �� ���������� ������ �����
Function KillSpaces(Expr:String):String;
//����� �� ������� �� ������ �� ������ (cr,lf,tab,#32)
Function SplitToWords(Expr:String;Var Wds:TStrArray;ProgressProc:TProgressProc=nil):Integer;
//�������� Expr �� �����, ������ ����������� ���������������� Tab, CR, LF, CRLF, Space
Function SplitToParagraphs(Expr:String;Var Paras:TStrArray;AllowEmptyParagraphs:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//�������� Expr �� ��������� �� CR, LF, LFCR � CRLF
//���� AllowEmptyParagraphs=false, ������ ��������� ��������.
Function SplitToDoubleParagraphs(Expr:String;Var Paras:TStrArray;AllowEmptyParagraphs:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//�������� Expr �� ��������� �� �������� CRLF+CRLF
Function SplitByBrackets(Expr,Bra,Cket:String;Var Rslt:TStrArray;KillBrackets:Boolean=False;casesens:Boolean=true):Integer;
//��������� Expr �� ������� �� �������� ���� Bra � Cket.
//��� ���������� ��� ������ ��������.
//���� KillBrackets=true, �� ���������� � ���� ������
Function FindBracket(Expr,Bra,CKet:String;KillBrackets:Boolean=True;Start:Integer=0;casesens:Boolean=true):String;
//����� ��������� ����� Bra � CKet, ���� KillBrackets, �� ��� Bra,CKet, ����� ������� ������ ������.
Function GetWordByNo(Expr:String;WordNo:Integer;CountFromStart:Boolean=True):String;
//����� ����� � ������� WordNo �� ������, ���� CountFromStart, ����� �� �����. ��������� ��� � ����.
//� ������ ���������� ����� � ������ ������� ����� ������ ������.
Function GetParagraphByNo(Expr:String;ParaNo:Integer;CountFromStart:Boolean=True):String;
//����� ����� � ������� ParaNo �� ������, ���� CountFromStart, ����� �� �����. ��������� ��� � ����.
//� ������ ���������� ������ � ������ ������� ����� ������ ������.
Function GetFirstWord(var Expr:String):String;
//����� ������ ����� Expr, ��� ���� ������ ����� ���������� �� expr.
//����������� ���� ���� � ����������� ������� (���� #20#9) ���������
Function GetFirstParagraph(var Expr:String):String;
//����� ������ �������� Expr, ��� ���� ������� ��� �� expr.
Procedure VerticalSplit(Expr:String;var Part1,Part2:String;Splitpos:Integer);overload;
//�������� � Part1 � Part2 ������� Expr, ����������� �� Splitpos.
//Expr[Splitpos] - ��������� ������� �������
Procedure VerticalSplit(Expr:String;var Part1,Part2:String;Delim:String;LoseDelimiter:Boolean=True);overload;
//�������� � Part1 � Part2 ������� Expr, ����������� �� Delim.
//���� LoseDelimiter=False, �� Delim ������������� � Part1

function Trim(const S: string): string;
//�� ��������. ���� ��� TruncateSpaces 

(* INC_CRTL\I_BitRoutines.PIN *)
Function IntToBit(Arg:Byte):String;overload;
Function IntToBit(Arg:Word):String;overload;
Function IntToBit(Arg:LongWord):String;overload;
//������ ������ - �������� ������������� ���������
//����� ����� ������ ���������� �������, ��� ������� ��� ��� ������
Function IsBitsSet(Val,Bits:Cardinal):Boolean;
//����� True, ���� � Val ������� ���� Bits
Function SetBits(Val,Bits:Integer;ToSet:Boolean):Integer;overload;
Function SetBits(Val,Bits:Cardinal;ToSet:Boolean):Cardinal;overload;

Function SetBits(Val,Bits:Byte;ToSet:Boolean):Byte;overload;
//����� Val � �������������� ������ Bits � ToSet

(* INC_CRTL\I_Arrays.PIN *)
Function Join(StAr:Array of String;Delimiter:String='';Start:Integer=0;Finish:Integer=-1):String;overload;
Function Join(StAr:Array of String;var Order:TIntArray;Delimiter:String=''):String;overload;
Function JoinI(const Arr:Array of int64;Delim:String=vbcrlf):String;overload;
//������ ������� ������� StAr � ������ ����� Delimiter.
//� ������ � � ����� Delimiter �� !!�����������!!
//����� ������� ������� ������, ������ � ���� ������ ������ ������� Order
//������ ���� ����� ������� StAr
//SLOW!!!

Function Filter(Source:Array of String; var Rslt:TStrArray;SubStr:String):Integer;OverLoad;
Function Filter(Source:Array of String; var Rslt,Unsatisfactions:TStrArray;SubStr:String):Integer;Overload;
//���������� Rslt �� ��������� Source, ���������� � ���� SubStr
//� Unsatisfactions ����� ��������, �� ���������� SubStr
//����� High(Rslt)
Procedure KillEquals(Var IA:TIntArray);
//����� ���������� �������� �� ������� IA (SLOW!!!)
Procedure IntQSort(Var IA:TIntArray);overload;
Procedure IntQSort(Var IA:TIntArray;Var Indexes:TIntArray);overload;
//��������� ������ IA ���������� QuickSort
//����� ����� ������� ������ Indexes, �����, ���
//Indexes[NewStrPos]=OldStrPos
Procedure StrQSort(Var Wds:TStrArray);overload;
Procedure StrQSort(Var Wds:TStrArray;Var Indexes:TIntArray);overload;
//��������� ������ ����� Wds ���������� QuickSort
//����� ����� ������� ������ Indexes, �����, ���
//Indexes[NewStrPos]=OldStrPos
Procedure Concatenate(Var Rslt:TStrArray;Src:Array of String);
//������� ������ Src � ����� ������� Rslt
//SLOW!!!
Function IsElement(TstArr:TStrArray;Element:String):Integer;OverLoad;
Function IsElement(TstArr:TIntArray;Element:Int64):Integer;OverLoad;
Function IsElement(TstArr:Array of word;Element:Integer):Integer;OverLoad;
Function IsElement(TstArr:TByteArray;Element:Byte):Integer;OverLoad;
//������ ������ ������� ���� �� ��������� Element, ���� ����� ���, �� -1
Procedure AppendElement(var Arr:TStrArray;NewElement:String);overload;
Procedure AppendElement(var Arr:TIntArray;NewElement:Int64);overload;
Procedure AppendElement(var Arr:TChArray;NewElement:Char);overload;
Procedure AppendElement(var Arr:TByteArray;NewElement:Byte);overload;
Procedure AppendElement(var Arr:TRealArray;NewElement:Real);overload;
Procedure AppendElement(var Arr:TDoubleArray;NewElement:Double);overload;
Procedure AppendElement(var Arr:TWordArray;NewElement:Word);overload;
Procedure AppendElement(var Arr:TCoolArray;NewElement:TCoolType);overload;
Procedure AppendElement(var Arr:TTVarArray;NewElement:TVariant);overload;
//Procedure AppendElement(var Arr:TInt64Array;NewElement:Int64);overload;
//�������� ����� Arr �� 1 � ������� NewElement � �����
Procedure AppendNElements(var Dest:TStrArray;Src:Array of String);overload;
Procedure AppendNElements(var Dest:TIntArray;Src:Array of Int64);overload;
//������� ������ Src � ������� Dest, Src �� ����������


Procedure CharArrToByteArr(var Source:TChArray;var Dest:TByteArray);
//��������� Source � Dest, ������� Char �� Byte
Procedure ByteArrToCharArr(var Source:TByteArray;var Dest:TChArray);
//��������� Source � Dest, ������� Byte �� Char
Procedure Swp(var A,B:Integer);Overload;
Procedure Swp(var A,B:Int64);Overload;
Procedure Swp(var A,B:Byte);Overload;
Procedure Swp(var A,B:Word);Overload;
Procedure Swp(var A,B:Char);Overload;
Procedure Swp(var A,B:String);Overload;
Procedure Swp(var A,B:Cardinal);Overload;
Procedure Swp(var A,B:Boolean);Overload;
Procedure Swp(var A,B:Extended);Overload;
//����� ����������� ���������� A � B
Function DelElement(var SA: TStrArray; Index: Integer):Boolean;overload;
Function DelElement(var SA: TIntArray; Index: Integer):Boolean;overload;
//������ ������ � �������� Index �� SA. ����� ��������� ��������:
//���� ������ ����������, ����� False.
//���������
Procedure FillRand(var IA:TIntArray;Count:Integer;Range:Integer=0;KeepData:Integer=0);
//������ ������ IA ���������������� ��������� �� 0 �� Range-1,
//����� IA �������� Count. if Range<Count then Range:=Count
//�������� ��������� ����, ������������������ ������ �������� ��� ������� Count
//KeepData - ����� ������� �������� ���������. ��� ������� �� ���������� ������� - �������������� � 0
procedure FillLinear(var IA:TIntArray;count:integer;start:Integer=0;finish:Integer=2147483647);
//�������� ������ ������� �� ������� (0,1,2...count-1), ��� ���������� finish-1 �������� �� start
Procedure Shuffle(VAR IA:TIntArray);
//��������� �������� �������
Function RandomString(Len:Integer):String;
//����� ������ �� ��������� �������� ������ Len



(* INC_CRTL\I_DateTime.PIN *)
Function FormatMoment(Moment:double;Fmt:String=''):String;
//����� ����� � ������� Fmt.
//    ������ ��������� Fmt ������� FormatMoment
//������������ �������� - ������, ��������� �� ������ Fmt �������:
//%YYYY% - �� 4 ����� ���� (%YY � 1981 ���� ����� 81)
//%M%    - �� ����� ������
//%M0%   - �� ����� ������ � ������� ����
//%D%    - �� ����� ���
//%D0%   - �� ����� ��� � ������� ����
//%H%    - �� ����� ����
//%H0%   - �� ����� ���� � ������� ����
//%H12%  - �� ����� ���� � ����������������� �������
//%H012% - �� ����� ���� � ����������������� ������� � ������� ����
//%AP!amstr!?pmstr?% - �� amstr ���� �� ������� � pmstr ���� �����
//%I%    - �� ����� ������
//%I0%   - �� ����� ������ � ������� ����
//%S%    - �� ����� �������
//%S0%   - �� ����� ������� � ������� ����
//%E%    - �� 1..3 �����  �����������
//%E0%   - �� 3 �����  ����������� � ������� ����
//%E1%   - �� ������� ���� ������� (1 ������)
//%E2%	 - �� ����� ���� ������� (2 �������)
//%DC%   - �� ����� ���� � ����, ���������� �� ��������� ���������� Moment
//������� �������� �� �����
//��� ������������� �������� ������ exe �� ~10Kb
//���� �������� Fmt ������, �� ��������������� ������ ���� 
//���� '%YY%%M0%%D0%%H0%%I0%%S0%'
function GTCFormatMoment(Moment:cardinal;Fmt:String=''):String;
//����� FormatMoment ��� ������ ����� ����������
Function Now: Double;
//����� ������� ������ � ������� TDateTime
Function UTC:Double;
//����� ������� ������ � ������� TDateTime �� ��������
Function ToUTC(date:double):Double;
Function FromUTC(date:double):Double;
//�������������� �\�� UTC

Function Date:Double;overload;
Function Date(DT:Double):Double;overload;
//����� ������� ����, ��� ���� DT (0:00:00.000)
Function Time:Double;overload;
Function Time(DT:Double):Double;overload;
//����� ������� �����, ��� ����� DT (30.12.1899)
Function Day(Data:Double):Byte;
//����� ����� (������) ��� ������� Data � ������� TDateTime
Function Month(Data:Double):Byte;
//����� ����� ������ ��� ������� Data � ������� TDateTime. ������ - 1
Function Year(Data:Double):Word;
//����� ����� ���� ��� ������� Data � ������� TDateTime. 
Function DOW(Data:Double):Byte;
//����� ����� ��� ������ ��� ������� Data � ������� TDateTime. �� - 0, �� - 1, ... �� - 6
Function Hour(DT:Double):Byte;
Function Minute(DT:Double):Byte;
Function Second(DT:Double):Byte;
Function BuildDate(_Year,_Month,_Day:Word):Double;
//����� ���� � � ������� TDateTime
Function UnixDateTime(D:Double):Int64;
//����� <unixtime> - ����� � �������� � 1 ������ 1970 �.
  { TODO : Implement DateUtils }
Function FirstDayOfMonth(data:Double):Double;
//����� ������ ���� ������

(* INC_CRTL\I_Formats.PIN *)
Function FormatExpr(Const Template,Arg:String;LeaveDoublePersentAsIs:Boolean=False):String;overload;
Function FormatExpr(Const Template:String;Arg:Array of String;LeaveDoublePersentAsIs:Boolean=False):String;overload;
//������ ��������� ������ ��������� '%i' ������ Template ������ Arg, i=[0...2^31)
//���� LeaveDoublePersentAsIs = False, �� ��������� '%%' ������� ��� '%',
//����� ��� '%%'
//Function Int2Str(i:integer;MinDigitsCount:integer=0):String;overload;
Function Int2Str(i:Int64;MinDigitsCount:integer=0):String;overload;
//�������� _�������������_ Integer to String
//���� ����� ���������� ������ MinDigitsCount, �������� ������ �����
Function Int2StrEx(i:int64;MinDigitsCount:integer=0;DigitsInGroup:Integer=0;GroupDelim:String=' '):String;
//������ ������������ ����������� ��� ����� ��������� �� ������:
//���������� ���� � ������ =DigitsInGroup, ���� 0 - �� ���������,
//�����������=GroupDelim, ���� '' - �� ���������
Function Str2Int(S:String;DefVal:Integer=0):Int64;overload;
//Function Str2Int64(S:String;DefVal:Int64=0):Int64;
//���� S - ��������� ������������� �����, ������ �����, ����� - DefVal,
//������ ����� ��� ����������, ��� � ����������� ������������� �����
//���������� �������������� ������ ���, � hex ������ ������ "$" � ������.
Function IsDecimal(S:String):Boolean;
//����� True, ���� S - ��������� ������������� ����������� �����
Function IsNumeric(S:String):Boolean;
//����� True, ���� S - ��������� ������������� �����
Function Bool2Int(B:Boolean):Integer;
//���� B=True, ����� 1, ����� - 0
Function Bool2Str(B:Boolean):String;
//True\False


(* INC_CRTL\I_Stacks.pin *)
Function TriggerInt(Command:Integer;Value:Integer=0):Integer;
Function TriggerStr(Command:Integer;Value:String=''):String;
Function TriggerBool(Command:Integer;Value:Boolean=False):Boolean;
//������ ��������� - ������������ ���������. ������ ��������� ��������
//� ������� ���� ���������. ������������� ���������� �� ����� �������
//������ TriggerXXX.
//��������� ��� ������� ������ - treadvar
//	������� ������ � ���������������:
//|-------------------------------------------------------|
//|�������� |     ��������            | ������������      |
//|Command  |                         | ��������          |
//|         |                         |                   |
//|-------------------------------------------------------|
//|0        |  ���������� ���������   | ����������        |
//|TRIG_SET | �������� ������ Value.  |���������          |
//|-------------------------------------------------------|
//|1        | ������ ���������        | �������           |
//|TRIG_GET |��������                 |���������          |
//|-------------------------------------------------------|
//|����� -  | ������ ���������.       | ������� ��������� |
//--------------------------------------------------------|
//��������� ������� ��������������� ����
//��������� ������� ��������������� ������ �������
//���������� ������� ��������������� False

//���������� ����������� ��������
Const
TRIG_SET            = 0;
TRIG_GET            = 1;

Function FILOInt(Command:Integer;Value:Integer=0):Integer;
Function FILOStr(Command:Integer;Value:String=''):String;
Function FIFOInt(Command:Integer;Value:Integer=0):Integer;
Function FIFOStr(Command:Integer;Value:String=''):String;
//���������� (����������� �����).
//��� ������� ������ ���������� ���� ���� ����� ������ ����������� � ������ J+
//���������� ������ ���� FILO (����) � ���� FIFO (�������).
//FILO (first in - last out)  - ��������, ��������� ���������, ������ ������
//FIFO (first in - first out) - ��������, ��������� ������, ������ ������
//
//    ������� ������ � ������������
//+------------+-------------------+---------+
//� �������    �   ��������        � ������� �
//+------------+-------------------+---------+
//�0           ��������� �����     �0 ��� '' �
//�STACK_PUSH  ��������� (Push)    �         �
//�            ��� Value           �         �
//+------------+-----------------------------+
//�1           �������� ���������  ��������� �
//�STACK_POP   ��������� (Pop)     �         �
//+------------+-----------------------------+
//�2           ���������� ����������������� �
//�STACK_PEEK  ��������� (Peek)    �         �
//+------------+-----------------------------+
//�3           ��������� ����������0 ��� '' �
//�STASK_DEPTH ��������� �         �         �
//�            �TriggerInteger     �         �
//+------------+-----------------------------+
//�4 STACK_ZERO��������� ��������� �0 ��� '' �
//+------------+-----------------------------+
//������       ������� �� ������   �0 ��� '' �
//+------------+-----------------------------+
// ������� ������� ����� ����� STACK_EMPTY, ��� ��� ����� � ����� ������� = 2

//���������� ����������� ��������
Const
STACK_PUSH          = 0;
STACK_POP           = 1;
STACK_PEEK          = 2;
STASK_DEPTH         = 3;
STACK_ZERO          = 4;
STACK_EMPTY	    = -1;

(*INC_CRTL\I_Counters.PIN*)

Function GlobalCounter(Modify:Boolean=False;Increment:Integer=1;
		       Reset:Boolean=False;ResetTo:Integer=0;
                       Limit:Integer=$0FFFFFFF):Integer;
//���������� �������. �������� ��������� ResetTo ��� ������ ���������, ���
//���������� ���������� ������������� �� Increment. ��� �� ���������� �������
//Limit, ����� ������������ �� ResetTo.
//��� ��������� ���������� �������� ���������� �������� Modify ������ True
Function GC(Number:Byte;Modify:Boolean=False;Increment:Integer=1;Reset:
	    Boolean=False;ResetTo:Integer=0;Limit:Integer=$0FFFFFFF):Integer;
//���� ���������� ���������. ��������� �� 0 �� 4. �������� ��� ��, ��� ������� �
//������� ���� ������� ����� � ���� number. ��� ������������ number ������
//������� globalcounter
Function RegCounter(ord,min,max:Integer;Increment:Integer=1):Integer;
//����� ����� �� �������,
//ord - ���������� ����� ��������
//min - ����������� ��������
//max - ������������
//Increment - ���������
Function GTC(Push:Boolean):Cardinal;
//�������� ���, ���� Push, ����� ����� ������� ����� ���������� � �������� ��������


(*INC_CRTL\I_SnapWindows.pin*)
Function SnapTopWindows(var HA:TIntArray):Integer;
//����� ����� ���� �������� ������, ������ HA ���������� �� ��������
Function SnapAllChildWindows(HParent:Integer;var HA:TIntArray):Integer;
//����� ����� �������� ���� ��� HParent, ������ HA ���������� �� ��������

(* INC_CRTL\I_WndWrap.pin *)
Function GetWndClassName(hWnd:Integer):String;
//����� ��� ������ ���� � ������������ hWnd
Function GetWndCaption(hWnd:Integer):String;
//����� ��������� ���� � ������������ hWnd
Procedure SetWndCaption(HWnd:Integer;S:String);
//��������� ��������� ���� � ������������ hWnd � �������� S
Function GetWndInfo(hWnd:Integer):Byte;
//����� ���������� � �������� ���� � ������������ hWnd
//������ ������������� ��������:
//������ 2 ����: (0� � 1�)
//       00-�������,
//       01-���������,
//       10-���������;
//2-� ���:
//        ������/��������;                  (1/0)
//3-� ���:
//        ��������/����������;              (1/0)
//4-� ���:
//        ������ ����/�� ������ ����        (1/0)
//10110

Function SetWndInfo(hWnd:Integer;Info:Byte):Boolean;
//��������� �������� ���� � ������������ hWnd � ������� GetWndInfo
Function IsWndTopMost(hWnd:Integer):Boolean;
//���� ���� � ������������ hWnd ����� ������� "������ ����", ����� True
Procedure SetWndTopMost(HWnd:Integer;bTopMost:Boolean);
//���� bTopMost=True, ��������� ���� � ������������ hWnd �������
//"������ ����", ����� ������ ���.
Function GetWndPos(hWnd:Integer):TRect;
//����� ���������� ����
Procedure ShowWnd(hWnd:Integer;bVisible:Boolean);
//�������\������� ����
Function WaitForWndEx(Caption,ClsName:PChar;ProgressProc:TProgressProc):Integer;
//����� ���������� ���� (���� ��� ����) ��� ���� (���� ���) � �����
//��������� � ����������� �����, ������� ProgressProc.
//� �������� ���������� ������� ProgressProc ����������:
// - OpDone     - ���� ���� ����, �� 1, ����� 0
// - OpCount    - ������ 1
// - FuncID     - UCRTL_ID_WAIT4WND
//������������� ������������ Wait4Wnd � Wait4WndDie
Function Wait4Wnd(Caption:String;ClsName:String='';ProgressProc:TProgressProc=nil):Integer;
//����� ���������� ���� � ���������� Caption � ������� ClsName (����� ��
//���������), ���� ��� ����. ���� ��� ���, �� ����� ���������� ��� ���������
//� ����������� �����.
//� �������� ���������� ������� ProgressProc ����������:
// - OpDone     - ������ 0
// - OpCount    - ������ 1
// - FuncID     - UCRTL_ID_WAIT4WND
Procedure Wait4WndDie(Caption:String;ClsName:String='';ProgressProc:TProgressProc=nil);
//������� �������� ���� � ���������� Caption � ������� ClsName (����� ��
//���������). ���� ��� ������������, ����� ��������� � ����������� �����.
//� �������� ���������� ������� ProgressProc ����������:
// - OpDone     - ������ 1
// - OpCount    - ������ 1
// - FuncID     - UCRTL_ID_WAIT4WND

(* INC_CRTL\I_Msgbox.pin *)
Function MsgBox(Prompt:String;Title:String='';Style:Integer=vbInformation):Integer;OverLoad;
Function MsgBox(Prompt:Integer;Title:String='';Style:Integer=vbInformation):Integer;OverLoad;
Function MsgBox(Prompt:Integer;Title:Integer;Style:Integer=vbInformation):Integer;overload;
Function MsgBox(Prompt:String;Title:Integer;Style:Integer=vbInformation):Integer;overload;
Function MsgBox(Prompt:Boolean;Title:String='';Style:Integer=vbInformation):Integer;overload;
//������ ������� MessageBox
Procedure UC;
//������� ��������� "Under construction"
Procedure GLE;
//������� ��������� GetLastError � MSGBOX
Function GLEStr:String;overload;
//������ SysErrorMessage
Function GLEStr(ErrCode:Integer):String;overload;
//SysErrorMessage ��� ���� ������
Function AnsiGLEStr(ErrCode:Integer):String;
//SysErrorMessage ��� ���� ������ � ��������� Windows
Function Confirm(Prompt:String;Title:String='';NoByDef:Boolean=False):Boolean;
//Msgbox �������������

//Function InBox(Prompt:String;Title:String='';PrevVal:String=''):String;
//������ ������ ��� ����� ������
//!!NOTWORKPROPERLY!!

(*INC_CRTL\I_Kbrd.PIN*)
procedure SimulateKeyDown(Key:byte);
//��������� ������� �������
procedure SimulateKeyUp(Key:byte);
//��������� ������� �������
procedure SimulateKey(Key:byte);
//��������� �������+������� �������
Procedure SendKeys(Seq:String);
//������� ������������������ ������� ������ Seq �� ���������� �������������
//����� �� MS Windows. ������ ��� � ���, ������� ������� ��� ��� �����������,
//��� � �����������.
//������������������ Seq ������������ �� ���� ������, ��������� �������
//����� �� ��������� ��������� ����������� � ����� ���:
//   - ������������������ ������������������!
//   - ������� � �������� ������������, �.�. ������_������������!!!
//     ������������������ ���������� �����������!!!
//   - ������ ������� �� ����, ������ �� ������� ������������ �� ����
//     �������� ���������� ������� � ��������� ��� ���. ��������� ������ 4:
//        - Alt     &_
//        - Shift   %_
//        - Ctrl    ^_
//        - Win     $_
//     ��� ������, ��� ������ CtrlShiftO � %_^_O ������������.
//     �������� ����� ��������� � ������������ �������.
//     �������� ������:
//0	        ������� "0"
//1             ������� "1"
//2	        ������� "2"
//3	    	������� "3"
//4	    	������� "4"
//5	    	������� "5"
//6	     	������� "6"
//7	    	������� "7"
//8	    	������� "8"
//9	    	������� "9"
//A	    	������� "A"
//B	    	������� "B"
//C	    	������� "C"
//D	    	������� "D"
//E	    	������� "E"
//F	    	������� "F"
//G	    	������� "G"
//H	    	������� "H"
//I	    	������� "I"
//J	    	������� "J"
//K	    	������� "K"
//L	    	������� "L"
//M	    	������� "M"
//N	    	������� "N"
//O	    	������� "O"
//P	    	������� "P"
//Q	    	������� "Q"
//R	    	������� "R"
//S	    	������� "S"
//T	    	������� "T"
//U	    	������� "U"
//V	    	������� "V"
//W	    	������� "W"
//X	    	������� "X"
//Y	    	������� "Y"
//Z	    	������� "Z"
//`	    	������� "`", �� ��� ������ (~) � ����� �
//=	    	������� "=", � ������ ����� "+"
//-	    	������� "-"
//\	    	������� "\", �� ��� "|"
///	    	������� "/", �� ��� "?"
//,	    	������� ",", �� ��� "<"
//.	    	������� "."  �� ��� ">"
//;             ����� � �������
//'             �������
//[             ������
//]             ������
//BS          	������� "BACKSPACE"
//
//ESC	    	������� "ESC"
//F1	    	������� "F1"
//F2	    	������� "F2"
//F3	    	������� "F3"
//F4	    	������� "F4"
//F5	    	������� "F5"
//F6	    	������� "F6"
//F7	    	������� "F7"
//F8	    	������� "F8"
//F9	    	������� "F9"
//F10	    	������� "F10"
//F11	    	������� "F11"
//F12	    	������� "F12"
//F13	    	������� "F13"
//F14	    	������� "F14"
//F15	    	������� "F15"
//F16	    	������� "F16"
//F17	    	������� "F17"
//F18	    	������� "F18"
//F19	    	������� "F19"
//F20	    	������� "F20"
//F21	    	������� "F21"
//F22	    	������� "F22"
//F23	    	������� "F23"
//F24	    	������� "F24"
//SPACE	    	������� "SPACE"
//
//TAB	    	������� "TAB"
//CAPS	    	������� "CAPS LOCK"
//APPS	    	������� "APPS"
//PRNSCR   	������� "PRINTSCREEN"
//SCRLOCK   	������� "SCROLL LOCK"
//NUMLOCK   	������� "NUMLOCK"
//BREAK	    	������� "BREAK"
//
//INS	    	������� "INS"
//HOME	    	������� "HOME"
//PGUP	    	������� "PAGE UP"
//DEL	    	������� "DEL"
//END	    	������� "END"
//PGDN	    	������� "PAGE DOWN"
//LEFT	    	������� "LEFT" , ������� �����
//UP	    	������� "UP"   , ������� �����
//RIGHT	    	������� "RIGHT", ������� ������
//DOWN	    	������� "DOWN" , ������� ����
//
//NP0	    	������� "NUMPAD 0"
//NP1	    	������� "NUMPAD1"
//NP2	    	������� "NUMPAD2"
//NP3	    	������� "NUMPAD3"
//NP4	    	������� "NUMPAD4"
//NP5	    	������� "NUMPAD5"
//NP6	    	������� "NUMPAD6"
//NP7	    	������� "NUMPAD7"
//NP8	    	������� "NUMPAD8"
//NP9	    	������� "NUMPAD9"
//NP.	    	������� "NUMPAD"
//NP/	    	������� "NUMPAD"
//NP*	    	������� "NUMPAD"
//NP-	    	������� "NUMPAD"
//NP+	    	������� "NUMPAD"
//
//!XX	    	����������� ������� ��� ������� ��������.
//	    	����� ���������������� ����� ������ ���� �����������������
//	    	��� �������. �������� �����������.
// 		���� ������ �� Win32.hlp:
//VK_LBUTTON	01		Left mouse button 
//VK_RBUTTON	02		Right mouse button 
//VK_CANCEL	03		Control-break processing 
//VK_MBUTTON	04		Middle mouse button (three-button mouse) 
// ? 		05-07		Undefined 
//VK_BACK	08		BACKSPACE key 
//VK_TAB	09		TAB key
// ?	 	0A-0B		Undefined 
//VK_CLEAR	0C		CLEAR key
//VK_RETURN	0D		ENTER key 
// ?	 	0E-0F		Undefined 
//VK_SHIFT	10		SHIFT key 
//VK_CONTROL	11		CTRL key 
//VK_MENU	12		ALT key 
//VK_PAUSE	13		PAUSE key 
//VK_CAPITAL	14		CAPS LOCK key 
// ? 		15-19		Reserved for Kanji systems 
// ? 		1A		Undefined 
//VK_ESCAPE	1B		ESC key 
// ? 		1C-1F		Reserved for Kanji systems 
//VK_SPACE	20		SPACEBAR 
//VK_PRIOR	21		PAGE UP key 
//VK_NEXT	22		PAGE DOWN key 
//VK_END	23		END key 
//VK_HOME	24		HOME key 
//VK_LEFT	25		LEFT ARROW key 
//VK_UP		26		UP ARROW key 
//VK_RIGHT	27		RIGHT ARROW key 
//VK_DOWN	28		DOWN ARROW key 
//VK_SELECT	29		SELECT key 
// ? 		2A		Original equipment manufacturer (OEM) specific 
//VK_EXECUTE	2B		EXECUTE key
//VK_SNAPSHOT	2C		PRINT SCREEN key for Windows 3.0 and later 
//VK_INSERT	2D		INS key 
//VK_DELETE	2E		DEL key
//VK_HELP	2F		HELP key 
//VK_0		30		0 key 
//VK_1		31		1 key 
//VK_2		32		2 key 
//VK_3		33		3 key
//VK_4		34		4 key 
//VK_5		35		5 key 
//VK_6		36		6 key 
//VK_7		37		7 key 
//VK_8		38		8 key 
//VK_9		39		9 key 
// ? 		3A-40		Undefined 
//VK_A		41		A key 
//VK_B		42		B key 
//VK_C		43		C key 
//VK_D		44		D key 
//VK_E		45		E key 
//VK_F		46		F key 
//VK_G		47		G key 
//VK_H		48		H key 
//VK_I		49		I key 
//VK_J		4A		J key
//VK_K		4B		K key 
//VK_L		4C		L key 
//VK_M		4D		M key 
//VK_N		4E		N key 
//VK_O		4F		O key 
//VK_P		50		P key 
//VK_Q		51		Q key 
//VK_R		52		R key 
//VK_S		53		S key 
//VK_T		54		T key 
//VK_U		55		U key 
//VK_V		56		V key 
//VK_W		57		W key 
//VK_X		58		X key
//VK_Y		59		Y key 
//VK_Z		5A		Z key 
//VK_LWIN	5B		Left Windows key (Microsoft Natural Keyboard) 
//VK_RWIN	5C		Right Windows key (Microsoft Natural Keyboard) 
//VK_APPS	5D		Applications key (Microsoft Natural Keyboard) 
// ? 		5E-5F		Undefined 
//VK_NUMPAD0	60		Numeric keypad 0 key 
//VK_NUMPAD1	61		Numeric keypad 1 key 
//VK_NUMPAD2	62		Numeric keypad 2 key 
//VK_NUMPAD3	63		Numeric keypad 3 key 
//VK_NUMPAD4	64		Numeric keypad 4 key
//VK_NUMPAD5	65		Numeric keypad 5 key 
//VK_NUMPAD6	66		Numeric keypad 6 key 
//VK_NUMPAD7	67		Numeric keypad 7 key 
//VK_NUMPAD8	68		Numeric keypad 8 key 
//VK_NUMPAD9	69		Numeric keypad 9 key 
//VK_MULTIPLY	6A		Multiply key 
//VK_ADD	6B		Add key 
//VK_SEPARATOR	6C		Separator key 
//VK_SUBTRACT	6D		Subtract key 
//VK_DECIMAL	6E		Decimal key 
//VK_DIVIDE	6F		Divide key 
//VK_F1		70		F1 key 
//VK_F2		71		F2 key 
//VK_F3		72		F3 key 
//VK_F4		73		F4 key 
//VK_F5		74		F5 key 
//VK_F6		75		F6 key 
//VK_F7		76		F7 key 
//VK_F8		77		F8 key 
//VK_F9		78		F9 key
//VK_F10	79		F10 key 
//VK_F11	7A		F11 key 
//VK_F12	7B		F12 key 
//VK_F13	7C		F13 key 
//VK_F14	7D		F14 key
//VK_F15	7E		F15 key 
//VK_F16	7F		F16 key 
//VK_F17	80H		F17 key 
//VK_F18	81H		F18 key 
//VK_F19	82H		F19 key 
//VK_F20	83H		F20 key 
//VK_F21	84H		F21 key 
//VK_F22	85H		F22 key 
//VK_F23	86H		F23 key 
//VK_F24	87H		F24 key 
// ? 		88-8F		Unassigned 
//VK_NUMLOCK	90		NUM LOCK key 
//VK_SCROLL	91		SCROLL LOCK key 
// ? 		92-B9		Unassigned 
// ? 		BA-C0		OEM specific 
// ? 		C1-DA		Unassigned 
// ? 		DB-E4		OEM specific 
// ? 		E5		Unassigned 
// ? 		E6		OEM specific 
// ? 		E7-E8		Unassigned 
// ? 		E9-F5		OEM specific 
//VK_ATTN	F6		Attn key
//VK_CRSEL	F7		CrSel key
//VK_EXSEL	F8		ExSel key
//VK_EREOF	F9		Erase EOF key
//VK_PLAY	FA		Play key
//VK_ZOOM	FB		Zoom key
//VK_NONAME	FC		Reserved for future use. 
//VK_PA1	FD		PA1 key
//VK_OEM_CLEAR	FE		Clear key
// 

procedure NullMouseEvent;
//��������� �������� ����� �� (0,0)

(*INC_CRTL\I_BorMath.PIN *)
//function Max(const A, B: Integer): Integer; overload;
function Max(const A, B: Int64): Int64; overload;
function Max(const A, B: Single): Single; overload;
function Max(const A, B: Double): Double; overload;
function Max(const A, B: Extended): Extended; overload;
//function Min(const A, B: Integer): Integer; overload;
function Min(const A, B: Int64): Int64; overload;
function Min(const A, B: Single): Single; overload;
function Min(const A, B: Double): Double; overload;
function Min(const A, B: Extended): Extended; overload;
Function InBounds(val,min,max:Extended;ClosedBounds:Boolean=True):Boolean;
//����������� �� val ��������� min..max? �������� ��������, ���� ClosedBounds=True

(* INC_CRTL\I_Math.PIN *)
Function Char2Byte(Ch:Char):Byte;
//�������� �������� (0..F) ������ � �����. ��� ������ ����� 32
Procedure AdjustNumDelims(var Expr:String);
//�������� ���� ���������� ����� ����� ����� Num � �������� �� �����������
Function MinNumeration(Expr:String):Byte;
//�������������� ������ �� ������� � �������������� � ��������
//��������� (��) � ����� ����������� (��� 711 ����� NUM_OCT)
//�������������, ��� 16-��� ������� ��������� ���������������� �
//� ��� �� ����� �������� ������, � ������� ����� (ABCDEF)
//����������� � ������ ��������
Function IsBelong2Num(Expr:String;Numeration:Byte):Boolean;
//����� True, ���� Expr ����� ���������������� ��� ����� � ��������� ��
Function TruncateZeros(Expr:String):String;
//������� ��� ���� ����� �� ������ �������� �����.
//���� ��������� �� ��� ��������� ������ ��������, ������� ���� 0
//����� ����������� ��� ���������� ������� �����.
Function Num2Num(Expr:String;PrevNum,NeedNum:Byte):String;
//�������� Expr (���� ������� �� ����������) �� �� PrevNum � �� NeedNum
Function Operation(OP1,OP2:String;Num1,Num2,OPKind:Byte):String;
//��������� �������������� �������� ��� OP1,OP2 � �� Num1,Num2 ����
//OPKind. ��. ��������� OP_
//� ������ ������ ����� EMPTYSTRING ('');
Function Compare(OP1,OP2:String):Integer;
//���� OP1<OP2, ����� CMP_SECONDMORE
//���� OP1=OP2, ����� CMP_EQ
//���� OP1>OP2, ����� CMP_FIRSTMORE
//OP1,OP2 ������ ���� � ����� ��!
Function ChangeSign(Expr:String):String;
//�������� ���� � Expr. ������ ����� ������� ������� �� �����������.

function ParseBracketBlock(bracket:String):String;
//������� ���������� - ����� ������� ����
// ((colName1 [=,!]= value1) [&&,||] ...()... [&&,||] (colNamex [=,!]= valuex)),
// ��� colName� - ��� ������� (0�� ������ �����, ������ � ����� ������� ��������),
//     value� - �������� ������ ����� (�� ����� ���� ����� ������� �� �������), �������������� ����� �������.
//��� ��������� �������� �������:
// ��������� ���������: == - �����, != - �� �����
// �������� � ������� - �� ����������������, ��� valuex ���������� ����� * � ?
//  ( * - ����� ����� ����� ��������, ? - ����� ������, � ��� ����� � �������������, � colnamex ����� ���� �� ������)
// ���� ������ ������ 1, � ����� ���� ����� ����� [&&,||], �� � ����������� ������ ����������� �������� ["and","or"] ��������������.
// ���������� � ���������� ���������� ���������� ����� ������� (��� �� ������) ������� � ������� �������, ����� � �������
// ��� ���������� ��� ������ �� ����������� ������� ������� ��������� ������� � �� ��������������


procedure Factorize(i:Int64;var da:TIntArray);
//�������� ����� i �� ���������, ����� ��������� � ������� da
//�������� ������������ ������, ������� ��� �� �� ������� ������,
//���� �� �����
Procedure GetAllDivisors(i:int64;var ria:TIntArray);
//�������� ������ ria ����� ���������� ���������� ����� i, ������� i � 1


function sum(ia:Array of Int64):Int64;
//����� �������
Function avg(ia:Array of Int64):Double;
//������� ������� (��� ������������)
Function Product(ia:Array of Int64):Int64;
//������������ ���������


(*INC_CRTL\I_MiscAPI.PIN*)
function IsNT : bool;
//���� �������� ��� NT ����� TRUE
Procedure Delay(ms:cardinal;ProgressProc:TProgressProc=nil);
//��������� �������� �� ms �����������
//��� ���� ��� ��������� � �����, ���� �������� ������ ��� ProgressProc
Procedure SetAutoRunInfo(ToSet:Boolean;Name:String='';ToLM:Boolean=False);
//��������/������ ������ ��������� �/�� ������������/�
//ToSet: True - ���������, False - �������
//Name: ��� ��������� ������������
//ToLM: True - ���������� � HKEY_LOCAL_MACHINE, False - � HKEY_CURRENT_USER
Function IIF(condition:Boolean;iftrue:String;iffalse:String):String;overload;
Function IIF(condition:Boolean;iftrue:Integer;iffalse:Integer):integer;overload;
Function IIF(condition:Boolean;iftrue:Double;iffalse:Double):Double;overload;
//Inline if
procedure nop;
//������ �� ������
Function GetResource(resname:String;ressect:PAnsiChar=RT_RCDATA):String;
//����� ������ - ���������� ������� resname �� ������ ressect ���� �� ����, ��� ������ ������
Function NTreboot(EWXuFlags:Cardinal):Boolean;
//������������\���������� ��� NT. ���� False - GetLastError ?
Function String42Integer(S:String):Integer;
Function Integer2String4(j:Integer):String;
//�������������� ������ � ������ �� 4� ���� � �������
Function String82Int64(S:String):Int64;
Function Int642String8(j:Int64):String;
//�������������� ������ � ������ �� 8 ���� � �������


(* INC_CRTL\I_FileRoutines.PIN *)
Function IsWildCardInPath(Path:String):Boolean;
//���� ��������� �������� '*' or '?', �� ����� True
Function FileExists(Path:String):Boolean;
//����� True, ���� ���� ����������.
//� ������� �� SysUtil���� ����� �������������� wildcard�
//��� ������� ������� ������������ �����
Function FolderExists(Path:String):Boolean;
//����� True, ���� ����� ����������.
//��� ������� ������� ������������ �����
Function mkdir(Path:String):Boolean;
//������� ����������. ���� ���-�� �� ���, ����� False
Function SMkDir(path:String):Integer;
//������������ �������� ����������. � ������ ������ ����� ��� getlasterror
Function Del(Path:String):Boolean;
//����� ����, ���� �� ����� - ����� False
Function CopyMove(Src,Dest:String;Move:Boolean;OverWrite:Boolean=True):Boolean;
//��������� ���� Src � Dest, ���� Move=True, ����� Src. ����������� ������������, ���� OverWrite=True
Function FileToString(FileName:String;FillNullChars:Char=#0):String;
//����� ������, ��������� ���������� �����, Chr(0):=Chr(32) by default
Function StringToFile(S:String;FileName:String;Overwrite:Boolean=False;ConfirmIfExists:Boolean=False):Boolean;
//������� ������ � ����.
//��������� Overwrite � ConfirmIfExists ��������� ���������� � ������
//������������� ����� FileName. ���� ���������� � ConfirmIfExists=True, ��
//�������� messagebox � �������� � ����������, ������ ���� Overwrite=False,
//�� �� ��������� ������ messagebox� ����� "���", ���� ��� ��������� True -
//�� ������ "��"
//� ������ ������ ����� True
Procedure StrArrayToFile(Var SA:TStrArray;FileName:String;Delimiter:String='';Overwrite:Boolean=False;ConfirmIfExists:Boolean=False);
//������� ������ ����� � ���� ����� Delimiter
Function IsFileName(TestFN:String):Boolean;
//�������� TestFN �� ������� ������������ �������� (*,?,|,/,<,> � : ����� 2 ���)
Function ProcessPath(Path:String;ProcessType:Byte):String;
//����� ��������� �������� � ������.
//��� �������� ������� ���������� ProcessType.
//��������� �������� ��������� ProcessType:
//0: PPPT_LEAVEASIS
//    �� ������� ������ (�������� � ��������� ������)
//1: PPPT_FILENAME_FILEEXT
//    ���������� ��� ����� � ������������ (��� ����)
//2: PPPT_FILENAME
//    ���������� ��� ����� ��� ���������� (��� ����).
//     ���� ����� ���������� - ����� ���
//3: PPPT_FILEEXT
//    ���������� ��������� ���������� ����� ��� �����
//4: PPPT_PARENTDIR
//    ���������� ��� �����, � ������� ��������� ����
//5: PPPT_DELALLEXT
//    ����� ������ ��� ����� ��� ����������
//    ���� ��� ����������
//6: PPPT_DELLASTEXT
//    ����� ������ ��� ����� ��� ���������� ����������
//7: PPPT_DELFIRSTFOLDER
//    ����� ������ ����� - ������� \
//32: PPPT_FORCEBACKSLASH (������� �����)
//    ���� ��� ���������� ������� ��������� �����
//      0: ����������� �� �����
//      1: ����������� �����


//���������� ����������� ��������
Const
PPPT_LEAVEASIS       =0;
PPPT_FILENAME_FILEEXT=1;
PPPT_FILENAME        =2;
PPPT_FILEEXT         =3;
PPPT_PARENTDIR       =4;
PPPT_DELALLEXT       =5;
PPPT_DELLASTEXT      =6;
PPPT_DELFIRSTFOLDER  =7;
PPPT_FORCEBACKSLASH  =32;

Function GetCurDir:string;
//����� ������� ����������
Function SetCurDir(const Dir: string): Boolean;
//��������� ������� ����������, � ������ ������ ����� False

Function TruncPath(Path:String;NeedLength:Integer;TruncType:Byte=0):String;
//������� Path �� ����� NeedLength (��� �������) � ����������� �� TruncType:
//TpTT_CUTMID  : ������ ������ "..."
//TpTT_CUTEND  : ������ �����  "..."
//TpTT_CUTSTART: ������ ������ "..."
//����� ������ ��� �� '\'

//���������� ����������� ��������
Const
TpTT_CUTMID  =  0;
TpTT_CUTEND  =  1;
TpTT_CUTSTART=  2;


Function BuildPath(FolderName,Name:String):String;
//����� ���� � ����� �� ��� ����� � ����� ����� ��� ������� �� �������
Function BuildRemotePath(comp,path:String):String;
//����� ���� � ��������� ����� ����� ���� *$
Function EnumFiles(Path:String; var Files:TStrArray;FullPath:Boolean=False;WildCard:String='*'):Integer;
//����� ����� ������ � ���������� path, ������ Files ���������� ������� ������
Function EnumFolders(Path:String; var Files:TStrArray;FullPath:Boolean=False):Integer;
//����� ����� �������� ���������� path, ������ Files ���������� ������� ��������
Function BuildTree(RootFolder:String;var Files:TStrArray;FullPath:Boolean=False;IncludeFiles:Boolean=True;IncludeFolders:Boolean=False;WildCard:String='*'):Integer;
//����� ����� ������ � ���������� RootFolder � ���� � ���������
//���� FullPath=True, �� � Files ����� ���������� ����
//IncludeFiles � IncludeFolders ����������, �������� �� � ������ ����� � ����� ��������������.
//����� ���������� ����� ����� ������ �� ��, �.��. �������� ����� ���������� ���������

Procedure EnumDrives(var DrvLetters:TStrArray);
//�������� ������ ����� ��������� ����� ������� ��������� ������

function FileDate(fn:String):Double;
//����� ���� ���������� ��������� ����� � ������� TDateTime, ���� ���� �� ���������� - ����� -1
function FileCreationTime(fn:String):Double;
//����� ���� �������� ����� � ������� TDateTime, ���� ���� �� ���������� - ����� -1

Function GetFileSize(fn:String):Int64;
//����� ������ ����� � ������

Function GetFolderSize(RootFolder:String):Int64;
//����� ������ ����������� �������� � ������ (���� � ���������� �������, ��������� �����)
function GetDiskSize(drive: String; var free_size, total_size: Int64): Boolean;
//����� true � ������ ������ GetDiskFreeSpaceEx, free_size - ��������� �����, total_size - �������
Function GetDiskSizeFree(drive:String):Int64;
//������ ��� GetDiskSize
Function GetDiskSizeAvail(drive:String):Int64;
//������ ��� GetDiskSize


Function FileVersion(FileName: string):String;
//����� ������ ����� �� VersionInfo
function GethInstancePath: String;
//����� ���� ����������� dll\exe
Function deltree(path:String):Boolean;
//����� ����� � ������� � ����������

function SpecialDir(Dir: Integer): String;
//����������� �������
CONST
 CSIDL_PERSONAL             = $0005; //C:\��� ���������
 CSIDL_APPDATA              = $001A; //C:\WINDOWS\Application Data
 CSIDL_LOCAL_APPDATA        = $001C; //C:\WINDOWS\Local Settings\Application Data
 CSIDL_INTERNET_CACHE       = $0020; //C:\WINDOWS\Temporary Internet Files
 CSIDL_COOKIES              = $0021; //C:\WINDOWS\Cookies
 CSIDL_HISTORY              = $0022; //C:\WINDOWS\History
 CSIDL_COMMON_APPDATA       = $0023; //C:\WINDOWS\All Users\Application Data
 CSIDL_WINDOWS              = $0024; //C:\WINDOWS
 CSIDL_SYSTEM               = $0025; //C:\WINDOWS\SYSTEM
 CSIDL_PROGRAM_FILES        = $0026; //C:\Program Files
 CSIDL_MYPICTURES           = $0027; //C:\��� ���������\��� �������
 CSIDL_PROGRAM_FILES_COMMON = $002B; //C:\Program Files\Common Files
 CSIDL_DESKTOP              = $0000; //C:\WINDOWS\������� ����
 CSIDL_PROGRAMS             = $0002; //C:\WINDOWS\������� ����\���������
 CSIDL_FAVORITES            = $0006; //C:\WINDOWS\���������
 CSIDL_STARTUP              = $0007; //C:\WINDOWS\������� ����\���������\������������
 CSIDL_RECENT               = $0008; //C:\WINDOWS\Recent
 CSIDL_SENDTO               = $0009; //C:\WINDOWS\SendTo
 CSIDL_STARTMENU            = $000b; //C:\WINDOWS\������� ����
 CSIDL_NETHOOD              = $0013; //C:\WINDOWS\NetHood
 CSIDL_FONTS                = $0014; //C:\WINDOWS\FONTS
 CSIDL_TEMPLATES            = $0015; //C:\WINDOWS\ShellNew
 CSIDL_COMMON_PROGRAMS      = $0017; //C:\WINDOWS\All Users\������� ����\���������
 CSIDL_PRINTHOOD            = $001b; //C:\WINDOWS\PrintHood

 CSIDL_INTERNET             = $0001;
 CSIDL_CONTROLS             = $0003;
 CSIDL_PRINTERS             = $0004;
 CSIDL_BITBUCKET            = $000a;
 CSIDL_DESKTOPDIRECTORY     = $0010;
 CSIDL_DRIVES               = $0011;
 CSIDL_NETWORK              = $0012;
 CSIDL_COMMON_STARTMENU     = $0016;
 CSIDL_COMMON_STARTUP       = $0018;
 CSIDL_COMMON_DESKTOPDIRECTORY = $0019;
 CSIDL_ALTSTARTUP           = $001d;         // DBCS
 CSIDL_COMMON_ALTSTARTUP    = $001e;         // DBCS
 CSIDL_COMMON_FAVORITES     = $001f;

Function GetTemp:String;
//����� ��������� %temp%
Function GetVolumeSerial(vol:char):String;
//����� �������� ����


(*INC_CRTL\I_Console.PIN*)
Procedure CWrite(S:String);
//������ ������ Write
Function CGotoXY(X,Y:Byte):Boolean;
//��������� ������� ������� ������� � (X,Y), � ������ ���� ����� False.
Function CGetStdColor:Byte;
//����� ���� ������ ������
Function CSetStdColor(Foreground,BackGround:Byte):Boolean;overload;
Function CSetStdColor(Color:Byte):Boolean;overload;
//��������� ���� ������ ������
Procedure CLS;
//������� �������
Function CCurX:Byte;
Function CCurY:Byte;
//������ ������� ��������� X � Y ��������������
Function CMaxX:Byte;
Function CMaxY:Byte;
//������ ������������������� �������� X � Y ��������������
//� ������ ��������� �������
Procedure CCWrite(Expr:String);
Procedure CCWriteln(Expr:String);
//������� ������� ������.
//��� ����������� ����� ����������� �������� ������������ ��������� ���� ^FB,
//��� F-��� ����� ������� � 16������ ������� (forecolor),
//B-��� ����� ���� ������� � 16������ ������� (backccolor).
//��� ������ ������� "^" ($5E) ������� ��������� ��������� ^^ � Expr
//����� ������ ��������� ���� � �������������� ���������
procedure CCReadKey;
//��� ������� ����� �������
Procedure CSetTitle(S:String);
//������� ��������� ������� �� S
Function CGetTitle:String;
//����� ��������� �������
Function DnetProgress(curr:integer;prev:integer=0):String;
//����� ��������� ��������� ��� � ������� distributed.net �� ����� ���������
//curr, ���� prev <> 0 - ������ ������������ ����� ����� ���������



(* INC_CRTL\I_ByteFileRoutines.PIN *)
Function FileToByteArray(FileName:String;var BA:TByteArray):Integer;
//����� ������ �������� �����, ������� � BA ��� ����������
Function FileToChArray(FileName:String;var BA:TChArray):Integer;
//����� ������ �������� �����, ������� � BA ��� ����������
Procedure ByteArrayToFile(var BA:TByteArray;FileName:String;Overwrite:Boolean=False;ConfirmIfExists:Boolean=False);
//������� ������ ���� BA � ����.
//��������� Overwrite � ConfirmIfExists ��������� ���������� � ������
//������������� ����� FileName. ���� ���������� � ConfirmIfExists=True, ��
//�������� messagebox � �������� � ����������, ������ ���� Overwrite=False,
//�� �� ��������� ������ messagebox� ����� "���", ���� ��� ��������� True -
//�� ������ "��"
Procedure StringToByteArray(S:String;Var BA:TByteArray);
//��������� ���������� ������ S � ������ ���� BA

Function ByteArrayToStr(var BA:TByteArray;FillNullChars:Char=#32;ProgressProc:TProgressProc=nil):String;
//����� ������, ������������ �� BA, ������� $00 �� FillNullChars.
//���� � BA ����������� $00, �� � ��������� ����� ����������
//������ FillNullChars
Procedure XORByteArray(Var BA:TByteArray;Key:Byte);overload;
Procedure XORByteArray(Var BA:TByteArray;Key:String);overload;
//��������� BA � ������ Key
Procedure UnXORByteArray(Var BA:TByteArray;Key:Byte);overload;
Procedure UnXORByteArray(Var BA:TByteArray;Key:String);overload;
//���������� BA � ������ Key
Procedure StatBA(var BA:TByteArray;var StatArr:TIntArray);
//�������� StatArr(��������� ��� ����������� =[0..255])
//����������� ��������������� ���� � BA
Function Bin2Hex(Bin:String;Delim:String=#$20;ShiftEnd:Boolean=False):String;
//����� ������� �������� ������ Bin (��������� ������ 0 � 1) � 16������ ��� ����� ����������� delim
//���� ����� ���������� �� �������, ��� ���������������� ��� ����!! ���� CrLf � Space!!
//������ ����������� ������ �� ����� ������� 8.
//���� ShiftEnd=True, �� ������ ����� ��������� ������ � �����, ����� � ������.


(*INC_CRTL\I_HexStrRoutines.PIN  *)
Function IsStrHexStr(HexStr:String):Boolean;
Function IsStrIntStr(IntStr:String):Boolean;
Function IsStrOctStr(OctStr:String):Boolean;
Function IsStrBinStr(BinStr:String):Boolean;
//���� � ������ ��� ������� ����������� ��������� ���� ������ ������� ��� �����
//��������� � ��������� ��������, �� ����� True

Function CorrectHexStr(Var HexStr:String):Byte;
//������� �� ������, ��������� �� HexStr. ���� ���������, ����� CHS_CORRECT
//� ������� HexStr � ���� StringToHexString.
//���� ������ �����������, ������� � ��� ��������� � ����� ��� ������:
//CHS_EMPTY_EXPR - ������ �� �������� �������� ��� �������������
//CHS_EVEN_QUANTITY - �������� ����� �������� �������� � ������
//CHS_IRREGULAR_SYM - � ������ ������ ������������ ������

//���������� ����������� ��������
Const
CHS_CORRECT		=0;
CHS_EMPTY_EXPR		=1;
CHS_EVEN_QUANTITY	=2;
CHS_IRREGULAR_SYM       =3;

Function ByteArrayToHexStr(var BA:TByteArray;BytesInString:Integer=8;ProgressProc:TProgressProc=nil;PerByteDelim:String=' '):String;
//����� ������, ������������ ���������� BA ��������� �������:
//� ������ ������ BytesInString ���� � 16������ ������������� ����� ������.
//� ����� ������ ������� ���.
//��������, ���� � ����� �������� 'ABCDEFGHIJ', �� ��������� ���
//BytesInString = 8 ����� �����:
//41 42 43 44 45 46 47 48
//49 4A
Function HexStrToStr(HexExpr:String;FillNullChars:Char=#0;ProgressProc:TProgressProc=nil):String;
//����������� HexExpr � ������ ��������. �������� ��� ByteArrayToStr
//��������, �� HexExpr '41 42 43 44 45 46 47 48 49 4A' ����� 'ABCDEFGHIJ',
//� ���� � HexExpr ���������� '00', �� � ��������� ����� ����������
//������ FillNullChars
//������������!!
Function RealignHexStr(HexExpr:String;BytesInString:Integer=8;ProgressProc:TProgressProc=nil):String;
//����� ������ - ����������� HexExpr � ������������ � ���������:
//� ������ ������ BytesInString ���� � 16������ ������������� ����� ������.
//� ����� ������ ������� ���.
Function HexStrToByteArray(HexExpr:String;var BA:TByteArray;ProgressProc:TProgressProc=nil):Boolean;
//������� ������������ �������������� ������ � ������� HexExpr � ������ ����
//���������� ��� ��������������, �������� �������� ������� ByteArrayToHexStr
//���� �������������� ��������� �������, ����� True, ����� - False
Function StringToHexString(Const S:String; Delim:String=' '):String;
//����� ������, ���������� ���� �������� ������ S � ������� HexExpr
//����� delim � ��� ���������� �� ���������



(* INC_CRTL\I_Settings.PIN *)
Function SetSetting(Path,Name,Value:String;LazyWrite:Boolean=True;RootKey:LongWord=HKEY_CURRENT_USER):Boolean;
//������� � ����� ������� Path ��������� �������� Name �� ��������� Value.
//��� ������� ����� ��������� ���������� �������� �� ����, ���������
//LazyWrite � False � ������� RootKey. � ������ ������ ����� True.
Function GetSetting(Path,Name:String;RootKey:LongWord=HKEY_CURRENT_USER):String;
//����� �������� ���������� ������� Name � ����� Path ����� RootKey. ���� � ���, �����
//������ ������.

(*I INC_CRTL\I_Registry.PIN*)
Function RegWriteString(RootKey:cardinal;Subkey,Name:String;Value:String;LazyWrite:Boolean=True):Boolean;
//������� � ������ ������. [RootKey\SubKey] "Name"="Value".
//��� ������� ����� ��������� ���������� �������� �� ����, ���������
//LazyWrite � False. � ������ ������ ����� True.
//� ������ �������� ������� GetLastError
Function RegWriteInteger(RootKey:cardinal; Subkey,Name:String; Value: Integer;LazyWrite:Boolean=True):Boolean;
//������� � ������ ����� �����. [RootKey\SubKey] "Name"=Value.
//��� ������� ����� ��������� ���������� �������� �� ����, ���������
//LazyWrite � False. � ������ ������ ����� True.
//� ������ �������� ������� GetLastError

Function RegDelValue(RootKey:cardinal; Subkey,name:String;LazyWrite:Boolean=True):Boolean;
//������ �� ������� ���� (���� �� �� �������� SubKeys)
//��� ������� ����� ��������� ���������� �������� �� ����, ���������
//LazyWrite � False. � ������ ������ ����� True.
//� ������ �������� ������� GetLastError
Function RegDelKey(RootKey:cardinal; Subkey:String;LazyWrite:Boolean=True):Boolean;
//������ �� ������� ��������
//��� ������� ����� ��������� ���������� �������� �� ����, ���������
//LazyWrite � False. � ������ ������ ����� True.
//� ������ �������� ������� GetLastError


Function RegGetString(RootKey:cardinal;Subkey,Name:String;Default:String=''):String;
//������ ������ �� �������. � ������ ������ ����� Default
Function RegGetInteger(RootKey:cardinal;Subkey,Name:String;Default:Integer=0):Integer;
//������ ������ ����� �� �������. � ������ ������ ����� Default



(* INC_CRTL\I_Rectangles.PIN *)
function Rect(Left, Top, Right, Bottom: Integer): TRect;
//����������� ����� ����� � TRect
function Point(X, Y: Integer): TPoint;
//����������� ����� ����� � TPoint
function PtInRect(const Rect: TRect; const P: TPoint): Boolean;
//���� ����� P ����� � �������������� Rect, ����� True
function CenterPoint(const Rect: TRect): TPoint;
//����� ����������� ����� ��������������
Function MoveRect(Rect:TRect;MoveTo:TPoint):TRect;
//����� ������������� ��������� � Rect, ����� ������� ���� ��������
//��������� � ������ MoveTo

(*I INC_CRTL\I_NTPROC.PIN *)
Function NTGetProcessList(var SA:TStrArray):Integer;
//��� NT - ������� ������ ��� ���������
Function NTKillProcess(psname:String;fullname:Boolean=False):Boolean;overload;
//���������: psname - ��� ��������, fullname - ������� ����, ��� ������� ������ ���� �� exe
function NTKillProcess(dwPID:Cardinal):Boolean;overload;
//��� NT - ����� �������. ���� ������ - ����� False � ����� GetLastError
//��� ������� �� psname � ������ ���������� �������������� �������� ����� LastError=87


(* INC_CRTL\I_Scripting.PIN *)
Function PlayScript(Src:String):Integer;
//������� ������������ �������.
//�� ������ ������ Basic-Like syntax.
//��� ������, ���:
//   - �������� �����������������!
//   - ������ �������� ������� �� ����� ������, ��������� ��������� ���!
//   - ��, ��� ����� ����� ������� ��������� ������� (') ���������
//     ������������. ��� �������� ����� �������, � ��������� �������
//     ������ ��������� '' ($27$27)
//��������� ����������:
//   - SendKeys ""               ������� ������������������ ������� ������
//				 ������������ �������. ��������� ���������
//                               � ��������� ��� ��������� U_CRTL.SendKeys
//                               ������: SendKeys "WinR n o t e p a d enter"
//				 �������� �������.
//   - Delay                     �������� ���������� �������.
//                               ������: Delay 1500
//                               ��������� ������ �� 1.5 ���.
//   - MsgBox                    ������� MsgBox. ��������� ���������� ���, ���
//				 � msgboxa ���� ������ �����, ����� � ���������
//				 �� ����������.
Procedure PlayScriptFile(FileName:String);
//��������� ���� �� ��������, ���� ������� ����������


(* INC_CRTL\I_Logging.PIN            *)
Function AppendToFile(FileName:String;Expr:String;AddCrLf:Boolean=True):Boolean;
//������� � ���� FileName ������ Expr � ����������� crlf, ���� AddCrLf=true
//����� False � ������ IOError (use GetLastError)
Function GetLogMsg(Expr:String;MultiStringWithDT:Boolean=True;prefix:String=''):String;
//����������� ������ � ������ � ������� �������� ���� '%D0%.%M0%.%YY% %H%:%I0%:%S0%.%e0%'
//��������� ��� �������������� ���������� ������������ ���������� MultiStringWithDT:
// True - ��� ������ ����� ������ ����������� ������� ���� __������ � �������
// False - ����������� �� ������� - �� ����� �������
// ����� ������� ������� ��� � prefix 
Procedure AppendLogMsg(FileName:String;Expr:String;MultiStringWithDT:Boolean=True);
//������� ��������� expr � ���-���� FileName ��������� GetLogMsg(Expr,MultiStringWithDT)
Procedure AppendCryptedLogMsg(FileName:String;Expr:String);
//������� � ��� ����������� ������
Function ViewCryptedLogMsg(Msg:String):String;
//���������� ���������
Function CryptedLogFileToRegularString(FileName:String):String;
//���������� ��� ���� � ���������� � ����������� ����

(* INC_CRTL\I_CustomIni.PIN	      *)
Function KillComments(S:String):String;
//������� ����������� �� ������.
//������� ������������ ��, ��� ����� ����� � ������� � �� CrLf
//������ ������ ���� �������������
Function LoadCustomIni(CfgString:String;var ParamNames:TStrArray;var ParamTypes:TIntArray;var ParamValues:TTVarArray):Boolean;
//������� �� ���������� ���������������� ����, ���������� �������� ������ ���� � CfgString
//������: $���_���������� : ��� = ��������.
//�������������� ����:
// String - ������
// Int    - ����� �����
// Bool   - ������ ����������, ��������� �������� True � False
// File	  - ����� ���������� �����, ���� ������� ����������, ����� ������ ������
//������, ���� ���������� ����� ����������� ��������, ��
//������� ����� false, � ��� ������� �������� �������.
//��, ��� ������ �� ������ (���,������) �������� � ��� ����� � �� ����������
//�� ����� ����� � ������� - �����������.
//����� �������, ������������� ����������� �� ������� � ���������:
// - ����	(#00)
// - ����	(#09)
// - ��		(#13)
// - ��		(#10)
// - �������	(#32)
// - ����� � ������� (#59)
// - $
//��� ����������� ���������, ���� ������������ ������ String ��� File
//� ������ ������ � ����� ����� false, ����� - true

//���������� ����������� ��������
Const
LCITypeString		   ='STRING';
LCITypeInt		   ='INT';
LCITypeBool		   ='BOOL';
LCITypeFile		   ='FILE';

 LCI_TRUE		   ='TRUE';
 LCI_FALSE		   ='FALSE';

LCI_ERRONEOUS   =0;
LCI_STRING	=1;
LCI_INT         =2;
LCI_BOOL	=3;
LCI_FILE	=4;

Function IsCfgValid(CfgString:String):Boolean;
//��� �� ������ � �������
Function GetCfgStrVar(CfgString:String;ParamName:String;DefVal:String=''):String;
Function GetCfgIntVar(CfgString:String;ParamName:String;DefVal:Integer=0):Integer;
Function GetCfgBoolVar(CfgString:String;ParamName:String;DefVal:Boolean=False):Boolean;
//������ �������� ���������� �� ����� ������������, ������� �������. ����� ������ DefVal
//GetCfgStrVar ����� ����� � ������ ���� LCI_FILE

Function GetRegularIniParam(Expr:String;ParamName:String;Delimiter:String='='):String;
//����� �������� ��������� ParamName �� ����������� ����������� ini-����� Expr:
//����� ������ �� Delimiter �� ���������� crlf. ���� ���������� � ���������� ������
//�����, �� ������������ ���������. ���� �� ������ - ������ ������
//Delimiter �� ������ ������� � ParamName


(*INC_CRTL\I_MD5.PIN       *)
function MD5(const Expr:String): String;
//����� MD5Hash ������
(*I INC_CRTL\I_GOST.PIN    *)
Function GOST(S:String):String;
//����� ��� ������ �� ��������� GOST R 3411-94

(*I INC_CRTL\I_RC5.PIN    *)
Function rc5Encrypt(S:String;key:String):String;
Function rc5Decrypt(S:String;key:String):String;
//���������� � ��������� ������ �� ��������� RC5
//�.�. ���� �������, � ������������� ������ ���������� ����������� ����� � �����
//�������� ������. ��� ����������� ��� �����������, �,
//���� �� ������������� ����������������, ������������ ������ ������ 

(*INC_CRTL\I_Crypting.PIN  *)
Function XorCryptString(S:String;Key:String):String;
Function XorDecryptString(S:String;Key:String):String;
//��������\���������� ������ �� �����. �������� ���������� ���������� �������:
//������ ���� �������� � �����������, ��������� �������� � ������ �����.
//��� ���������� ������� ���, ������� ���� � �����.

Function CryptString(Const Expr:String;Const Key:String):String;
Function DeCryptString(Const Expr:String;Const Key:String):String;
//����������/������������ ������ �� ������ XorCryptString � ������������
//���������� ���������: �� ������ 4 ����� ������ � ����� _�����_ (� ������)
//����������� �������� ��������������� ����, � ���������� ����
//���������� �������������� ����. ����� ����� � �������� ������ �����������
//������� XorCryptString � �������������� ������,
//� ����������� ���������� ���������� �������� ��������������� ��������������.
//������������� ������ ������� �� ������� (������� �� 4 ����)
//� � ������ ������� ����������� ���� 6 ���� 4 ����� � ����������� ��
//���������������� ���� ��������������� ����� �����, ������� �������� ������
//��������������� ����� �������. � ����������� ����� ����������� 1.
//��������, ��������������� ���� ����� ����� ��� $C9 (11001001)
//����� ������������� ������ $F5E4D3C2 ����� �������������� ����� ����� ���
// $70644F456E444D63.
//��� ������������� ������ ������� ����� � ��������� 4 ������ �� ������ ��
//�������� ����������� ��������� ���� ���������������� ����� � � �.
//��� ����� ������������� ������, �� ������� 4, � ���������� �������� �����������
//��������� ������� (4 ��� 6).
Function GetCRC16(S:String):Word;
//����� CRC16 ������ S

Function AppendCRC16(S:String):String;
//����������� � ����� ������ 2 ����� CRC16, ������ ������ � �����,
//������� - �������������.
Function ValidateCRC16(S:String):Boolean;
//��������� ���������� AppendCRC16

Function AppendMD5Hash(S:String;Salt:String=''):String;
//������� � ����� ������ � MD5Hash ������������� CryptString �
//������ (��������� �� ����) ������
//��������� ������ ������� �� 32 �����
//SALT - ����������� ��� �������� ����, �� � �������������� ������ �� ����������
Function ValidateMD5Hash(S:String;Salt:String=''):Boolean;
//��������� ���������� AppendMD5Hash
//SALT - ����������� ��� �������� ����, �� � �������������� ������ �� ����������

Function AppendGOSTHash(S:String;Salt:String=''):String;
//������� � ����� ������ � MD5Hash ������������� CryptString �
//������ (��������� �� ����) ������
//��������� ������ ������� �� 64 �����
//SALT - ����������� ��� �������� ����, �� � �������������� ������ �� ����������
Function ValidateGOSTHash(S:String;Salt:String=''):Boolean;
//��������� ���������� AppendGOSTHash
//SALT - ����������� ��� �������� ����, �� � �������������� ������ �� ����������


Function GetSignedString(S:String):String;
//�������� ������, �� ������������� �������� �������������!
Function ValidateSignedString(S:String):String;
//����� ������ ��� ������� ���� ������� ��� ������ � ������ ������
//���������� � GetSignedString


FUNCTION CRC32(S:STRING) : integer;
//��������� crc32

(* INC_CRTL\I_Unicode.PIN  *)
function USC2toWin1251(USC2Str:string):string;
// ������������� USC2
function Win1251ToUSC2(sm: string): string;
//����������� USC2

function Win1251ToOem(AnsiStr: string): string;
function OemToWin1251(OemStr: string): string;
//no comments

function EncodeBase64(const inStr: string): string;
//���������� ������ � Base64
function DecodeBase64(const CinLine: string): string;
//����������� ������ �� Base64


(* INC_CRTL\I_Melody.PIN  *)

//������� ��� �������: ������������ ���������� ������ �������������� ������� ��� ������������ �� �������.
//������ ���� - 4 �����, �� �������:
//������ (�������) - ������ ����� (����), ������ ���� "��" ������ ������ ����� ����� 57,
//		     "��#" - 58 � � � �� ���������. 0 ������� �����.
//�� �� ������ 255.
//������ - ������������ ����� � ����� �����.
//1 - ���� ���� (�����)
//2 - ����������
//3 - �����
//���, �� ���� ����� ���� �� �������� �����. �� �� ������ 255
//������ - ���� ��������������
//�������� - ��������� ������ ����. ���� 0, �� ����� - ����, ����
//	      1 - ��������� �����, ����� ����������� 3 ����� - ������ ����� � �������������.

//��� StringToMelody ������� ������ � ������������ �����:
//���� � ������������� - ���������, ������� ����� ����.
//�� ��� ����� ����� � ������� - �����������
//������ ����: ����� ����, ������, ���������, � ������� - ������������
//��������:
//����� - ��������� ����������� ����. ������������������.
//����������� ��������:
//C,D,E,F,G,A,B,H. ����� B � H ���������� ���� � �� �� ���� - "��"
//������ - ����� ������ ����.
//������ ������ ������������� ����� 4, �������������� ����� - 3, ������� - 2, ������ 5.
//��������� - ���� ��������� ��� ��������� ����. ��������� �������� +,=,-.
//= - ������� ��� ��� ���������,
//+ - ������� �� �������
//- - �������.
//������������ ���� - ����������� ������������ ���� � �������� �����.
//1 - ���� ���� (�����)
//2 - ����������
//3 - �����
//���
//��� ��������� ������� ���� (3/4 ��) ���������� ������� ��������� ���
//����� ������ ������, �����, ��� ����� �� ������������� ������ �� ��������.
//������������ ����������� ����������� � ������� � �� ������ ��������� 255
//������: A4=(8) ������������� ��������� ���� "��" ������ ������.
//��� ��� ������ ������ �� "��������" ��������, �� �� ����������� ���
//��������� ������� �������� � �������� ������� �������.
//���������� �������:
//T(integer) - ������������� ����� �����, � ������� - ����� ����������� �� ������ ����
//P() - �����, � ������� - ������������ ����� � ������� ������������.
//! - ��������������� ����� ��� ���������� ���
//�������������� ��������� ���������� � ���������

Procedure PlayMusic(Var melody:TIntArray);
//��������� ������� �� melody - ������� �� ���������� �������
Function StringToMelody(MusString:String; var melody:TIntArray):Boolean;
//����������� ������ � �������� �� ���������� ������

(*INC_CRTL\I_LAN.PIN*)
Function ConnectDrv(DrvPath,SharePath:String;User:String='';Pwd:String=''):Boolean;
Function DisconnectDrv(DrvPath:String):Boolean;
//����������� � ���������� �������� �����
Function GetCompName:string;
//����� ��� ����������
function UrlEncode(Str: string): string;
//���������� URL
Function GetCurrentUserName:string;
//��� �������� ������������
function GetNTDomainName: string;
//��� ������, ������������� �� SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon


Function ShareGetAccess(comp,usr,pwd:String;ShareLetter:Char='C';domain:String=''):Cardinal;
//���������� ���
//net use \\comp\ShareLetter$ pwd /user:domain\usr
//����� GetLastError
Function ShareFreeAccess(comp:String;ShareLetter:Char='C'):Cardinal;
//���������� ��� net use /delete \\comp\shareletter$
//����� GetLastError

(*INC_CRTL\I_Run.PIN*)
procedure StartWait(CmdLine:string;Timeout:DWORD=INFINITE);
//��������� ��������� ������ � ��������� ���������� ��������.
//� �������� ��������� ������ ����������� ������!! ����������!! ���� � �����������
Function Run(Cmd:String;show:Boolean=False):Boolean;
//������ ������� WinExec, �.�. �������� ��� ��������� ������
function GetDosOutput(const CmdLine:string;Params:String):string;overload;
function GetDosOutput(const CmdLine:string): string;overload;
//����� ����� ���������� ����������. ��������� ���� �� ����������� �����.

(*INC_CRTL\I_XML.PIN*)
//��� ������ � XML ������������������ - � ��� ��������� ���� ��������!!!
Function XMLOpenTag(Tag:String;TagParam:String=''):String;
//����� ����������� ���
//� ������ 1�7D80123 ����� ��������� �������� � ���
Function XMLCloseTag(Tag:String):String;
//����� ����������� ���
Function XMLFindTag(XML,Tag:String;LoseTag:Boolean=True):String;
//����� �������� ���� Tag �� ��������� XML
Function XMLMakeTag(Val,Tag:String;ValIsSetOfTag:Boolean=False;TagParam:String=''):String;overload;
Function XMLMakeTag(Val:Integer;Tag:String;ValIsSetOfTag:Boolean=False;TagParam:String=''):String;overload;
//������� �������� Val � ��� Tag. ��� ���� ���� �������� Val �������� ������������� �����,
//�� ������������ ��������� �������� ValIsSetOfTag � True, �����, ������������� ���������
//������� CrLf, ������� ��������� �������� � Tag, ������ �������� VerticalIndent � 1 ������.
//� ������ 1�7D80123 ����� ��������� �������� � ���
Procedure XMLKillComments(var XML:String);
//������� �������� - ����� ���������!!


Function XMLGetTagArray(XML,Tag:String;Var SA:TStrArray;LoseTag:Boolean=False):Integer;
//����� ������ ������� SA ���������� �� ���� TAG ������ XML. ���������� ��� TAG ��������
//������ ������� SA �������� � Tag


(*I INC_CRTL\I_SVC.PIN *)
Function SvcInstall(exepath,svcname,dsplname:String;
                    svcdesc:String='';verbose:Boolean=False;
                    reinstall:Boolean=True;MachineName:String='';
                    ServiceType:Integer=SERVICE_WIN32_OWN_PROCESS):Integer;
//��������� ��� ������ svcname (��, ��� ���� ������� � net start)
//� ������ dsplname � ��������� svcdesc ���������� ���� exepath �� ������ machinename,
//��� ���� ���� ����� ������ ��� ���� - ������������� ��� ���� reinstall=true
//��������! verbose=true ����� �������� write(ln), ������������ ������ � ����������
//�����������! - ����� GetLastError
//��� ������� ����� ����� ������� "����", ��� ����������� - ��������

Function SvcUninstall(svcname:String;MachineName:String='';verbose:Boolean=False):Integer;
//��������� �������, ��������� ��� SvcInstall - ����� GetLastError
Function SvcGetPathBySvcName(SvcName:String;MachineName:String=''):String;
//����� ���� �� ������� �� ��� ��������� ����� ��� ������ ������
Function SvcGetState(SvcName:String;MachineName:String=''):Integer;
//����� 0 � ������ ���������������� �������\������ ��� ���������
//� ������ 0 ����� ��������� ������������ GetLastError
//� ������� QueryServiceStatus.dwCurrentState:
const
  SERVICE_STOPPED                = $00000001;
  SERVICE_START_PENDING          = $00000002;
  SERVICE_STOP_PENDING           = $00000003;
  SERVICE_RUNNING                = $00000004;
  SERVICE_CONTINUE_PENDING       = $00000005;
  SERVICE_PAUSE_PENDING          = $00000006;
  SERVICE_PAUSED                 = $00000007;
//  SERVICE_STOPPED:S:='SERVICE_STOPPED';
//  SERVICE_START_PENDING:S:='SERVICE_START_PENDING';
//  SERVICE_STOP_PENDING:S:='SERVICE_STOP_PENDING';
//  SERVICE_RUNNING:S:='SERVICE_RUNNING';
//  SERVICE_CONTINUE_PENDING:S:='SERVICE_CONTINUE_PENDING';
//  SERVICE_PAUSE_PENDING:S:='SERVICE_PAUSE_PENDING';
//  SERVICE_PAUSED:S:='SERVICE_PAUSED';

Function SvcSetState(SvcName:String;SvcState:Integer;MachineName:String=''):Integer;
//��������\���������\���������\�������� ����� ������� SvcName �� ������ MachineName
//����� SvcState � ������ ������, 0 - � ������ ������
//�������� SERVICE_STOPPED, SERVICE_PAUSED, SERVICE_RUNNING, �� ��������� -
//SetLastError(�������� ����� �������=87=ERROR_INVALID_PARAMETER)

Function SvcSendControl(svcName:String;Control:Integer;MachineName:String=''):Integer;
//����� ����������� ��� �������.
//����� GetLastError


(*INC_CRTL\I_StrMath.PIN*)
const SMERR_SUCCESS           =0;
      //�������� ������� ���������
      SMERR_INVALID_NOTATION   =1;
      //������������ ������� ���������
      SMERR_ARGUMENT_EMPTY    =2;
      //������ ��������
      SMERR_INCORRECT_NUMBER_NOTATION=3;
      //���������� ����������� �������� ��� ����� � ������ ��
      SMERR_NEGATIVE_LOWLEVEL_SUBTRACTION=4;
      //������� ������� ������� �� �������� �� ������ ������
      SMERR_DIVISION_BY_ZERO=5;
      //������� ������� �� 0
Function SMGLE:Integer;
//getlasterror ��� ��������� ��������
Function SMlli256Crop(n:String):String;
//������� ������� ���� � n
Procedure SMlli256Expand(var n1,n2:String);
//�������� ����� ����� n1 � n2 �������� ������
Procedure SMlli256Normalize(var n1,n2:String);
//�������� n1 � n2 � ����������� ��� ��������\��������� ���
Function SMlli256ValidateNotation(n:String;c:Char):Boolean;
//����� True, ���� n ����� ������������� ��� ����� � ������� � ���������� C
Function SMlli256Compare(n1,n2:String):integer;
//����� 1, ���� ������ ������, 0 - ���� �����, -1 - ���� ������ ������
Function SMlli256Plus(n1,n2:String):String;
//low level internal PLUS
//n1,n2: items for addition addition in scale of notation 256
//�������������� �������� ����� n1,n2 � ������� ��������� � ���������� 256
Function SMlli256Minus(n1,n2:String):String;
//�������������� ��������� ����� (n1-n2) � ������� ��������� � ���������� 256
//���������� �����, ���� n1 < n2
//� ����� ������ SMERR_NEGATIVE_LOWLEVEL_SUBTRACTION
Function SMlli256Mul(n1,n2:String):String;
//�������������� ��������� ����� n1,n2 � ������� ��������� � ���������� 256
Function SMlli256DivMod(n1,n2:String; var Rslt,Rmndr:String):Boolean;
//�������������� ������������� ������� n1 �� n2
//������� - rslt, ������� - rmndr
//� ������ ������ ����� True
Function SMlli256FFToAny(n:String;c:Char):String;
//������� ����� �� 256������ �� � ����� �� ��������� [2..255]
//� - ��������� ������������������ -1, �� ���� ����� ����������� � 2���� �� ���� ������� 1
Function SMlli256AnyToFF(n:String;c:Char):String;
//������� ����� �� ����� �� � 256������
//� - ��������� ������������������ -1, �� ���� ����� ����������� � 2���� �� ���� ������� 1
//����� ��������� ������ ������ � ���������� � SMERR_INCORRECT_NUMBER_NOTATION � SMGLE
(*INC_CRTL\I_Propis.PIN*)
function Propis(S:Currency; money:boolean; kpk:boolean=False; usd:boolean=false):string;

(*INC_CRTL\I_TLV.PIN*)
Procedure BufferizeTL4VMessage(msg:String; Const protoHeader:String; Var PrevData:String; var outMsgArr:TStrArray);
//����������� ��������� � ��������� ���� header|length|data, �� ��� tag|length|value, ���� ��� �������.
//������ ��������� ����� ����������: ���������|n���������(�_����_������_4)|������
//Length - 4 ����� � ������� Integer2String4
//protoHeader - ��������� ��������� (header)
//PrevData - ������, � ������� ����� ���������� ������������ ���������
//outMsgArr - �������������� ������ ���������.
//msg - ��������� ���������
//� outMsgArr ���������� ��������� �������������� "�� ������".
//PrevData - ����������� ���������� �������, ���� �� �������� ���������, �  ����������� �� ������ ���������, ���� ��������

Function MessageToTL4V(msg:String;Const protoHeader:String):String;
//������� �������� � ������ TL4V (���������|n���������(�_����_������_4)|������)
function GetFirstTL4VMessage(msg:String; Const protoHeader:String):String;
//����� ������ ��������� � ������� TL4V �� ������.
//����� ��� ���� ����� �� �������� :)

(*************************TEST*PART********************************************)

Function RND(range:Integer):Integer;
//��������� ����� - ����� ������� ���������� ���������

Function JoinVia2(S1,S2,Delim:String):String;
//�������� 2 ������ ����� �����, ���� ���� �� ��� ������, ����� ������ (2 ������=������)


function SplitToIntArray(Expr:String;Delimiter:String;var Rslt:TIntArray;defVal:Integer=0):Integer;


implementation

function SplitToIntArray;
var SA:TStrArray;
    j:Integer;
begin
 result:=FastSplit(expr,Delimiter,sa,true);
 setlength(RSLT,LENGTH(SA));
 for j:=0 to high(SA) do RSLT[j]:=Str2Int(sa[j],defVal);
end;



{$I INC_CRTL\I_Borland.PIN            }
{$I INC_CRTL\I_KOL.PIN                }
{$I INC_CRTL\I_Mid.PIN                }
{$I INC_CRTL\I_MidEx.PIN              }
{$I INC_CRTL\I_Parse.PIN              }
{$I INC_CRTL\I_Arrays.PIN             }
{$I INC_CRTL\I_BitRoutines.PIN        }
{$I INC_CRTL\I_DateTime.PIN           }
{$I INC_CRTL\I_Formats.PIN            }
{$I INC_CRTL\I_Stacks.PIN             }
{$I INC_CRTL\I_Counters.PIN           }
{$I INC_CRTL\I_SnapWindows.PIN        }
{$I INC_CRTL\I_WndWrap.PIN            }
{$I INC_CRTL\I_Msgbox.PIN             }
{$I INC_CRTL\I_Kbrd.PIN               }
{$I INC_CRTL\I_BorMath.PIN            }
{$I INC_CRTL\I_Math.PIN               }
{$I INC_CRTL\I_MiscApi.PIN            }
{$I INC_CRTL\I_FileRoutines.PIN       }
{$I INC_CRTL\I_Console.PIN            }
{$I INC_CRTL\I_ByteFileRoutines.PIN   }
{$I INC_CRTL\I_HexStrRoutines.PIN     }
{$I INC_CRTL\I_Settings.PIN           }
{$I INC_CRTL\I_Registry.PIN           }
{$I INC_CRTL\I_Rectangles.PIN         }
{$I INC_CRTL\I_NTPROC.PIN             }
{$I INC_CRTL\I_Scripting.PIN          }
{$I INC_CRTL\I_InitCrtl.PIN           }
{$I INC_CRTL\I_Logging.PIN            }
{$I INC_CRTL\I_CustomIni.PIN          }
{$I INC_CRTL\I_MD5.PIN                }
{$I INC_CRTL\I_GOST.PIN               }
{$I INC_CRTL\I_RC5.PIN                }
{$I INC_CRTL\I_Crypting.PIN           }
{$I INC_CRTL\I_Unicode.PIN            }
{$I INC_CRTL\I_Melody.PIN             }
{$I INC_CRTL\I_LAN.PIN                }
{$I INC_CRTL\I_RUN.PIN                }
{$I INC_CRTL\I_XML.PIN                }
{$I INC_CRTL\I_SVC.PIN                }
{$I INC_CRTL\I_StrMath.PIN            }
{$I INC_CRTL\I_Propis.PIN             }
{$I INC_CRTL\I_TLV.PIN                }



(*TEST*)













Function RND(range:Integer):Integer;
Begin
 result:=round(Random(range));
End;

Function JoinVia2(S1,S2,Delim:String):String;
Begin
If S1='' then
 Begin
  result:=S2;
  exit;
 End;
If S2='' then
 Begin
  result:=S1;
  exit;
 End;
Result:=S1+Delim+S2;
End;



//GetWindowThreadProcessId

//SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
//>>SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
//that doesn't really free allocated memory, it only releases unused memory that was previously allocated but it's not used anymore



procedure test;
var SA:TStrArray;
S:String;
begin
 S:=MessageToTL4V('test1','hdr1')+
    MessageToTL4V('test2','hdr2')+
    MessageToTL4V('test3','hdr1')+
    '';
 msgbox(s);
 BufferizeTL4VMessage('','hdr1',s,sa);
 msgbox(join(sa,vbcrlf));
end;

Initialization
//msgbox(FormatMoment(FirstDayOfMonth(Date-4),'%D0%.%M0%.%YY% %H%:%I0%:%S0%.%e0%'));
//test;
//halt;
end.






