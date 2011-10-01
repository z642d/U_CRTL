unit UDbIf2;
interface
Uses Windows,sysutils,U_CRTL,
     DB, IBCustomDataSet,
     IBQuery, IBDatabase,IBSQL;


Type TFBDBDatabase=class(TIBDatabase);
     TFBDBTransaction=TIBTransaction;
     TFBDBQuery=TIBDataset;
     TFBDBTrueQuery=TIBQuery;
     TFBDBSql=TIBSql;

Type TDBIF2Cfg=record
 DBName:String;
 //»м€ базы, в которую всЄ вливать
 DBUser:String;
 //»м€ пользовател€
 DBRole:String;
 //–оль - ќЅя«ј“≈Ћ№Ќџ… параметр!
 DBPwd:String;
 //;ѕароль
end;

Type TDBIF2=Class
 Public
  CFG:    TDBIF2Cfg;
  DB :    TFBDBDatabase;
  TR :    TFBDBTransaction;
  SQL:    TFBDBSql;
 public
  procedure FillConfig(dbname:String;dbuser:String='';dbpwd:String='';dbrole:String=''); 
  constructor Create;
  destructor Destroy;override;
  procedure Connect;
  procedure Disconnect;
  procedure CreateAndConnect(dbname:String;dbuser:String='';dbpwd:String='';dbrole:String='');
  class Procedure GetScript(S:String;var ScpArr:TStrArray);
  procedure PlayScript(scp:String);
 private
  Function GetConnected:Boolean;
 public
  property connected:Boolean read GetConnected;
end;

implementation

function TDBIF2.GetConnected;
begin
 result:=db.Connected;
end;

procedure TDBIF2.FillConfig;
begin
 cfg.DBName:=dbname;
 cfg.DBUser:=dbuser;
 cfg.DBPwd :=dbpwd;
 cfg.DBRole:=dbrole;
 DB.DatabaseName:=cfg.DBName;
 DB.Params.Text:=
  iif(cfg.DBUser='','','user_name='+cfg.DBUser+vbcrlf)+
  iif(cfg.DBUser='','','password='+cfg.DBPwd+vbcrlf)+
  iif(cfg.DBUser='','','sql_role_name='+cfg.DBRole);
 db.LoginPrompt:=False;
 DB.SQLDialect:=1;
end;//


Class Procedure TDBIF2.GetScript;
var j:Integer;
    SA:TStrArray;
    delim:String;
Begin
 SplitByBrackets(S,'/*','*/',SA,false);
 for j:=0 to high(SA) do replace(S,SA[j],'');
 //”биваем комментарии - совместимость с IBE
 delim:=';';
 FastSplit(S,delim,SA,true);
 SetLength(ScpArr,0);
 while length(SA)>1 do
  begin
   for j:=0 to high(SA) do
    Begin
     IF instr(ucase(SA[j]),'SET TERM')>0 then
      begin
       S:=Join(SA,delim,j+1);
       delim:=GetWordByNo(sa[j],2);
       FastSplit(S,delim,SA,true);
       break;
      end;
     if KillSpaces(SA[j])<>'' then AppendElement(ScpArr,SA[j]);
     if j=high(SA) then exit;
    End;//for
   end;//wend
End;//TDBIF2.GetScript

procedure TDBIF2.PlayScript;
var j:Integer;
    SA:TStrArray;
begin
    Tr.Active:=true;
    GetScript(scp,SA);
   for j:=0 to high(SA) do
    Begin
     SQL.Close;
     SQL.SQL.Text:=SA[j];
     if SA[j]<>'' then SQL.ExecQuery;
    End;//проигрываем скрипт
   TR.Commit;
end;//TDBIF2.PlayScript


procedure TDBIF2.Connect;
Begin
 db.Open;
End;

procedure TDBIF2.Disconnect;
begin
 db.Close;
end;

Procedure TDBIF2.CreateAndConnect;
begin
 FillConfig(dbname,dbuser,dbpwd,dbrole);
 db.CreateDatabase;
 Disconnect;
 connect;
End;



constructor TDBIF2.Create;
Begin
  db:=TFBDBDatabase.create(nil);
  TR:=TFBDBTransaction.Create(nil);
  SQL :=TFBDBSql.Create(nil);
  tr.DefaultDatabase:=DB;
  SQL.Database:=DB;
  SQL.Transaction:=TR;
End;//Create



destructor TDBIF2.Destroy;
Begin
 sql.Destroy;
 tr.Destroy;
 db.Destroy;
End;//Destroy

end.
