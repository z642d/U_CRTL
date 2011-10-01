unit U_CRTLC_TCIException;
interface
 type TCIException=class
  private
    FMessage: string;
  public
    constructor Create(const Msg: string);
    property Message: string read FMessage write FMessage;
 end;//TCIException
implementation

constructor TCIException.Create;
begin
 fmessage:=Msg; 
end;

end.