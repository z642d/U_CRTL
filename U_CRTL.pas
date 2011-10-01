unit U_CRTL;
//Ustin'z common runtime library, Copyright © 2003-2008 Ustin
//History applicated @ I_ConstsAndTypes.PIN
interface
{$WRITEABLECONST  ON }    //assignable typed constants
{$LONGSTRINGS     ON }    //use huge strings

Uses windows,messages,U_CRTL_EXT;


function IsDebuggerPresent : boolean; stdcall; external kernel32 name 'IsDebuggerPresent';

//Комментарий всегда после строки

{$i inc_crtl\I_H_ConstsAndTypes.PIN}

{$i inc_crtl\i_H_progressProc.pin}


(* INC_CRTL\I_Mid.PIN *)
Function PasStr(P:PChar):String;
//Сделает строку из PChar
Function PtrToStr(lpBuffer:Pointer;cbBuf:Cardinal):string;
//Сделает из произвольного буфера строку
Function CopyFromStr(var S:String; const pos:integer; var buf; const count:Integer):Integer;
//Копирование из строки в произвольный буфер. Вернёт количество скопированных байт.
//По мотивам TStream.Read
Function CutFromStr(var S:String; const pos:integer; var buf; const count:Integer):Integer;
//Копирование из строки с последующим вырезанием скопированного. Вернёт количество вырезанных байт.
Function PasteToStr(const AVar; Size: Longint): String;
//Произвольная переменная в строку - свёртка move
Function Mid(Const S:String;Start:Integer):Char;OverLoad;
//Вернёт символ № Start, иначе Chr(0)
Function Mid(Const S:String;Start,V_Lenght:Integer):String;Overload;
//Вернёт строку начиная со Start длиной V_Lenght
//Т.о. mid('123456',3,2)='34',mid('123456',3,5)='3456'
Function SubStr(S:String;Start,Finish:Integer):String;
//Вернёт подстроку строки S от Start до Finish
Function SubStrEx(S:String;Start,Finish:Integer):String;
//Вернёт подстроку строки S от Start до Finish
//Если Start или Finish лежат за пределами строки, они заменятся
//соответствующим пределом (1 или Len(S))
//Если Start > Finish, то _!!!СИМВОЛЫ ПОЙДУТ В ОБРАТНОМ ПОРЯДКЕ!!!_
function UCase(const S: string): string;
function LCase(const S: string): string;
//Вернут S в верхнем\нижнем регистре соответственно.
//Выдрано из AnsiUpperCase\AnsiLowerCase.
Function InStr(Expr,SbStr:String;Start:Integer=1;Finish:Integer=0;CaseSensitive:Boolean=true):Integer;
//Вернёт номер символа _начала_ вхождения SubStr в Expr,
//начиная поиск со Start и заканчивая символом № Finish.
//Поиск идёт в обе стороны, т.е. Start>Finish приветствуется
//Если вхождения нет, вернёт 0.
//Также 0 вернётся, если (Start>Finish и Finish=Len(Expr))
Function LastInstr(Expr,SbStr:String;CaseSensitive:Boolean=True):Integer;
//Вернёт последнее вхождение SbStr в Expr
Function InStrCount(Expr,SubStr:String;Start:Integer=1;Finish:Integer=0;CaseSensitive:Boolean=True):Integer;
//Вернёт число вхождений SubStr в Expr[Start..Finish].
//Если Finish=0, то Finish:=Length(Exrp)
Function StrReverse(Expr:String):String;
//Функция используется для построения заданной строки в обратном порядке.
Function Quote(Expr,OpenQuote:String;CloseQuote:String=''):String;
//Заключит Expr в кавычки указанного вида
Function UnQuote(Expr,OpenQuote:String;CloseQuote:String=''):String;
//Уберёт кавычки указанного вида с выражения Expr.
//-:вложенные кавычки тоже уберутся...
{ TODO : Review logic of quote\unquote }
Function TruncateSpaces(Expr:String;TruncType:Byte):String;
//Уберёт пробелы из строки. Также уберёт табы и ЦРЛФ. Управляется битовой маской
//Битовые поля TruncType:
//0: TSpTT_DEL_START    Убрать пробелы в начале
//1: TSpTT_DEL_END      Убрать пробелы в конце
//2: TSpTT_DEL_DOUBLE   Убрать вхождение двойных пробелов в строку
//3: TSpTT_DEL_TABS     применить 2 младших бита к #9
//4: TSpTT_DEL_CRLF     применить 2 младших бита к #13#10


//Декларация именованных констант
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
//Процедуры приведения типов, из названия понятно что куда приводится

Function StrEq(S1,S2:String;CaseSens:Boolean=False):Boolean;
//Функция сравнения строк без учёта регистра если CaseSens=true

(*INC_CRTL\I_KOL.PIN   *)
function Int2Hex( Value : Int64; Digits : Integer =0) : String;
//Переведёт Integer to String в 16ричном формате
//Если длина результата меньше Digits, дополнит нулями слева
function StrSatisfy( const S, Mask: String ): Boolean;
{* Returns True, if S is satisfying to a given Mask (which can contain
   wildcard symbols '*' and '?' interpeted correspondently as 'any
   set of characters' and 'single any character'. If there are no
   such wildcard symbols in a Mask, result is True only if S is maching
   to Mask string.) }


(*INC_CRTL\I_MidEx.Pin*)
Function Replace(Var Expr:String;SearchSubStr,ReplaceSubStr:String;ProgressProc:TProgressProc=nil):Integer;
//Вернёт число замен SearchSubStr на ReplaceSubStr, сделанных в Expr.
Function Modify(Expr,SearchSubStr,ReplaceSubStr:String;ProgressProc:TProgressProc=nil):String;
//Вернёт строку-результат замены SearchSubStr на ReplaceSubStr в Expr.
function Modify2(const S, SearchSubStr,ReplaceSubStr:String;IgnoreCase:Boolean=False;ReplaceAll:Boolean=True): string;
//По мотивам Борландовского реплейса
Function FindPair(Expr:String;Bra:String;Cket:String;CursorPos:Integer;casesens:Boolean=True):String;
//Вернёт строку, содержащую блок между скобками Bra и Cket с учётом
//вложенных вхождений пар скобок. Аналогична функции Colorer by Cail Lomecb
//"Выделить блок со скобками" + CtrlIns
Function FindFirstInnerBracket(Expr,Bra,Cket:String):String;
//Вернёт первую внутреннюю (самую вложенную) скобку выражения СО СКОБКАМИ
Function EOLtoCRLF(Expr:String):String;
//Вернёт строку с корректными EOL (CR,LF,LFCR->CRLF)
Function GetParamValue(Expr,ParamName:String;EqMark:String='=';Start:Integer=1;Delimiter:String=' '):String;
//Вернёт слово, стоящее за ParamName+EqMark до Delimiter (не включая Delimiter)
Function MidEx(S:String;Start,V_Lenght:Integer;ExMode:Integer;S_Start:String='';S_End:String=''):String;
//Расширенный вариант функции Mid.
//MidEx возвращает подстроку строки S, границы подстроки могут
//задаваться как номерами соответствующих символов (как Mid, быть чёткими),
//так и началом (концом) вхождения в строку подстрок (размываться).
//При размытии той или иной границы используются параметры S_Start и S_End
//для начала и конца области соответственно.
//Способ построения результирующей строки определяется параметром ExMode.
//Битовые поля ExMode:
//
//MIDEX_DIFF_START(0):
//       поиск вхождения вблизи точки начала результирующей строки (Start):
//          0-оставить чёткое начало результирующей строки в точке Start
//          1-сориентировать начало результирующей строки по вхождению
//            первой подстроки - размыть нижнюю границу
//
//MIDEX_INCREASE_START(1):
//       способ поиска вхождения вблизи точки Start:
//          0-искать вперёд (уменьшить длину)
//          1-искать назад  (увеличить длину)
//
//MIDEX_DEL_STARTSUBST(3):
//       уточнение нижней границы результирующей строки:
//          0-по началу вхождения (с первой подстрокой)
//          1-по концу вхождения  (без таковой)
//
//MIDEX_DIFF_END(4):
//       поиск вхождения вблизи окончания результирующей строки:
//          0-оставить чёткий конец результирующей строки
//          1-сориентировать конец результирующей строки по вхождению
//            первой подстроки - размыть верхнюю границу
//
//MIDEX_INCREASE_END(5):
//       способ поиска вхождения вблизи окончания результирующей строки:
//          0-искать назад  (уменьшить длину)
//          1-искать вперёд (увеличить длину)
//
//MIDEX_DEL_ENDSUBST(6):
//       уточнение верхней границы результирующей строки:
//          0-по концу вхождения  (включая её)
//          1-по началу вхождения (без второй подстроки)
//
//MIDEX_LENGTH_AS_NUMBER(7):
//       значение параметра V_Lenght:
//          0-длина результирующей строки (как для Mid)
//          1-номер последнего символа результирующей строки (как для SubStr)
//
//MIDEX_EMPTY_IF_BORDERCROSS(8):
//       поведение при отсутствии вхождения или при пересечении границ
//   (нижняя размывается выше верхней или наоборот):
//          0-присвоить ошибочной границе её начальное
//            (указанное в аргументе) значение
//          1-вернуть пустую строку
//   Пересечение границ происходит, если
//  - размытая нижняя граница не меньше указанной
//    верхней (Start+V_Lenght или V_Lenght)
//  - размытая верхняя граница не больше указанной нижней (Start)
//Т.об, даже в случае ненулевого интервала между размытыми границами
//("сильного размытия") происходит пересечение границ.
//
//MIDEX_IGNORE_NEGATIVE(9):
//       поведение в случае сильного отрицательного размытия
//   (границы сильно сдвинулись в начало):
//          0-зафиксировать пересечение границ
//            (установить исходное значение)
//          1-игнорировать пересечение границ
//
//MIDEX_IGNORE_POSITIVE(10):
//       поведение в случае сильного положительного размытия
//   (границы сильно сдвинулись в конец):
//          0-зафиксировать пересечение границ
//          1-игнорировать пересечение границ
//

//Декларация именованных констант:
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
// К сожаленью, нигде не ипользуется


Function TruncateString(Expr:String;NeedLength:Integer;TruncType:Byte=0):String;
//Вернёт строку - результат усечения Expr до длины NeedLength.
//+-------------+------------------+----------------------------------------------+
//¦ Соотношение ¦Trunc             ¦ Возвращаемое значение                        ¦
//¦   длин      ¦Type              ¦                                              ¦
//+-------------+------------------+----------------------------------------------+
//¦Length(Expr) ¦TSTT_TRUNC_START  ¦ Первые NeedLength символов Expr              ¦
//¦>NeedLength  +------------------+----------------------------------------------+
//¦             ¦TSTT_TRUNC_END    ¦ Последние NeedLength символов Expr           ¦
//¦             +------------------+----------------------------------------------+
//¦             ¦TSTT_TRUNC_START3D¦ Первые NeedLength-3 символов Expr + '...'    ¦
//¦             +------------------+----------------------------------------------+
//¦             ¦TSTT_TRUNC_END3D  ¦ Последние NeedLength-3 символов Expr + '...' ¦
//¦             +------------------+----------------------------------------------+
//¦             ¦TSTT_TRUNC_MID3D  ¦ Центрированный вырез, между                  ¦
//¦             ¦                  ¦ первыми и последними символами - '...'       ¦
//¦             ¦                  ¦ В конечной и начальной частях букв либо      ¦
//¦             ¦                  ¦ поровну, либо в _конце_ больше на 1          ¦
//+-------------+------------------+----------------------------------------------+
//¦Length(Expr) ¦TSTT_TRUNC_START  ¦ Expr, дополненный пробелами                  ¦
//¦<=NeedLength ¦TSTT_TRUNC_START3D¦ с конца до длины NeedLength                  ¦
//¦             +                  +----------------------------------------------+
//¦             ¦TSTT_TRUNC_END    ¦ Expr, дополненный пробелами                  ¦
//¦             ¦TSTT_TRUNC_END3D  ¦ с начала до длины NeedLength                 ¦
//¦             +                  +----------------------------------------------+
//¦             ¦TSTT_TRUNC_MID3D  ¦ Expr, центрированный пробелами               ¦
//¦             ¦                  ¦ до длины NeedLength. Лишний пробел - в конец ¦
//+-------------+------------------+----------------------------------------------+
//В случае NeedLength<5 вернётся Expr

//Декларация именованных констант:
Const
TSTT_TRUNC_START   = 0;
TSTT_TRUNC_END     = 1;
TSTT_TRUNC_START3D = 2;
TSTT_TRUNC_END3D   = 3;
TSTT_TRUNC_MID     = 4;
TSTT_TRUNC_MID3D   = 4;

Function VerticalIndent(Expr:String;IndentCount:Byte):String;
//Сделает отступ от начала каждой строки Expr на IndentCount пробелов

(* INC_CRTL\I_Parse.PIN *)
Function Split(Expr:String;Delimiter:String;var Rslt:TStrArray;LoseDelimiter:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//Вернёт число вхождений Delimiter в Expr, что по совместительству
//меньше размера массива Rslt на 1, а собственно массив Rslt является
//результатом нарезки Expr по Delimiter'у.
//ВНИМАНИЕ!!! Delimiter относится к концу предыдущей строки!!!
//Если указать LoseDelimiter=True, то Delimiter "проглатывается"
//FE:после Split('123///456','//',s) S[0]='123//',S[1]='/456'
//Если Delimiter='', то S[0]=Expr
Function FastSplit(Expr:String;Delimiter:String;var Rslt:TStrArray;LoseDelimiter:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//Сильно ускоренная версия Split, особенно для больших Expr
Function SplitToEqParts(Expr:String;PartSize:Integer;var Rslt:TStrArray;ProgressProc:TProgressProc=nil):Integer;
//Разобьёт строку на одинаковые по количеству знаков части
Function KillSpaces(Expr:String):String;
//Убьёт всё похожее на пробел из строки (cr,lf,tab,#32)
Function SplitToWords(Expr:String;Var Wds:TStrArray;ProgressProc:TProgressProc=nil):Integer;
//Разрежет Expr на слова, причём разделители интерпретируются Tab, CR, LF, CRLF, Space
Function SplitToParagraphs(Expr:String;Var Paras:TStrArray;AllowEmptyParagraphs:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//Разрежет Expr на параграфы по CR, LF, LFCR и CRLF
//Если AllowEmptyParagraphs=false, пустые параграфы отсеятся.
Function SplitToDoubleParagraphs(Expr:String;Var Paras:TStrArray;AllowEmptyParagraphs:Boolean=False;ProgressProc:TProgressProc=nil):Integer;
//Разобьёт Expr на параграфы по критетию CRLF+CRLF
Function SplitByBrackets(Expr,Bra,Cket:String;Var Rslt:TStrArray;KillBrackets:Boolean=False;casesens:Boolean=true):Integer;
//Разрезает Expr на регионы со скобками типа Bra и Cket.
//Вся информация вне скобок теряется.
//Если KillBrackets=true, то потеряются и сами скобки
Function FindBracket(Expr,Bra,CKet:String;KillBrackets:Boolean=True;Start:Integer=0;casesens:Boolean=true):String;
//Вернёт вхождение между Bra и CKet, если KillBrackets, то без Bra,CKet, можно указать начало поиска.
Function GetWordByNo(Expr:String;WordNo:Integer;CountFromStart:Boolean=True):String;
//Вернёт слово с номером WordNo от начала, если CountFromStart, иначе от конца. Нумерация идёт с нуля.
//В случае отсутствия слова с данным номером вернёт пустую строку.
Function GetParagraphByNo(Expr:String;ParaNo:Integer;CountFromStart:Boolean=True):String;
//Вернёт абзац с номером ParaNo от начала, если CountFromStart, иначе от конца. Нумерация идёт с нуля.
//В случае отсутствия абзаца с данным номером вернёт пустую строку.
Function GetFirstWord(var Expr:String):String;
//Вернёт первое слово Expr, при этом первое слово отрезается от expr.
//Неадекватно ведёт себя с несколькими разными (типа #20#9) пробелами
Function GetFirstParagraph(var Expr:String):String;
//Вернёт первый параграф Expr, при этом отрезая его от expr.
Procedure VerticalSplit(Expr:String;var Part1,Part2:String;Splitpos:Integer);overload;
//Поместит в Part1 и Part2 столбцы Expr, разделяемые по Splitpos.
//Expr[Splitpos] - окончание первого столбца
Procedure VerticalSplit(Expr:String;var Part1,Part2:String;Delim:String;LoseDelimiter:Boolean=True);overload;
//Поместит в Part1 и Part2 столбцы Expr, разделяемые по Delim.
//Если LoseDelimiter=False, то Delim присоединится к Part1

function Trim(const S: string): string;
//из борланда. Есть ещё TruncateSpaces 

(* INC_CRTL\I_BitRoutines.PIN *)
Function IntToBit(Arg:Byte):String;overload;
Function IntToBit(Arg:Word):String;overload;
Function IntToBit(Arg:LongWord):String;overload;
//Вернут строку - двоичное представление аргумента
//Ввиду новых веяний необходимо указать, что старший бит идёт первым
Function IsBitsSet(Val,Bits:Cardinal):Boolean;
//Вернёт True, если в Val подняты биты Bits
Function SetBits(Val,Bits:Integer;ToSet:Boolean):Integer;overload;
Function SetBits(Val,Bits:Cardinal;ToSet:Boolean):Cardinal;overload;

Function SetBits(Val,Bits:Byte;ToSet:Boolean):Byte;overload;
//Вернёт Val с установленными битами Bits в ToSet

(* INC_CRTL\I_Arrays.PIN *)
Function Join(StAr:Array of String;Delimiter:String='';Start:Integer=0;Finish:Integer=-1):String;overload;
Function Join(StAr:Array of String;var Order:TIntArray;Delimiter:String=''):String;overload;
Function JoinI(const Arr:Array of int64;Delim:String=vbcrlf):String;overload;
//Соберёт контент массива StAr в строку через Delimiter.
//В начале и в конце Delimiter не !!добавляется!!
//Можно указать порядок сборки, однако в этом случае размер массива Order
//должен быть равен размеру StAr
//SLOW!!!

Function Filter(Source:Array of String; var Rslt:TStrArray;SubStr:String):Integer;OverLoad;
Function Filter(Source:Array of String; var Rslt,Unsatisfactions:TStrArray;SubStr:String):Integer;Overload;
//Сформирует Rslt из элементов Source, включающих в себя SubStr
//В Unsatisfactions будут элементы, не содержащие SubStr
//Вернёт High(Rslt)
Procedure KillEquals(Var IA:TIntArray);
//Убьёт одниаковые элементы из массива IA (SLOW!!!)
Procedure IntQSort(Var IA:TIntArray);overload;
Procedure IntQSort(Var IA:TIntArray;Var Indexes:TIntArray);overload;
//Сортирует массив IA алгоритмом QuickSort
//Также может вернуть массив Indexes, такой, что
//Indexes[NewStrPos]=OldStrPos
Procedure StrQSort(Var Wds:TStrArray);overload;
Procedure StrQSort(Var Wds:TStrArray;Var Indexes:TIntArray);overload;
//Сортирует массив строк Wds алгоритмом QuickSort
//Также может вернуть массив Indexes, такой, что
//Indexes[NewStrPos]=OldStrPos
Procedure Concatenate(Var Rslt:TStrArray;Src:Array of String);
//Добавит массив Src в конец массива Rslt
//SLOW!!!
Function IsElement(TstArr:TStrArray;Element:String):Integer;OverLoad;
Function IsElement(TstArr:TIntArray;Element:Int64):Integer;OverLoad;
Function IsElement(TstArr:Array of word;Element:Integer):Integer;OverLoad;
Function IsElement(TstArr:TByteArray;Element:Byte):Integer;OverLoad;
//Вернут индекс первого элта со значением Element, если таких нет, то -1
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
//Увеличат длину Arr на 1 и добавят NewElement в конец
Procedure AppendNElements(var Dest:TStrArray;Src:Array of String);overload;
Procedure AppendNElements(var Dest:TIntArray;Src:Array of Int64);overload;
//Добавит массив Src к массиву Dest, Src не изменяется


Procedure CharArrToByteArr(var Source:TChArray;var Dest:TByteArray);
//Скопирует Source в Dest, изменив Char на Byte
Procedure ByteArrToCharArr(var Source:TByteArray;var Dest:TChArray);
//Скопирует Source в Dest, изменив Byte на Char
Procedure Swp(var A,B:Integer);Overload;
Procedure Swp(var A,B:Int64);Overload;
Procedure Swp(var A,B:Byte);Overload;
Procedure Swp(var A,B:Word);Overload;
Procedure Swp(var A,B:Char);Overload;
Procedure Swp(var A,B:String);Overload;
Procedure Swp(var A,B:Cardinal);Overload;
Procedure Swp(var A,B:Boolean);Overload;
Procedure Swp(var A,B:Extended);Overload;
//Обмен содержимого переменных A и B
Function DelElement(var SA: TStrArray; Index: Integer):Boolean;overload;
Function DelElement(var SA: TIntArray; Index: Integer):Boolean;overload;
//Удалит строку с индексом Index из SA. Вернёт результат операции:
//если индекс недопустим, вернёт False.
//Небыстрая
Procedure FillRand(var IA:TIntArray;Count:Integer;Range:Integer=0;KeepData:Integer=0);
//Забьёт массив IA неповторяющимися рандомами от 0 до Range-1,
//длина IA составит Count. if Range<Count then Range:=Count
//Содержит вложенный цикл, производительность падает примерно как квадрат Count
//KeepData - число заранее заданных элементов. Ели выходит за допустимые границы - приравнивается к 0
procedure FillLinear(var IA:TIntArray;count:integer;start:Integer=0;finish:Integer=2147483647);
//Заполнит массив числами по порядку (0,1,2...count-1), при достижении finish-1 начинаем со start
Procedure Shuffle(VAR IA:TIntArray);
//Перемешка значений массива
Function RandomString(Len:Integer):String;
//Вернёт строку из случайных символов длиной Len



(* INC_CRTL\I_DateTime.PIN *)
Function FormatMoment(Moment:double;Fmt:String=''):String;
//Вернёт время в формате Fmt.
//    Формат аргумента Fmt функции FormatMoment
//Возвращаемое значение - строка, полученая из строки Fmt заменой:
//%YYYY% - на 4 цифры года (%YY в 1981 году вернёт 81)
//%M%    - на номер месяца
//%M0%   - на номер месяца с ведущим нулём
//%D%    - на номер дня
//%D0%   - на номер дня с ведущим нулём
//%H%    - на номер часа
//%H0%   - на номер часа с ведущим нулём
//%H12%  - на номер часа в двенадцатичасовом формате
//%H012% - на номер часа в двенадцатичасовом формате с ведущим нулём
//%AP!amstr!?pmstr?% - на amstr если до полудня и pmstr если после
//%I%    - на номер минуты
//%I0%   - на номер минуты с ведущим нулём
//%S%    - на номер секунды
//%S0%   - на номер секунды с ведущим нулём
//%E%    - на 1..3 цифры  милисекунды
//%E0%   - на 3 цифры  милисекунды с ведущим нулём
//%E1%   - на десятые доли секунды (1 символ)
//%E2%	 - на сотые доли секунды (2 символа)
//%DC%   - на число дней в дате, фактически на результат округления Moment
//Регистр значения не имеет
//При использовании увеличат размер exe на ~10Kb
//Если параметр Fmt опущен, то рассматривается формат даты 
//вида '%YY%%M0%%D0%%H0%%I0%%S0%'
function GTCFormatMoment(Moment:cardinal;Fmt:String=''):String;
//вернёт FormatMoment для целого числа милисекунд
Function Now: Double;
//Вернёт текущий момент в формате TDateTime
Function UTC:Double;
//Вернёт текущий момент в формате TDateTime по гринвичу
Function ToUTC(date:double):Double;
Function FromUTC(date:double):Double;
//Преобразование в\из UTC

Function Date:Double;overload;
Function Date(DT:Double):Double;overload;
//Вернёт текущую дату, или дату DT (0:00:00.000)
Function Time:Double;overload;
Function Time(DT:Double):Double;overload;
//Вернёт текущее время, или время DT (30.12.1899)
Function Day(Data:Double):Byte;
//Вернёт число (месяца) для момента Data в формате TDateTime
Function Month(Data:Double):Byte;
//Вернёт номер месяца для момента Data в формате TDateTime. Январь - 1
Function Year(Data:Double):Word;
//Вернёт номер года для момента Data в формате TDateTime. 
Function DOW(Data:Double):Byte;
//Вернёт номер дня недели для момента Data в формате TDateTime. Вс - 0, Пн - 1, ... Сб - 6
Function Hour(DT:Double):Byte;
Function Minute(DT:Double):Byte;
Function Second(DT:Double):Byte;
Function BuildDate(_Year,_Month,_Day:Word):Double;
//Вернёт дату в в формате TDateTime
Function UnixDateTime(D:Double):Int64;
//вернёт <unixtime> - время в секундах с 1 января 1970 г.
  { TODO : Implement DateUtils }
Function FirstDayOfMonth(data:Double):Double;
//Вернёт первый день месяца

(* INC_CRTL\I_Formats.PIN *)
Function FormatExpr(Const Template,Arg:String;LeaveDoublePersentAsIs:Boolean=False):String;overload;
Function FormatExpr(Const Template:String;Arg:Array of String;LeaveDoublePersentAsIs:Boolean=False):String;overload;
//Вернут результат замены подстроки '%i' строки Template строку Arg, i=[0...2^31)
//Если LeaveDoublePersentAsIs = False, то подстрока '%%' вернётся как '%',
//иначе как '%%'
//Function Int2Str(i:integer;MinDigitsCount:integer=0):String;overload;
Function Int2Str(i:Int64;MinDigitsCount:integer=0):String;overload;
//Переведёт _положительное_ Integer to String
//Если длина результата меньше MinDigitsCount, дополнит нулями слева
Function Int2StrEx(i:int64;MinDigitsCount:integer=0;DigitsInGroup:Integer=0;GroupDelim:String=' '):String;
//Помимо стандартного функционала ещё умеет разбивать на группы:
//количество цифр в группе =DigitsInGroup, если 0 - не разбивает,
//разделитель=GroupDelim, если '' - не разбивает
Function Str2Int(S:String;DefVal:Integer=0):Int64;overload;
//Function Str2Int64(S:String;DefVal:Int64=0):Int64;
//Если S - строковое представление числа, вернут число, иначе - DefVal,
//причём поймёт как десятичное, так и хексуальное представление числа
//Десятичное воспринимается просто так, у hex должен стоять "$" в начале.
Function IsDecimal(S:String):Boolean;
//Вернёт True, если S - строковое представление десятичного числа
Function IsNumeric(S:String):Boolean;
//Вернёт True, если S - строковое представление числа
Function Bool2Int(B:Boolean):Integer;
//Если B=True, вернёт 1, иначе - 0
Function Bool2Str(B:Boolean):String;
//True\False


(* INC_CRTL\I_Stacks.pin *)
Function TriggerInt(Command:Integer;Value:Integer=0):Integer;
Function TriggerStr(Command:Integer;Value:String=''):String;
Function TriggerBool(Command:Integer;Value:Boolean=False):Boolean;
//Аналог триггеров - запоминающих устройств. Держат засунутую величину
//в течение всей программы. Инициализация происходит во время первого
//вызова TriggerXXX.
//Уникальны для каждого потока - treadvar
//	Правила работы с квазитриггерами:
//|-------------------------------------------------------|
//|Значение |     Действие            | Возвращаемое      |
//|Command  |                         | значение          |
//|         |                         |                   |
//|-------------------------------------------------------|
//|0        |  Установить состояние   | Предыдущее        |
//|TRIG_SET | триггера равным Value.  |состояние          |
//|-------------------------------------------------------|
//|1        | Запрос состояния        | Текущее           |
//|TRIG_GET |триггера                 |состояние          |
//|-------------------------------------------------------|
//|Иначе -  | Запрос состояния.       | Текущее состояние |
//--------------------------------------------------------|
//Численный триггер инициализирован нулём
//Строковый триггер инициализирован пустой строкой
//Логический триггер инициализирован False

//Декларация именованных констант
Const
TRIG_SET            = 0;
TRIG_GET            = 1;

Function FILOInt(Command:Integer;Value:Integer=0):Integer;
Function FILOStr(Command:Integer;Value:String=''):String;
Function FIFOInt(Command:Integer;Value:Integer=0):Integer;
Function FIFOStr(Command:Integer;Value:String=''):String;
//Квазистеки (виртуальные стеки).
//Для каждого потока получается свой стек ввиду работы компилятора с опцией J+
//Квазистеки бывают типа FILO (стек) и типа FIFO (очередь).
//FILO (first in - last out)  - значение, загнанное последним, выйдет первым
//FIFO (first in - first out) - значение, загнанное первым, выйдет первым
//
//    Правила работы с квазистеками
//+------------+-------------------+---------+
//¦ команда    ¦   действие        ¦ возврат ¦
//+------------+-------------------+---------+
//¦0           ¦Записать новое     ¦0 или '' ¦
//¦STACK_PUSH  ¦значение (Push)    ¦         ¦
//¦            ¦из Value           ¦         ¦
//+------------+-----------------------------+
//¦1           ¦Извлечь следующее  ¦Значение ¦
//¦STACK_POP   ¦значение (Pop)     ¦         ¦
//+------------+-----------------------------+
//¦2           ¦Прочитать следующее¦Значение ¦
//¦STACK_PEEK  ¦значение (Peek)    ¦         ¦
//+------------+-----------------------------+
//¦3           ¦Записать количество¦0 или '' ¦
//¦STASK_DEPTH ¦значений в         ¦         ¦
//¦            ¦TriggerInteger     ¦         ¦
//+------------+-----------------------------+
//¦4 STACK_ZERO¦Очистить квазистек ¦0 или '' ¦
//+------------+-----------------------------+
//¦Иначе       ¦Ничего не делаем   ¦0 или '' ¦
//+------------+-----------------------------+
// Глубина пустого стека равна STACK_EMPTY, при трёх элтах в стеке глубина = 2

//Декларация именованных констант
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
//Глобальный счётчик. Инитится значением ResetTo при первом обращении, при
//дальнейших обращениях увеличивается на Increment. Так до достижения предела
//Limit, далее сбрасывается на ResetTo.
//Для изменения параметров счётчика необходимо передать Modify равное True
Function GC(Number:Byte;Modify:Boolean=False;Increment:Integer=1;Reset:
	    Boolean=False;ResetTo:Integer=0;Limit:Integer=$0FFFFFFF):Integer;
//Пять глобальных счётчиков. Нумерация от 0 до 4. Работают так же, для доступа к
//нужному надо указать номер в поле number. При некорректном number просто
//вызовет globalcounter
Function RegCounter(ord,min,max:Integer;Increment:Integer=1):Integer;
//Вернёт номер из реестра,
//ord - порядковый номер счётчика
//min - минимальное значение
//max - максимальное
//Increment - инкремент
Function GTC(Push:Boolean):Cardinal;
//Запомнит гтц, если Push, иначе вернёт разницу между запомненым и нынешним моментом


(*INC_CRTL\I_SnapWindows.pin*)
Function SnapTopWindows(var HA:TIntArray):Integer;
//Вернёт число окон верхнего уровня, массив HA заполнится их хэндлами
Function SnapAllChildWindows(HParent:Integer;var HA:TIntArray):Integer;
//Вернёт число дочерних окон для HParent, массив HA заполнится их хэндлами

(* INC_CRTL\I_WndWrap.pin *)
Function GetWndClassName(hWnd:Integer):String;
//Вернёт имя класса окна с дескриптором hWnd
Function GetWndCaption(hWnd:Integer):String;
//Вернёт заголовок окна с дескриптором hWnd
Procedure SetWndCaption(HWnd:Integer;S:String);
//Установит заголовок окна с дескриптором hWnd в значение S
Function GetWndInfo(hWnd:Integer):Byte;
//Вернёт информацию о состянии окна с дескриптором hWnd
//Формат возвращаемого значения:
//Первые 2 бита: (0й и 1й)
//       00-свёрнуто,
//       01-нормально,
//       10-развёрнуто;
//2-й бит:
//        видимо/невидимо;                  (1/0)
//3-й бит:
//        доступно/недоступно;              (1/0)
//4-й бит:
//        поверх всех/не поверх всех        (1/0)
//10110

Function SetWndInfo(hWnd:Integer;Info:Byte):Boolean;
//Установит состяние окна с дескриптором hWnd в формате GetWndInfo
Function IsWndTopMost(hWnd:Integer):Boolean;
//Если окно с дескриптором hWnd имеет атрибут "Поверх всех", вернёт True
Procedure SetWndTopMost(HWnd:Integer;bTopMost:Boolean);
//Если bTopMost=True, установит окну с дескриптором hWnd атрибут
//"Поверх всех", иначе снимет его.
Function GetWndPos(hWnd:Integer):TRect;
//Вернёт координаты окна
Procedure ShowWnd(hWnd:Integer;bVisible:Boolean);
//Покажет\спрячет окно
Function WaitForWndEx(Caption,ClsName:PChar;ProgressProc:TProgressProc):Integer;
//Вернёт дескриптор окна (если оно есть) или ноль (если нет) и будет
//крутиться в бесконечном цикле, вызывая ProgressProc.
//В качестве параметров функции ProgressProc передаются:
// - OpDone     - если окно есть, то 1, иначе 0
// - OpCount    - всегда 1
// - FuncID     - UCRTL_ID_WAIT4WND
//Рекомендуется использовать Wait4Wnd и Wait4WndDie
Function Wait4Wnd(Caption:String;ClsName:String='';ProgressProc:TProgressProc=nil):Integer;
//Вернёт дескриптор окна с заголовком Caption и классом ClsName (можно не
//указывать), если оно есть. Если его нет, то будем дожидаться его появления
//в бесконечном цикле.
//В качестве параметров функции ProgressProc передаются:
// - OpDone     - всегда 0
// - OpCount    - всегда 1
// - FuncID     - UCRTL_ID_WAIT4WND
Procedure Wait4WndDie(Caption:String;ClsName:String='';ProgressProc:TProgressProc=nil);
//Дождётся закрытия окна с заголовком Caption и классом ClsName (можно не
//указывать). Пока оно присутствует, будем крутиться в ебсконечном цикле.
//В качестве параметров функции ProgressProc передаются:
// - OpDone     - всегда 1
// - OpCount    - всегда 1
// - FuncID     - UCRTL_ID_WAIT4WND

(* INC_CRTL\I_Msgbox.pin *)
Function MsgBox(Prompt:String;Title:String='';Style:Integer=vbInformation):Integer;OverLoad;
Function MsgBox(Prompt:Integer;Title:String='';Style:Integer=vbInformation):Integer;OverLoad;
Function MsgBox(Prompt:Integer;Title:Integer;Style:Integer=vbInformation):Integer;overload;
Function MsgBox(Prompt:String;Title:Integer;Style:Integer=vbInformation):Integer;overload;
Function MsgBox(Prompt:Boolean;Title:String='';Style:Integer=vbInformation):Integer;overload;
//Свёртка функции MessageBox
Procedure UC;
//Выводит сообщение "Under construction"
Procedure GLE;
//Выводит результат GetLastError в MSGBOX
Function GLEStr:String;overload;
//Свёртка SysErrorMessage
Function GLEStr(ErrCode:Integer):String;overload;
//SysErrorMessage для кода ошибки
Function AnsiGLEStr(ErrCode:Integer):String;
//SysErrorMessage для кода ошибки в кодировке Windows
Function Confirm(Prompt:String;Title:String='';NoByDef:Boolean=False):Boolean;
//Msgbox подтверждения

//Function InBox(Prompt:String;Title:String='';PrevVal:String=''):String;
//Выдаст диалог для ввода строки
//!!NOTWORKPROPERLY!!

(*INC_CRTL\I_Kbrd.PIN*)
procedure SimulateKeyDown(Key:byte);
//Эмулирует нажатие клавиши
procedure SimulateKeyUp(Key:byte);
//Эмулирует отжатие клавиши
procedure SimulateKey(Key:byte);
//Эмулирует нажатие+отжатие клавиши
Procedure SendKeys(Seq:String);
//Передаёт последовательность нажатия клавиш Seq на обработчик клавиатурного
//ввода ОС MS Windows. Делает это в лоб, поэтому имеется ряд как преимуществ,
//так и ограничений.
//Последовательность Seq представляет из себя строку, синтаксис которой
//похож на синтаксис фаровских макрокоманд и имеет вид:
//   - Последовательность регистронезависима!
//   - Клавиша с ошибками игнорируется, т.е. ПРОСТО_ПРОПУСКАЕТСЯ!!!
//     Последовательность продолжает выполняться!!!
//   - Строка состоит из слов, каждое из которых представляет из себя
//     название нажимаемой клавиши с префиксом или без. Префиксов бывает 4:
//        - Alt     &_
//        - Shift   %_
//        - Ctrl    ^_
//        - Win     $_
//     Это значит, что запись CtrlShiftO и %_^_O эквивалентны.
//     Префиксы могут следовать в произвольном порядке.
//     Названия клавиш:
//0	        Клавиша "0"
//1             Клавиша "1"
//2	        Клавиша "2"
//3	    	Клавиша "3"
//4	    	Клавиша "4"
//5	    	Клавиша "5"
//6	     	Клавиша "6"
//7	    	Клавиша "7"
//8	    	Клавиша "8"
//9	    	Клавиша "9"
//A	    	Клавиша "A"
//B	    	Клавиша "B"
//C	    	Клавиша "C"
//D	    	Клавиша "D"
//E	    	Клавиша "E"
//F	    	Клавиша "F"
//G	    	Клавиша "G"
//H	    	Клавиша "H"
//I	    	Клавиша "I"
//J	    	Клавиша "J"
//K	    	Клавиша "K"
//L	    	Клавиша "L"
//M	    	Клавиша "M"
//N	    	Клавиша "N"
//O	    	Клавиша "O"
//P	    	Клавиша "P"
//Q	    	Клавиша "Q"
//R	    	Клавиша "R"
//S	    	Клавиша "S"
//T	    	Клавиша "T"
//U	    	Клавиша "U"
//V	    	Клавиша "V"
//W	    	Клавиша "W"
//X	    	Клавиша "X"
//Y	    	Клавиша "Y"
//Z	    	Клавиша "Z"
//`	    	Клавиша "`", на ней тильда (~) и буква Ё
//=	    	Клавиша "=", с шифтом будет "+"
//-	    	Клавиша "-"
//\	    	Клавиша "\", на ней "|"
///	    	Клавиша "/", на ней "?"
//,	    	Клавиша ",", на ней "<"
//.	    	Клавиша "."  на ней ">"
//;             Точка с запятой
//'             Кавычка
//[             Скобка
//]             Скобка
//BS          	Клавиша "BACKSPACE"
//
//ESC	    	Клавиша "ESC"
//F1	    	Клавиша "F1"
//F2	    	Клавиша "F2"
//F3	    	Клавиша "F3"
//F4	    	Клавиша "F4"
//F5	    	Клавиша "F5"
//F6	    	Клавиша "F6"
//F7	    	Клавиша "F7"
//F8	    	Клавиша "F8"
//F9	    	Клавиша "F9"
//F10	    	Клавиша "F10"
//F11	    	Клавиша "F11"
//F12	    	Клавиша "F12"
//F13	    	Клавиша "F13"
//F14	    	Клавиша "F14"
//F15	    	Клавиша "F15"
//F16	    	Клавиша "F16"
//F17	    	Клавиша "F17"
//F18	    	Клавиша "F18"
//F19	    	Клавиша "F19"
//F20	    	Клавиша "F20"
//F21	    	Клавиша "F21"
//F22	    	Клавиша "F22"
//F23	    	Клавиша "F23"
//F24	    	Клавиша "F24"
//SPACE	    	Клавиша "SPACE"
//
//TAB	    	Клавиша "TAB"
//CAPS	    	Клавиша "CAPS LOCK"
//APPS	    	Клавиша "APPS"
//PRNSCR   	Клавиша "PRINTSCREEN"
//SCRLOCK   	Клавиша "SCROLL LOCK"
//NUMLOCK   	Клавиша "NUMLOCK"
//BREAK	    	Клавиша "BREAK"
//
//INS	    	Клавиша "INS"
//HOME	    	Клавиша "HOME"
//PGUP	    	Клавиша "PAGE UP"
//DEL	    	Клавиша "DEL"
//END	    	Клавиша "END"
//PGDN	    	Клавиша "PAGE DOWN"
//LEFT	    	Клавиша "LEFT" , стрелка влево
//UP	    	Клавиша "UP"   , стрелка вверх
//RIGHT	    	Клавиша "RIGHT", стрелка вправо
//DOWN	    	Клавиша "DOWN" , стрелка вниз
//
//NP0	    	Клавиша "NUMPAD 0"
//NP1	    	Клавиша "NUMPAD1"
//NP2	    	Клавиша "NUMPAD2"
//NP3	    	Клавиша "NUMPAD3"
//NP4	    	Клавиша "NUMPAD4"
//NP5	    	Клавиша "NUMPAD5"
//NP6	    	Клавиша "NUMPAD6"
//NP7	    	Клавиша "NUMPAD7"
//NP8	    	Клавиша "NUMPAD8"
//NP9	    	Клавиша "NUMPAD9"
//NP.	    	Клавиша "NUMPAD"
//NP/	    	Клавиша "NUMPAD"
//NP*	    	Клавиша "NUMPAD"
//NP-	    	Клавиша "NUMPAD"
//NP+	    	Клавиша "NUMPAD"
//
//!XX	    	Возможность послать код клавиши напрямую.
//	    	После восклицательного знака должен идти ШЕСТНАДЦАТИРИЧНЫЙ
//	    	код клавиши. Префиксы допускаются.
// 		Коды клавиш из Win32.hlp:
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
//Эмулирует движение мышью на (0,0)

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
//Принадлежит ли val интервалу min..max? Интервал закрытый, если ClosedBounds=True

(* INC_CRTL\I_Math.PIN *)
Function Char2Byte(Ch:Char):Byte;
//Переведёт цифровой (0..F) символ в число. При ошибке вернёт 32
Procedure AdjustNumDelims(var Expr:String);
//Исправит знак разделения целой части числа Num и мантиссы на стандартный
Function MinNumeration(Expr:String):Byte;
//Проанализирует строку на предмет её принадлежности к системам
//счисления (СС) и вернёт минимальную (для 711 вернёт NUM_OCT)
//Примечательно, что 16-ная система счисления регистрозависима и
//к ней не будут отнесены строки, в которых буквы (ABCDEF)
//встречаются в нижнем регистре
Function IsBelong2Num(Expr:String;Numeration:Byte):Boolean;
//Вернёт True, если Expr можно интерпретировать как число в указанной СС
Function TruncateZeros(Expr:String):String;
//Прибьёт все нули слева до первой значащей цифры.
//Если прибьётся всё или останется только мантисса, добавит один 0
//Уберёт разделитель при отсутствии дробной части.
Function Num2Num(Expr:String;PrevNum,NeedNum:Byte):String;
//Переведёт Expr (если конечно он допустимый) из СС PrevNum в СС NeedNum
Function Operation(OP1,OP2:String;Num1,Num2,OPKind:Byte):String;
//Произведёт арифметическую операцию над OP1,OP2 в СС Num1,Num2 типа
//OPKind. См. константы OP_
//В случае ошибки вернёт EMPTYSTRING ('');
Function Compare(OP1,OP2:String):Integer;
//Если OP1<OP2, вернёт CMP_SECONDMORE
//Если OP1=OP2, вернёт CMP_EQ
//Если OP1>OP2, вернёт CMP_FIRSTMORE
//OP1,OP2 должны быть в одной СС!
Function ChangeSign(Expr:String):String;
//Поменяет знак у Expr. Ничего кроме первого символа не проверяется.

function ParseBracketBlock(bracket:String):String;
//Разберёт содержимое - набор условий вида
// ((colName1 [=,!]= value1) [&&,||] ...()... [&&,||] (colNamex [=,!]= valuex)),
// где colNameх - имя столбца (0ая строка грида, оттуда и будет браться значение),
//     valueх - значение строки грида (на самом деле будет браться из виджета), сопоставленной этому столбцу.
//При обработке работают правила:
// Операторы сравнения: == - равно, != - не равно
// Значения в скобках - НЕ регистрозависимы, для valuex понимаются маски * и ?
//  ( * - любое число любых символов, ? - любой символ, в том числе и отсутствующий, в colnamex маски быть не должно)
// Если скобок больше 1, а между ними стоят знаки [&&,||], то к результатам скобок применяются операции ["and","or"] соответственно.
// Вычисление и применение параметров происходит слева направо (как мы читаем) сначала в меньших скобках, затем в больших
// Вся информация вне скобок за исключением первого символа считается мусором и не воспринимается


procedure Factorize(i:Int64;var da:TIntArray);
//Разложит число i на множители, вернёт множители в массиве da
//Работает относительно быстро, перебор идёт не по простым числам,
//зато до корня
Procedure GetAllDivisors(i:int64;var ria:TIntArray);
//Заполнит массив ria всеми возможными делителями числа i, включая i и 1


function sum(ia:Array of Int64):Int64;
//Сумма массива
Function avg(ia:Array of Int64):Double;
//Среднее массива (без переполнения)
Function Product(ia:Array of Int64):Int64;
//Произведение элементов


(*INC_CRTL\I_MiscAPI.PIN*)
function IsNT : bool;
//Если запущено под NT вернёт TRUE
Procedure Delay(ms:cardinal;ProgressProc:TProgressProc=nil);
//Установит задержку на ms миллисекунд
//При этом жрёт процессор в ужасе, зато вызывает каждый раз ProgressProc
Procedure SetAutoRunInfo(ToSet:Boolean;Name:String='';ToLM:Boolean=False);
//Поставит/удалит запуск программы в/из автозагрузку/и
//ToSet: True - поставить, False - удалить
//Name: имя параметра автозагрузки
//ToLM: True - записаться в HKEY_LOCAL_MACHINE, False - в HKEY_CURRENT_USER
Function IIF(condition:Boolean;iftrue:String;iffalse:String):String;overload;
Function IIF(condition:Boolean;iftrue:Integer;iffalse:Integer):integer;overload;
Function IIF(condition:Boolean;iftrue:Double;iffalse:Double):Double;overload;
//Inline if
procedure nop;
//Ничего не делает
Function GetResource(resname:String;ressect:PAnsiChar=RT_RCDATA):String;
//Вернёт строку - содержимое ресурса resname из секции ressect если он есть, или пустую строку
Function NTreboot(EWXuFlags:Cardinal):Boolean;
//Перезагрузка\выключение под NT. Если False - GetLastError ?
Function String42Integer(S:String):Integer;
Function Integer2String4(j:Integer):String;
//Преобразование целого в строку из 4х байт и обратно
Function String82Int64(S:String):Int64;
Function Int642String8(j:Int64):String;
//Преобразование целого в строку из 8 байт и обратно


(* INC_CRTL\I_FileRoutines.PIN *)
Function IsWildCardInPath(Path:String):Boolean;
//Если выражение содержит '*' or '?', то вернёт True
Function FileExists(Path:String):Boolean;
//Вернёт True, если файл существует.
//В отличии от SysUtilёвой верно интерпретирует wildcardы
//Без разницы наличие завершающего слеша
Function FolderExists(Path:String):Boolean;
//Вернёт True, если папка существует.
//Без разници наличие завершающего слеша
Function mkdir(Path:String):Boolean;
//Создаст директорию. Если что-то не так, вернёт False
Function SMkDir(path:String):Integer;
//Рекуррентное создание директорий. В случае ошибки вернёт код getlasterror
Function Del(Path:String):Boolean;
//Убьёт файл, если не убьёт - вернёт False
Function CopyMove(Src,Dest:String;Move:Boolean;OverWrite:Boolean=True):Boolean;
//Скопирует файл Src в Dest, если Move=True, убьёт Src. Перезапишет существующий, если OverWrite=True
Function FileToString(FileName:String;FillNullChars:Char=#0):String;
//Вернёт строку, отражющую содержимое файла, Chr(0):=Chr(32) by default
Function StringToFile(S:String;FileName:String;Overwrite:Boolean=False;ConfirmIfExists:Boolean=False):Boolean;
//Запишет строку в файл.
//Параметры Overwrite и ConfirmIfExists управляют поведением в случае
//существования файла FileName. Если существует и ConfirmIfExists=True, то
//появится messagebox с вопросом о перезаписи, причём если Overwrite=False,
//то по дефолтная кнопка messageboxа будет "НЕТ", если оба параметра True -
//то кнопка "ДА"
//В случае записи вернёт True
Procedure StrArrayToFile(Var SA:TStrArray;FileName:String;Delimiter:String='';Overwrite:Boolean=False;ConfirmIfExists:Boolean=False);
//Запишет массив строк в файл через Delimiter
Function IsFileName(TestFN:String):Boolean;
//Проверит TestFN на наличие недопустимых символов (*,?,|,/,<,> и : более 2 раз)
Function ProcessPath(Path:String;ProcessType:Byte):String;
//Вернёт результат операции с путями.
//Тип операции задаётся параметром ProcessType.
//Возможные значения параметра ProcessType:
//0: PPPT_LEAVEASIS
//    Не изменит ничего (операция с последним слэшем)
//1: PPPT_FILENAME_FILEEXT
//    Возвращает имя файла с расширениями (без пути)
//2: PPPT_FILENAME
//    Возвращает имя файла без расширения (без пути).
//     Если много расширений - уберёт все
//3: PPPT_FILEEXT
//    Возвращает последнее расширение файла без точки
//4: PPPT_PARENTDIR
//    Возвращает имя папки, в которой находится файл
//5: PPPT_DELALLEXT
//    Вернёт полное имя файла без расширения
//    убив ВСЕ расширения
//6: PPPT_DELLASTEXT
//    Вернёт полное имя файла без последнего расширения
//7: PPPT_DELFIRSTFOLDER
//    Уберёт первую папку - включая \
//32: PPPT_FORCEBACKSLASH (битовая маска)
//    Этот бит регулирует наличие обратного слэша
//      0: обязательно не будет
//      1: обязательно будет


//Декларация именованных констант
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
//Вернёт текущую директорию
Function SetCurDir(const Dir: string): Boolean;
//Установит текущую директорию, в случае ошибки вернёт False

Function TruncPath(Path:String;NeedLength:Integer;TruncType:Byte=0):String;
//Обрежет Path до длины NeedLength (или меньшей) в зависимости от TruncType:
//TpTT_CUTMID  : вместо центра "..."
//TpTT_CUTEND  : вместо конца  "..."
//TpTT_CUTSTART: вместо начала "..."
//Линия отреза идёт по '\'

//Декларация именованных констант
Const
TpTT_CUTMID  =  0;
TpTT_CUTEND  =  1;
TpTT_CUTSTART=  2;


Function BuildPath(FolderName,Name:String):String;
//Вернёт путь к файлу по его имени и имени папки без проблем со слэшами
Function BuildRemotePath(comp,path:String):String;
//Вернёт путь к удалённому файлу через шары *$
Function EnumFiles(Path:String; var Files:TStrArray;FullPath:Boolean=False;WildCard:String='*'):Integer;
//Вернёт число файлов в директории path, массив Files заполнится именами файлов
Function EnumFolders(Path:String; var Files:TStrArray;FullPath:Boolean=False):Integer;
//Вернёт число подпапок директории path, массив Files заполнится именами подпапок
Function BuildTree(RootFolder:String;var Files:TStrArray;FullPath:Boolean=False;IncludeFiles:Boolean=True;IncludeFolders:Boolean=False;WildCard:String='*'):Integer;
//Вернёт число файлов в директории RootFolder и всех её подпапках
//Если FullPath=True, то в Files будут абсолютные пути
//IncludeFiles и IncludeFolders определяют, включать ли в дерево файлы и папки соответственно.
//Папка включается сразу после файлов из неё, т.об. корневая папка включается последней

Procedure EnumDrives(var DrvLetters:TStrArray);
//Заполнит массив строк единичной длины буквами доступных дисков

function FileDate(fn:String):Double;
//Вернёт дату последнего изменения файла в формате TDateTime, если файл не существует - вернёт -1
function FileCreationTime(fn:String):Double;
//Вернёт дату создания файла в формате TDateTime, если файл не существует - вернёт -1

Function GetFileSize(fn:String):Int64;
//Вернёт размер файла в байтах

Function GetFolderSize(RootFolder:String):Int64;
//Вернёт размер содержимого каталога в байтах (ахэз с юникодными именами, переделаю потом)
function GetDiskSize(drive: String; var free_size, total_size: Int64): Boolean;
//Вернёт true в случае успеха GetDiskFreeSpaceEx, free_size - свободное место, total_size - занятое
Function GetDiskSizeFree(drive:String):Int64;
//Свёртка для GetDiskSize
Function GetDiskSizeAvail(drive:String):Int64;
//Свёртка для GetDiskSize


Function FileVersion(FileName: string):String;
//Вернёт версию файла из VersionInfo
function GethInstancePath: String;
//Вернёт путь вызывающего dll\exe
Function deltree(path:String):Boolean;
//Убьём папку с файлами и подпапками

function SpecialDir(Dir: Integer): String;
//Специальный каталог
CONST
 CSIDL_PERSONAL             = $0005; //C:\Мои документы
 CSIDL_APPDATA              = $001A; //C:\WINDOWS\Application Data
 CSIDL_LOCAL_APPDATA        = $001C; //C:\WINDOWS\Local Settings\Application Data
 CSIDL_INTERNET_CACHE       = $0020; //C:\WINDOWS\Temporary Internet Files
 CSIDL_COOKIES              = $0021; //C:\WINDOWS\Cookies
 CSIDL_HISTORY              = $0022; //C:\WINDOWS\History
 CSIDL_COMMON_APPDATA       = $0023; //C:\WINDOWS\All Users\Application Data
 CSIDL_WINDOWS              = $0024; //C:\WINDOWS
 CSIDL_SYSTEM               = $0025; //C:\WINDOWS\SYSTEM
 CSIDL_PROGRAM_FILES        = $0026; //C:\Program Files
 CSIDL_MYPICTURES           = $0027; //C:\Мои документы\Мои рисунки
 CSIDL_PROGRAM_FILES_COMMON = $002B; //C:\Program Files\Common Files
 CSIDL_DESKTOP              = $0000; //C:\WINDOWS\Рабочий стол
 CSIDL_PROGRAMS             = $0002; //C:\WINDOWS\Главное меню\Программы
 CSIDL_FAVORITES            = $0006; //C:\WINDOWS\Избранное
 CSIDL_STARTUP              = $0007; //C:\WINDOWS\Главное меню\Программы\Автозагрузка
 CSIDL_RECENT               = $0008; //C:\WINDOWS\Recent
 CSIDL_SENDTO               = $0009; //C:\WINDOWS\SendTo
 CSIDL_STARTMENU            = $000b; //C:\WINDOWS\Главное меню
 CSIDL_NETHOOD              = $0013; //C:\WINDOWS\NetHood
 CSIDL_FONTS                = $0014; //C:\WINDOWS\FONTS
 CSIDL_TEMPLATES            = $0015; //C:\WINDOWS\ShellNew
 CSIDL_COMMON_PROGRAMS      = $0017; //C:\WINDOWS\All Users\Главное меню\Программы
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
//Вернёт системный %temp%
Function GetVolumeSerial(vol:char):String;
//Вернёт серийник тома


(*INC_CRTL\I_Console.PIN*)
Procedure CWrite(S:String);
//Плохой аналог Write
Function CGotoXY(X,Y:Byte):Boolean;
//Установит позицию курсора консоли в (X,Y), в случае сбоя вернёт False.
Function CGetStdColor:Byte;
//Вернёт цвет вывода текста
Function CSetStdColor(Foreground,BackGround:Byte):Boolean;overload;
Function CSetStdColor(Color:Byte):Boolean;overload;
//Установит цвет вывода текста
Procedure CLS;
//Очистит консоль
Function CCurX:Byte;
Function CCurY:Byte;
//Вернут текущее положение X и Y соответственно
Function CMaxX:Byte;
Function CMaxY:Byte;
//Вернут наибольшеевозможное значение X и Y соответственно
//в данном состоянии консоли
Procedure CCWrite(Expr:String);
Procedure CCWriteln(Expr:String);
//Выводит цветную строку.
//Для определения цвета последующих символов используется выражение вида ^FB,
//где F-код цвета символа в 16ричном формате (forecolor),
//B-код цвета поля символа в 16ричном формате (backccolor).
//Для вывода символа "^" ($5E) следует указывать сигнатуру ^^ в Expr
//После вывода установит цвет в первоначальное состояние
procedure CCReadKey;
//Ждёт нажатия любой клавиши
Procedure CSetTitle(S:String);
//Изменит заголовок консоли на S
Function CGetTitle:String;
//Вернёт заголовок консоли
Function DnetProgress(curr:integer;prev:integer=0):String;
//Вернёт индикатор прогресса как в клиенте distributed.net от числа процентов
//curr, если prev <> 0 - только изменившуюся часть этого прогресса



(* INC_CRTL\I_ByteFileRoutines.PIN *)
Function FileToByteArray(FileName:String;var BA:TByteArray):Integer;
//Вернёт размер битового файла, записав в BA его содержимое
Function FileToChArray(FileName:String;var BA:TChArray):Integer;
//Вернёт размер битового файла, записав в BA его содержимое
Procedure ByteArrayToFile(var BA:TByteArray;FileName:String;Overwrite:Boolean=False;ConfirmIfExists:Boolean=False);
//Запишет массив байт BA в файл.
//Параметры Overwrite и ConfirmIfExists управляют поведением в случае
//существования файла FileName. Если существует и ConfirmIfExists=True, то
//появится messagebox с вопросом о перезаписи, причём если Overwrite=False,
//то по дефолтная кнопка messageboxа будет "НЕТ", если оба параметра True -
//то кнопка "ДА"
Procedure StringToByteArray(S:String;Var BA:TByteArray);
//Скопирует содержимое строки S в массив байт BA

Function ByteArrayToStr(var BA:TByteArray;FillNullChars:Char=#32;ProgressProc:TProgressProc=nil):String;
//Вернёт строку, составленную из BA, заменив $00 на FillNullChars.
//Если в BA встречается $00, то в результат будет подставлен
//символ FillNullChars
Procedure XORByteArray(Var BA:TByteArray;Key:Byte);overload;
Procedure XORByteArray(Var BA:TByteArray;Key:String);overload;
//Зашифрует BA с ключём Key
Procedure UnXORByteArray(Var BA:TByteArray;Key:Byte);overload;
Procedure UnXORByteArray(Var BA:TByteArray;Key:String);overload;
//Расшифрует BA с ключём Key
Procedure StatBA(var BA:TByteArray;var StatArr:TIntArray);
//Заполнит StatArr(установив его размерность =[0..255])
//количеством соответствующих байт в BA
Function Bin2Hex(Bin:String;Delim:String=#$20;ShiftEnd:Boolean=False):String;
//Вернёт перевод бинарной строки Bin (допустимы только 0 и 1) в 16ричный вид через разделитель delim
//Если вдруг содержатся не единицы, они интерпретируются как нули!! Даже CrLf и Space!!
//Строка дополняется нулями до длины кратной 8.
//Если ShiftEnd=True, то строка будет дополнена нулями с конца, иначе с начала.


(*INC_CRTL\I_HexStrRoutines.PIN  *)
Function IsStrHexStr(HexStr:String):Boolean;
Function IsStrIntStr(IntStr:String):Boolean;
Function IsStrOctStr(OctStr:String):Boolean;
Function IsStrBinStr(BinStr:String):Boolean;
//Если в строке все символы принадлежат множеству цифр данной системы без учёта
//регистров и различных пробелов, то вернёт True

Function CorrectHexStr(Var HexStr:String):Byte;
//Ответит на вопрос, корректна ли HexStr. Если корректна, вернёт CHS_CORRECT
//и приведёт HexStr к виду StringToHexString.
//Если строка некорректна, оставит её без изменений и вернёт код ошибки:
//CHS_EMPTY_EXPR - строка не содержит символов для декодирования
//CHS_EVEN_QUANTITY - нечётное число значащих символов в строке
//CHS_IRREGULAR_SYM - в строке найден недопустимый символ

//Декларация именованных констант
Const
CHS_CORRECT		=0;
CHS_EMPTY_EXPR		=1;
CHS_EVEN_QUANTITY	=2;
CHS_IRREGULAR_SYM       =3;

Function ByteArrayToHexStr(var BA:TByteArray;BytesInString:Integer=8;ProgressProc:TProgressProc=nil;PerByteDelim:String=' '):String;
//Вернёт строку, отображающюю содержимое BA следующим образом:
//в каждой строке BytesInString байт в 16ричном представлении через пробел.
//В конце строки пробела нет.
//Например, если в файле написано 'ABCDEFGHIJ', то результат при
//BytesInString = 8 будет такой:
//41 42 43 44 45 46 47 48
//49 4A
Function HexStrToStr(HexExpr:String;FillNullChars:Char=#0;ProgressProc:TProgressProc=nil):String;
//Преобразует HexExpr в строку символов. Работает как ByteArrayToStr
//Например, на HexExpr '41 42 43 44 45 46 47 48 49 4A' вернёт 'ABCDEFGHIJ',
//а если в HexExpr встретится '00', то в результат будет подставлен
//символ FillNullChars
//Переработано!!
Function RealignHexStr(HexExpr:String;BytesInString:Integer=8;ProgressProc:TProgressProc=nil):String;
//Вернёт строку - выровненный HexExpr в соответствии с правилами:
//в каждой строке BytesInString байт в 16ричном представлении через пробел.
//В конце строки пробела нет.
Function HexStrToByteArray(HexExpr:String;var BA:TByteArray;ProgressProc:TProgressProc=nil):Boolean;
//Функция осуществляет преобразование строки в формате HexExpr в массив байт
//Фактически идёт преобразование, обратное действию функции ByteArrayToHexStr
//Если преобразование проведено успешно, вернёт True, иначе - False
Function StringToHexString(Const S:String; Delim:String=' '):String;
//Вернёт строку, содержащую коды символов строки S в формате HexExpr
//через delim и без разделения на параграфы



(* INC_CRTL\I_Settings.PIN *)
Function SetSetting(Path,Name,Value:String;LazyWrite:Boolean=True;RootKey:LongWord=HKEY_CURRENT_USER):Boolean;
//Запишет в ветку реестра Path строковый параметр Name со значением Value.
//При желании можно проделать сохранение значения на НЖМД, установив
//LazyWrite в False и сменить RootKey. В случае успеха вернёт True.
Function GetSetting(Path,Name:String;RootKey:LongWord=HKEY_CURRENT_USER):String;
//Вернёт значение переменной реестра Name в ветке Path куста RootKey. Если её нет, вернёт
//пустую строку.

(*I INC_CRTL\I_Registry.PIN*)
Function RegWriteString(RootKey:cardinal;Subkey,Name:String;Value:String;LazyWrite:Boolean=True):Boolean;
//Запишет в реестр строку. [RootKey\SubKey] "Name"="Value".
//При желании можно проделать сохранение значения на НЖМД, установив
//LazyWrite в False. В случае успеха вернёт True.
//В случае неуспеха вызвать GetLastError
Function RegWriteInteger(RootKey:cardinal; Subkey,Name:String; Value: Integer;LazyWrite:Boolean=True):Boolean;
//Запишет в реестр целое число. [RootKey\SubKey] "Name"=Value.
//При желании можно проделать сохранение значения на НЖМД, установив
//LazyWrite в False. В случае успеха вернёт True.
//В случае неуспеха вызвать GetLastError

Function RegDelValue(RootKey:cardinal; Subkey,name:String;LazyWrite:Boolean=True):Boolean;
//Удалит из реестра ключ (если он не содержит SubKeys)
//При желании можно проделать сохранение значения на НЖМД, установив
//LazyWrite в False. В случае успеха вернёт True.
//В случае неуспеха вызвать GetLastError
Function RegDelKey(RootKey:cardinal; Subkey:String;LazyWrite:Boolean=True):Boolean;
//Удалит из реестра параметр
//При желании можно проделать сохранение значения на НЖМД, установив
//LazyWrite в False. В случае успеха вернёт True.
//В случае неуспеха вызвать GetLastError


Function RegGetString(RootKey:cardinal;Subkey,Name:String;Default:String=''):String;
//Чтение строки из реестра. В случае ошибки вернёт Default
Function RegGetInteger(RootKey:cardinal;Subkey,Name:String;Default:Integer=0):Integer;
//Чтение целого числа из реестра. В случае ошибки вернёт Default



(* INC_CRTL\I_Rectangles.PIN *)
function Rect(Left, Top, Right, Bottom: Integer): TRect;
//Преобразует набор чисел в TRect
function Point(X, Y: Integer): TPoint;
//Преобразует набор чисел в TPoint
function PtInRect(const Rect: TRect; const P: TPoint): Boolean;
//Если точка P лежит в прямоугольнике Rect, вернёт True
function CenterPoint(const Rect: TRect): TPoint;
//Вернёт центральную точку прямоугольника
Function MoveRect(Rect:TRect;MoveTo:TPoint):TRect;
//Вернёт прямоугольник размерами с Rect, левый верхний угол которого
//совпадает с точкой MoveTo

(*I INC_CRTL\I_NTPROC.PIN *)
Function NTGetProcessList(var SA:TStrArray):Integer;
//под NT - создаст список имён процессов
Function NTKillProcess(psname:String;fullname:Boolean=False):Boolean;overload;
//Параметры: psname - имя процесса, fullname - признак того, что передаём полный путь до exe
function NTKillProcess(dwPID:Cardinal):Boolean;overload;
//Под NT - убьёт процесс. Если ошибка - вернёт False и юзаем GetLastError
//Для функции по psname в случае отсутствия запрашиваемого процесса вернёт LastError=87


(* INC_CRTL\I_Scripting.PIN *)
Function PlayScript(Src:String):Integer;
//Функция проигрывания скрипта.
//За основу берётся Basic-Like syntax.
//Это значит, что:
//   - Исходник регистронезависим!
//   - Каждый оператор пишется на одной строке, ПОДДЕРЖКИ ДВОЕТОЧИЯ НЕТ!
//   - Всё, что стоит после символа одинарной кавычки (') считается
//     комментарием. Для введения такой кавычки, в исходнике следует
//     ввести сигнатуру '' ($27$27)
//Поддержка операторов:
//   - SendKeys ""               Засылка последовательности нажатия клавиш
//				 операционной системе. Синтаксис совпадает
//                               с описанным для процедуры U_CRTL.SendKeys
//                               Пример: SendKeys "WinR n o t e p a d enter"
//				 запустит блокнот.
//   - Delay                     Задержка выполнения скрипта.
//                               Пример: Delay 1500
//                               остановит скрипт на 1.5 сек.
//   - MsgBox                    Покажет MsgBox. Синтаксис отличается тем, что
//				 у msgboxa есть только текст, стиль и заголовок
//				 не управляемы.
Procedure PlayScriptFile(FileName:String);
//Проиграет файл со скриптом, если таковой существует


(* INC_CRTL\I_Logging.PIN            *)
Function AppendToFile(FileName:String;Expr:String;AddCrLf:Boolean=True):Boolean;
//Добавит в файл FileName строку Expr с завершающим crlf, если AddCrLf=true
//Вернёт False в случае IOError (use GetLastError)
Function GetLogMsg(Expr:String;MultiStringWithDT:Boolean=True;prefix:String=''):String;
//преобразует строку в строку с ведущим временем вида '%D0%.%M0%.%YY% %H%:%I0%:%S0%.%e0%'
//Поведение при мультистрочных сообщениях регулируются параметром MultiStringWithDT:
// True - для каждой новой строки добавляется ведущая дата __захода в функцию
// False - добавляется по глупому - всё одной строкой
// После времени добавит таб и prefix 
Procedure AppendLogMsg(FileName:String;Expr:String;MultiStringWithDT:Boolean=True);
//Добавит сообщение expr в лог-файл FileName результат GetLogMsg(Expr,MultiStringWithDT)
Procedure AppendCryptedLogMsg(FileName:String;Expr:String);
//Добавит в лог шифрованную строку
Function ViewCryptedLogMsg(Msg:String):String;
//Расшифрует сообщение
Function CryptedLogFileToRegularString(FileName:String):String;
//Расшифрует лог файл и представит в читабельном виде

(* INC_CRTL\I_CustomIni.PIN	      *)
Function KillComments(S:String):String;
//Прибьёт комментарии из строки.
//Считает комментарием всё, что после точки с запятой и до CrLf
//Пустые строки тоже выбрасываются
Function LoadCustomIni(CfgString:String;var ParamNames:TStrArray;var ParamTypes:TIntArray;var ParamValues:TTVarArray):Boolean;
//Разберёт на переменные Конфигурационный файл, содержимое которого должно быть в CfgString
//Формат: $имя_переменной : тип = значение.
//Поддерживаемые типы:
// String - строка
// Int    - целое число
// Bool   - булева переменная, принимает значения True и False
// File	  - вернёт содержимое файла, если таковой существует, иначе пустую строку
//Причём, если приведение типов завершается неудачно, то
//функция вернёт false, а все массивы окажутся пустыми.
//Всё, что похоже на пробел (таб,пробел) удалится в том числе и из параметров
//Всё после точки с запятой - комментарий.
//Таким образом, накладывается ограничение на наличие в параметре:
// - нуля	(#00)
// - таба	(#09)
// - цр		(#13)
// - лф		(#10)
// - пробела	(#32)
// - точки с запятой (#59)
// - $
//Эти ограничения обходятся, если использовать вместо String тип File
//В случае ошибки в файле вернёт false, иначе - true

//Декларация именованных констант
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
//Нет ли ошибок в конфиге
Function GetCfgStrVar(CfgString:String;ParamName:String;DefVal:String=''):String;
Function GetCfgIntVar(CfgString:String;ParamName:String;DefVal:Integer=0):Integer;
Function GetCfgBoolVar(CfgString:String;ParamName:String;DefVal:Boolean=False):Boolean;
//Вернут значение переменной из файла конфигурации, таковая имеется. Иначе вернут DefVal
//GetCfgStrVar вернёт также и данные типа LCI_FILE

Function GetRegularIniParam(Expr:String;ParamName:String;Delimiter:String='='):String;
//вернёт значение параметра ParamName из содержимого регулярного ini-файла Expr:
//кусок строки от Delimiter до ближайшего crlf. Если параметров с одинаковым именем
//много, то возвращается последний. Если ни одного - пустая строка
//Delimiter не должен входить в ParamName


(*INC_CRTL\I_MD5.PIN       *)
function MD5(const Expr:String): String;
//Вернёт MD5Hash строки
(*I INC_CRTL\I_GOST.PIN    *)
Function GOST(S:String):String;
//Вернёт хеш строки по алгоритму GOST R 3411-94

(*I INC_CRTL\I_RC5.PIN    *)
Function rc5Encrypt(S:String;key:String):String;
Function rc5Decrypt(S:String;key:String):String;
//Расшифрует и зашифрует строку по алгоритму RC5
//Т.к. шифр блочный, в зашифрованной строке содержится контрольная сумма и длина
//исходной строки. При расшифровке они проверяются, и,
//если не соответствуют действительности, возвращается пустая строка 

(*INC_CRTL\I_Crypting.PIN  *)
Function XorCryptString(S:String;Key:String):String;
Function XorDecryptString(S:String;Key:String):String;
//Шифровка\дешифровка строки по ключу. Алгоритм шифрования достаточно простой:
//первый байт ксорится с последующим, последний ксорится с байтом ключа.
//Это происходит столько раз, сколько байт в ключе.

Function CryptString(Const Expr:String;Const Key:String):String;
Function DeCryptString(Const Expr:String;Const Key:String):String;
//Шифрование/дешифрование строки на основе XorCryptString с дополнениями
//следующего характера: на каждые 4 байта строки к ключу _СЛЕВА_ (в начало)
//добавляется случайно сгенерированный байт, в результате чего
//получается результирующий ключ. После этого к исходной строке применяется
//функция XorCryptString с результирующим ключём,
//к полученному результату применятся алгоритм дополнительного преобразования.
//Зашифрованная строка делится на тетрады (участки по 4 бита)
//и к каждой тетраде добавляется либо 6 либо 4 слева в зависимости от
//соответствующего бита сгенерированной части ключа, выборка которого ведётся
//последовательно слева направо. К полученному байту добавляется 1.
//Например, сгенерированный байт ключа имеет вид $C9 (11001001)
//Тогда зашифрованная строка $F5E4D3C2 после преобразования будет иметь вид
// $70644F456E444D63.
//При зашифрованной строке большей длины к следующим 4 байтам по такому же
//принципу добавляется следующий байт сгенерированного ключа и т д.
//При длине зашифрованной строки, не кратной 4, к оставшимся тетрадам добавляется
//случайная тетрада (4 или 6).
Function GetCRC16(S:String):Word;
//Вернёт CRC16 строки S

Function AppendCRC16(S:String):String;
//Присоединит к концу строки 2 байта CRC16, причём разряд в конце,
//старший - предпоследний.
Function ValidateCRC16(S:String):Boolean;
//Валидация результата AppendCRC16

Function AppendMD5Hash(S:String;Salt:String=''):String;
//Добавит в конец строки её MD5Hash зашифрованный CryptString с
//пустым (случайным по сути) ключём
//Результат всегда длиннее на 32 байта
//SALT - добавляется при подсчёте хэша, но в результирующей строке не фигурирует
Function ValidateMD5Hash(S:String;Salt:String=''):Boolean;
//Валидация результата AppendMD5Hash
//SALT - добавляется при подсчёте хэша, но в результирующей строке не фигурирует

Function AppendGOSTHash(S:String;Salt:String=''):String;
//Добавит в конец строки её MD5Hash зашифрованный CryptString с
//пустым (случайным по сути) ключём
//Результат всегда длиннее на 64 байта
//SALT - добавляется при подсчёте хэша, но в результирующей строке не фигурирует
Function ValidateGOSTHash(S:String;Salt:String=''):Boolean;
//Валидация результата AppendGOSTHash
//SALT - добавляется при подсчёте хэша, но в результирующей строке не фигурирует


Function GetSignedString(S:String):String;
//Подпишем строку, НЕ ГАРАНТИРУЕТСЯ ОБРАТНАЯ СОВМЕСТИМОСТЬ!
Function ValidateSignedString(S:String):String;
//Вернёт строку без подписи если валидна или пустую в случае ошибки
//Совместима с GetSignedString


FUNCTION CRC32(S:STRING) : integer;
//посчитает crc32

(* INC_CRTL\I_Unicode.PIN  *)
function USC2toWin1251(USC2Str:string):string;
// декодирование USC2
function Win1251ToUSC2(sm: string): string;
//Кодирование USC2

function Win1251ToOem(AnsiStr: string): string;
function OemToWin1251(OemStr: string): string;
//no comments

function EncodeBase64(const inStr: string): string;
//Закодирует строку в Base64
function DecodeBase64(const CinLine: string): string;
//Раскодирует строку из Base64


(* INC_CRTL\I_Melody.PIN  *)

//Немного про мелодии: предлагается внутренний формат монофонической мелодии для проигрывания на спикере.
//Каждый звук - 4 байта, из которых:
//первый (младший) - высота звука (нота), причём нота "ЛЯ" первой октавы имеет номер 57,
//		     "ля#" - 58 и т д по полутонам. 0 значает паузу.
//Не мб больше 255.
//второй - длительность звука в долях такта.
//1 - весь такт (целая)
//2 - половинная
//3 - треть
//итд, то есть делим такт на значение байта. Не мб больше 255
//Третий - пока зарезервирован
//четвёртый - указатель режима типа. Если 0, то пакет - нота, если
//	      1 - указатель темпа, тогда последующие 3 байта - размер такта в миллисекундах.

//Для StringToMelody имеется формат с человеческим лицом:
//файл с разделителями - пробелами, словами будут ноты.
//Всё что после точки с запятой - комментарий
//Формат ноты: Буква ноты, октава, повышение, в скобках - длительность
//Подробно:
//Буква - латинское обозначение ноты. РегистроНЕзависима.
//Принимаемые значения:
//C,D,E,F,G,A,B,H. Буквы B и H обозначают одну и ту же ноту - "СИ"
//Октава - номер октавы ноты.
//Первой октаве соответствует цифра 4, соответственно малой - 3, большой - 2, второй 5.
//Повышение - знак повышения или понижения тона. Принимает значения +,=,-.
//= - оставит тон без изменений,
//+ - повысит на полтона
//- - понизит.
//Длительность ноты - знаменатель длительности ноты в единицах такта.
//1 - весь такт (целая)
//2 - половинная
//3 - треть
//итд
//Для получения дробной ноты (3/4 нр) необходимо указать несколько нот
//одной высоты подряд, таких, что сумма их длительностей давала бы желаемую.
//Длительность обязательно указывается в скобках и не должна превышать 255
//Пример: A4=(8) соответствует восьмушке ноты "Ля" первой октавы.
//Так как формат сделан по "строгому" принципу, всё не подпадающее под
//описанные правила приводит к возврату пустого массива.
//Допустимые символы:
//T(integer) - устанавливает длину такта, в скобках - число миллисекунд на полный такт
//P() - пауза, в скобках - длительность паузы в формате длительности.
//! - кратковременная пауза для разделения нот
//предполагается поддержка повторений и модуляции

Procedure PlayMusic(Var melody:TIntArray);
//Проиграет мелодию из melody - мелодии во внутреннем формате
Function StringToMelody(MusString:String; var melody:TIntArray):Boolean;
//Преобразует строку с мелодией во внутренний формат

(*INC_CRTL\I_LAN.PIN*)
Function ConnectDrv(DrvPath,SharePath:String;User:String='';Pwd:String=''):Boolean;
Function DisconnectDrv(DrvPath:String):Boolean;
//Подключение и отключение сетевого диска
Function GetCompName:string;
//Вернёт имя компьютера
function UrlEncode(Str: string): string;
//Закодирует URL
Function GetCurrentUserName:string;
//Имя текущего пользователя
function GetNTDomainName: string;
//Имя домена, подсасывается из SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon


Function ShareGetAccess(comp,usr,pwd:String;ShareLetter:Char='C';domain:String=''):Cardinal;
//Отработает как
//net use \\comp\ShareLetter$ pwd /user:domain\usr
//Вернёт GetLastError
Function ShareFreeAccess(comp:String;ShareLetter:Char='C'):Cardinal;
//Отработает как net use /delete \\comp\shareletter$
//Вернёт GetLastError

(*INC_CRTL\I_Run.PIN*)
procedure StartWait(CmdLine:string;Timeout:DWORD=INFINITE);
//Запускает командную строку с ожиданием завершения процесса.
//В качестве командной строки допускается ТОЛЬКО!! исполнимый!! файл с параметрами
Function Run(Cmd:String;show:Boolean=False):Boolean;
//Свёртка функции WinExec, т.е. работает как командная строка
function GetDosOutput(const CmdLine:string;Params:String):string;overload;
function GetDosOutput(const CmdLine:string): string;overload;
//Вернёт вывод косольного приложения. Необходим путь до исполнимого файла.

(*INC_CRTL\I_XML.PIN*)
//Вся работа с XML регистроНЕзависима - и это добавляет кучу тормозов!!!
Function XMLOpenTag(Tag:String;TagParam:String=''):String;
//Вернёт открывающий таг
//С версии 1С7D80123 умеет вставлять параметр в таг
Function XMLCloseTag(Tag:String):String;
//Вернёт закрывающий таг
Function XMLFindTag(XML,Tag:String;LoseTag:Boolean=True):String;
//Вернёт значение тага Tag из выражения XML
Function XMLMakeTag(Val,Tag:String;ValIsSetOfTag:Boolean=False;TagParam:String=''):String;overload;
Function XMLMakeTag(Val:Integer;Tag:String;ValIsSetOfTag:Boolean=False;TagParam:String=''):String;overload;
//Завернёт значение Val в таг Tag. При этом если значение Val является совокупностью тагов,
//то рекомедуется выставить параметр ValIsSetOfTag в True, тогда, автоматически определив
//наличие CrLf, завернёт имеющееся значение в Tag, сделав красивый VerticalIndent в 1 пробел.
//С версии 1С7D80123 умеет вставлять параметр в таг
Procedure XMLKillComments(var XML:String);
//Прибьёт комменты - очень медленная!!


Function XMLGetTagArray(XML,Tag:String;Var SA:TStrArray;LoseTag:Boolean=False):Integer;
//Вернёт внутри массива SA нарезанную на таги TAG строку XML. Информация вне TAG теряется
//Каждый элемент SA заключён в Tag


(*I INC_CRTL\I_SVC.PIN *)
Function SvcInstall(exepath,svcname,dsplname:String;
                    svcdesc:String='';verbose:Boolean=False;
                    reinstall:Boolean=True;MachineName:String='';
                    ServiceType:Integer=SERVICE_WIN32_OWN_PROCESS):Integer;
//Установит как сервис svcname (то, что надо набрать в net start)
//с именем dsplname и описанием svcdesc исполнимый файл exepath на машину machinename,
//при этом если такой сервис уже есть - переустановит его если reinstall=true
//Внимание! verbose=true будет вызывать write(ln), использовать только в консольных
//приложениях! - вернёт GetLastError
//Все сервисы имеют режим запуска "Авто", как занадобится - поправлю

Function SvcUninstall(svcname:String;MachineName:String='';verbose:Boolean=False):Integer;
//Анинсталл сервиса, параметры как SvcInstall - вернёт GetLastError
Function SvcGetPathBySvcName(SvcName:String;MachineName:String=''):String;
//Вернёт путь до сервиса по его короткому имени или пустую строку
Function SvcGetState(SvcName:String;MachineName:String=''):Integer;
//Вернёт 0 в случае неустановленного сервиса\ошибки или состояние
//В случае 0 можно корректно использовать GetLastError
//в формате QueryServiceStatus.dwCurrentState:
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
//Запустит\остановит\продолжит\поставит паузу сервису SvcName на машине MachineName
//Вернёт SvcState в случае успеха, 0 - в случае ошибки
//Понимает SERVICE_STOPPED, SERVICE_PAUSED, SERVICE_RUNNING, на остальное -
//SetLastError(Параметр задан неверно=87=ERROR_INVALID_PARAMETER)

Function SvcSendControl(svcName:String;Control:Integer;MachineName:String=''):Integer;
//Пошлёт управляющий код сервису.
//Вернёт GetLastError


(*INC_CRTL\I_StrMath.PIN*)
const SMERR_SUCCESS           =0;
      //Операция успешно завершена
      SMERR_INVALID_NOTATION   =1;
      //Некорректная система счисления
      SMERR_ARGUMENT_EMPTY    =2;
      //Пустой аргумент
      SMERR_INCORRECT_NUMBER_NOTATION=3;
      //Невозможно представить аргумент как число в данной СС
      SMERR_NEGATIVE_LOWLEVEL_SUBTRACTION=4;
      //Попытка вычесть большее из меньшего на низком уровне
      SMERR_DIVISION_BY_ZERO=5;
      //Попытка деления на 0
Function SMGLE:Integer;
//getlasterror для строковых операций
Function SMlli256Crop(n:String):String;
//Отрежет ведущие нули у n
Procedure SMlli256Expand(var n1,n2:String);
//сравняет длины строк n1 и n2 ведущими нулями
Procedure SMlli256Normalize(var n1,n2:String);
//Приводит n1 и n2 в оптимальный для сложения\вычитания вид
Function SMlli256ValidateNotation(n:String;c:Char):Boolean;
//Вернёт True, если n можно рассматривать как число в системе с основанием C
Function SMlli256Compare(n1,n2:String):integer;
//Вернёт 1, если первое больше, 0 - если равны, -1 - если второе больше
Function SMlli256Plus(n1,n2:String):String;
//low level internal PLUS
//n1,n2: items for addition addition in scale of notation 256
//Низкоуровневое сложение чисел n1,n2 в системе счисления с основанием 256
Function SMlli256Minus(n1,n2:String):String;
//Низкоуровневое вычитание чисел (n1-n2) в системе счисления с основанием 256
//Возвращает пусто, если n1 < n2
//и будет ошибка SMERR_NEGATIVE_LOWLEVEL_SUBTRACTION
Function SMlli256Mul(n1,n2:String):String;
//Низкоуровневое умножение чисел n1,n2 в системе счисления с основанием 256
Function SMlli256DivMod(n1,n2:String; var Rslt,Rmndr:String):Boolean;
//Низкоуровневое целочисленное деление n1 на n2
//Частное - rslt, остаток - rmndr
//В случае успеха вернёт True
Function SMlli256FFToAny(n:String;c:Char):String;
//Перевод числа из 256ричной СС в любую из диапазона [2..255]
//с - основание последовательности -1, то есть чтобы перевестись в 2чную сс надо указать 1
Function SMlli256AnyToFF(n:String;c:Char):String;
//Перевод числа из любой СС в 256ричную
//с - основание последовательности -1, то есть чтобы перевестись в 2чную сс надо указать 1
//Можно выхватить пустую строку в результате и SMERR_INCORRECT_NUMBER_NOTATION в SMGLE
(*INC_CRTL\I_Propis.PIN*)
function Propis(S:Currency; money:boolean; kpk:boolean=False; usd:boolean=false):string;

(*INC_CRTL\I_TLV.PIN*)
Procedure BufferizeTL4VMessage(msg:String; Const protoHeader:String; Var PrevData:String; var outMsgArr:TStrArray);
//Буферизация сообщений в протоколе вида header|length|data, ну или tag|length|value, кому как удобнее.
//Формат сообщений таких протоколов: Заголовок|nбайтдлины(в_этом_случае_4)|данные
//Length - 4 байта в формате Integer2String4
//protoHeader - заголовок сообщения (header)
//PrevData - строка, в которой лежат предыдущие неоконченные сообщения
//outMsgArr - результирующий массив сообщений.
//msg - пришедшее сообщение
//В outMsgArr помещаются сообщения гарантированно "по одному".
//PrevData - дополняется пришедшими данными, если не выделено сообщение, и  уменьшается на собсно сообщение, если выделено

Function MessageToTL4V(msg:String;Const protoHeader:String):String;
//Перевод сообения в формат TL4V (Заголовок|nбайтдлины(в_этом_случае_4)|данные)
function GetFirstTL4VMessage(msg:String; Const protoHeader:String):String;
//Вернёт первое сообщение в формате TL4V из пакета.
//Пакет при этом никак не меняется :)

(*************************TEST*PART********************************************)

Function RND(range:Integer):Integer;
//Случайное число - потом сделаем нормальный генератор

Function JoinVia2(S1,S2,Delim:String):String;
//Соединит 2 строки через делим, если одна из них пустая, вернёт другую (2 пустых=пустая)


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






