unit U_CRTLC_TCIFIFOStrBufSync;
interface
uses windows,U_CRTL,
     U_CRTLC_TCIFIFOStrBuf,
     U_CRTLC_TCISimpleEvent,
     U_CRTLC_TCICriticalSection
     ;
Type TCIFIFOStrBufSync=Class(TCIFIFOStrBuf)
 private
  fDataAvail:TCISimpleEvent;
 public
  Constructor Create;
  Destructor Destroy;override;
  Procedure PutMsg(S:String);override;
  Function GetMsg:String;override;
end;
//Процедура GetMsg синхронная (поток ждёт появления сообщения)

implementation

constructor TCIFIFOStrBufSync.Create;
begin
 fDataAvail:=TCISimpleEvent.Create;
 fDataAvail.ResetEvent;
 inherited;
end;//TCTCFIFOStrBufSync.Destroy

Destructor TCIFIFOStrBufSync.Destroy;
begin
 fDataAvail.Destroy;
 inherited;
end;//TCTCFIFOStrBufSync.Destroy

procedure TCIFIFOStrBufSync.PutMsg;
begin
 inherited;
 fDataAvail.SetEvent;
end;//TCTCFIFOStrBufSync.PutMsg

function TCIFIFOStrBufSync.GetMsg;
begin
 fDataAvail.WaitFor(INFINITE);
 result:=inherited getmsg;
 if count=0 then fDataAvail.ResetEvent;
end;//TCTCFIFOStrBufSync.GetMsg

end.