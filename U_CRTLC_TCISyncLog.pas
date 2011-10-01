unit U_CRTLC_TCISyncLog;
interface
uses windows,U_CRTL,
     U_CRTLC_TCIFifoStrBuf,
     U_CRTLC_TCIFifoStrBufSync,
     U_CRTLC_TCICriticalSection
     ;
 type TCISyncLog=class
  private
   flogbuf:tcififoStrBuf;
   fsec:TCICriticalSection;
   fLogLevel:Integer;
   procedure SetLogLevel(nw:Integer);
  public
   constructor create(sync:Boolean);
   destructor destroy;override;
   property loglevel:Integer read fLogLevel write SetLogLevel; 
   procedure Log(msg:String;level:Integer=0);
   function GetLog:String;
 end;//TCISyncLog
 //Потоконезависимый Менеджер логов.
 //Если указать create sync=true, то менеджер будет работать в синхронном режиме - поток будет останавливаться при пустой очереди и ждать поступления сообщений
implementation

constructor TCISyncLog.create;
begin
 fsec:=TCICriticalSection.Create;
 if sync then flogbuf:=TCIFIFOStrBufSync.Create else flogbuf:=TCIFIFOStrBuf.Create;
 fLogLevel:=0;
end;

destructor TCISyncLog.destroy;
begin
 flogbuf.Destroy;
 fsec.Destroy; 
end;

procedure TCISyncLog.SetLogLevel;
begin
 fsec.Enter;
 fLogLevel:=nw;
 fsec.Leave;
end;

procedure TCISyncLog.Log;
begin
 if level<=flogLevel then flogbuf.PutMsg(msg);
end;

function TCISyncLog.GetLog;
begin
 result:=flogbuf.GetMsg;  
end;

end.