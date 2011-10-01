unit U_CRTLC_TCIFIFOPtrBufSync;
interface
uses windows,U_CRTL,
     U_CRTLC_TCIFIFOPtrBuf,
     U_CRTLC_TCISimpleEvent,
     U_CRTLC_TCICriticalSection
     ;
Type TCIFIFOPtrBufSync=Class(TCIFIFOPtrBuf)
 private
  fDataAvail:TCISimpleEvent;
 public
  Constructor Create;
  Destructor Destroy;override;
  Procedure PutMsg(S:pointer);override;
  Function GetMsg:pointer;override;
end;
//Процедура GetMsg синхронная (поток ждёт появления сообщения)

implementation

constructor TCIFIFOPtrBufSync.Create;
begin
 fDataAvail:=TCISimpleEvent.Create;
 fDataAvail.ResetEvent;
 inherited;
end;//TCTCFIFOPtrBufSync.Destroy

Destructor TCIFIFOPtrBufSync.Destroy;
begin
 fDataAvail.Destroy;
 inherited;
end;//TCTCFIFOPtrBufSync.Destroy

procedure TCIFIFOPtrBufSync.PutMsg;
begin
 inherited;
 fDataAvail.SetEvent;
end;//TCTCFIFOPtrBufSync.PutMsg

function TCIFIFOPtrBufSync.GetMsg;
begin
 fDataAvail.WaitFor(INFINITE);
 result:=inherited getmsg;
 if count=0 then fDataAvail.ResetEvent;
end;//TCTCFIFOPtrBufSync.GetMsg

end.