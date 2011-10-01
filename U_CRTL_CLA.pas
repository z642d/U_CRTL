unit U_CRTL_CLA;
interface
Uses
 windows,U_CRTL,
 U_CRTLC_TCIException,
 U_CRTLC_TCISimpleEvent,
 U_CRTLC_TCICriticalSection,
 U_CRTLC_TCIFIFOStrBuf,
 U_CRTLC_TCIFIFOStrBufSync,
 U_CRTLC_TCIFIFOPtrBuf,
 U_CRTLC_TCIFIFOPtrBufSync,
 U_CRTLC_TCISyncLog
 ;
//Ustin'z common runtime library classes collection, Copyright © 2008 Ustin
//Naming rules: Class names must begin with TC
//Description always follows code, not before
//Политика именования:
//1) Каждый класс в своём файле
//2) Классы в файлах начинаются с префикса TCI, внешние обёртки - с префикса TC


const CRTL_CLA_VER='$007D81230';
//History:
//$007D81230 - Startup

type UException=class(TCIException);
type TCSimpleEvent=class(TCISimpleEvent);
type TCCriticalSection=class(TCICriticalSection);
type TCFIFOStrBuf=class(TCIFIFOStrBuf);
Type TCFIFOStrBufSync=Class(TCIFIFOStrBufSync);
type TCFIFOPtrBuf=class(TCIFIFOPtrBuf);
Type TCFIFOPtrBufSync=Class(TCIFIFOPtrBufSync);

type TCSyncLog=class(TCISyncLog);





implementation
end.
