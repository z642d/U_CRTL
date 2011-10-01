unit U_CRTLC_TCIFIFOStrBuf;
interface
uses windows,U_CRTL,
    U_CRTLC_TCICriticalSection;

Type TCIFIFOStrBuf=Class
 private
  fLock:TCICriticalSection;
  Head:PStrList;
  Tail:PStrList;
  fCount:Integer;
 public
  Constructor Create;
  Destructor Destroy;override;
  Procedure PutMsg(S:String);virtual;
  //push msg to buf
  Function GetMsg:String;virtual;
  //pop msg from buf
  property Count:Integer read fCount;
  //count of data in buf
end;//TCFIFOStrBuf
//Thread-Safe FIFO buffer for strings
//Not stores empty strings!

implementation
Constructor TCIFIFOStrBuf.Create;
Begin
 fLock:=TCICriticalSection.Create;
 head:=Nil;
 tail:=Nil;
 fCount:=0;
End;//TCFIFOStrBuf.Create

Destructor TCIFIFOStrBuf.Destroy;
Begin
 while count>0 do GetMsg;
 fLock.Destroy;
End;//TCFIFOStrBuf.Destroy

Procedure TCIFIFOStrBuf.PutMsg;
var p:PStrList;
begin
 if S='' then exit;
 fLock.Enter;
 try
  new(p);
  p^.Data:=S;
  if tail<>nil then tail^.nextptr:=p;
  p^.prevptr:=tail;
  p^.nextptr:=nil;
  tail:=p;
  if head=nil then head:=p;
  inc(fCount); 
 finally
  fLock.leave;
 end;//try
end;//putmsg

Function TCIFIFOStrBuf.GetMsg;
var p:PStrList;
Begin
fLock.Enter;
 try
  Result:='';
  if head=nil then exit;
  Result:=head^.Data;
  p:=head;
  head:=head^.nextptr;
  dispose(p);
  if head=nil then tail:=nil
              else head^.prevptr:=nil;
  dec(fCount);            
finally
fLock.Leave;
end;//try
End;//GetMsg
end.