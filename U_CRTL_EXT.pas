unit U_CRTL_EXT;
(*
Ustin'z common runtime library,
External functions declaration
*)
interface
Uses Windows;

{$i inc_crtl\ext\I_H_CORRECT.PIN}

{$i inc_crtl\ext\I_H_PSAPI.PIN}
{$i inc_crtl\ext\I_H_SHELLAPI.PIN}
{$i inc_crtl\ext\I_H_SHFOLDER.PIN}
{$i inc_crtl\ext\I_H_WINSVC.PIN}

{$i inc_crtl\ext\I_H_LM.PIN}
{$i inc_crtl\ext\I_H_ICMP.PIN}



implementation

{$i inc_crtl\ext\I_C_CORRECT.PIN}

{$i inc_crtl\ext\I_C_PSAPI.PIN}
{$i inc_crtl\ext\I_C_SHELLAPI.PIN}
{$i inc_crtl\ext\I_C_SHFOLDER.PIN}
{$i inc_crtl\ext\I_C_WINSVC.PIN}


{$i inc_crtl\ext\I_C_LM.PIN}
{$i inc_crtl\ext\I_C_ICMP.PIN}


procedure test;
//var j:Integer;
begin

end;

end.






