program DPTFX;

uses
  Vcl.Forms,
  AOknoGl_frm in 'AOknoGl_frm.pas' {AOknoGl},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Delphi Programming Tools FX';
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TAOknoGl, AOknoGl);
  Application.Run;
end.
