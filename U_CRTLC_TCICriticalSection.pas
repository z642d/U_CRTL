unit U_CRTLC_TCICriticalSection;
interface
uses windows,U_CRTL;

type TCICriticalSection = class
private
 FSection: TRTLCriticalSection;
public
 constructor Create;
 destructor Destroy; override;
 procedure Enter;
 procedure Leave;
 procedure TryEnter;
end;//TCCriticalSection
//Simple Critical section wrapper

implementation
constructor TCICriticalSection.Create;
begin
 InitializeCriticalSection(FSection);
end;//create

destructor TCICriticalSection.Destroy;
begin
 DeleteCriticalSection(FSection);
end;//destroy

procedure TCICriticalSection.Enter;
begin
 EnterCriticalSection(FSection);
end;//Enter

procedure TCICriticalSection.Leave;
begin
 LeaveCriticalSection(FSection);
end;//Leave

procedure TCICriticalSection.TryEnter;
begin
 TryEnterCriticalSection(FSection);
end;//TryEnter
end.