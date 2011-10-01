unit U_CRTLC_TCISimpleEvent;
interface
uses windows,U_CRTL;
Type TCISimpleEvent=Class
private
 fHandle:Cardinal;
 fState:Boolean;
 fThIdSet:Cardinal;
 fThIdReset:Cardinal;
 fThIdWaitFor:Cardinal;
 fStrDataSet:String;
 fStrDataReset:String;
 fStrDataWaitFor:String;
public
 property Handle:Cardinal read fHandle;
 //���������� �������
 property State:Boolean read fState;
 //��������� �������: true =Signaled, False=NonSignaled
 property ThIdSet:Cardinal read fThIdSet;
 //���������� ������, ���������� SetEvent ���������
 property ThIdReset:Cardinal read fThIdReset;
 //���������� ������, ���������� ResetEvent ���������
 property ThIdWaitFor:Cardinal read fThIdWaitFor;
 //���������� ������, ���������� WaitFor ���������
 property StrDataSet:String read fStrDataSet;
 //���������������� ������, ������������ � SetEvent
 property StrDataReset:String read fStrDataReset;
 //���������������� ������, ������������ � ResetEvent
 property StrDataWaitFor:String read fStrDataWaitFor;
 //���������������� ������, ������������ � WaitFor
 function WaitFor(TimeOut:cardinal=INFINITE;StrData:String=''):cardinal;
 //����� ��������� WaitForSingleObject(Handle)
 procedure SetEvent(StrData:String='');
 //������� SetEvent(Handle)
 procedure ResetEvent(StrData:String='');
 //������� ResetEvent(Handle)
 constructor Create(initialState:Boolean=False);
 //����������� ������. initialState ���������� ��������� ��������� �������
 destructor Destroy;override;
end;//TSimpleEvent
//������������� �������. �������� ���������� ���� ���������,
//� ������, ������� ��������� ������� ��� ��� ���� �����
//� ������������ ������������ ������ ������������ (��������� StrData).
implementation

constructor TCISimpleEvent.Create;
begin
 fstate:=initialState;
 fHandle:=CreateEvent(nil,true,fstate,nil);
end;//Create

destructor TCISimpleEvent.Destroy;
begin
 CloseHandle(fHandle);
end;//Destroy

function TCISimpleEvent.WaitFor;
begin
 fThIdWaitFor     :=GetCurrentThreadId;
 fStrDataWaitFor  :=StrData;
 result:=WaitForSingleObject(fHandle,TimeOut);
 if result=wait_timeout then
  begin
   nop;
  end;
 fThIdWaitFor     :=0;
end;//WaitFor

procedure TCISimpleEvent.SetEvent;
begin
 fState           :=True;
 fThIdSet         :=GetCurrentThreadId;
 fStrDataSet      :=StrData;
 Windows.SetEvent(fHandle);
end;//SetEvent

procedure TCISimpleEvent.ResetEvent;
begin
 fState           :=False;
 fThIdReSet       :=GetCurrentThreadId;
 fStrDataReset    :=StrData;
 windows.ResetEvent(fHandle);
end;//ResetEvent
end.