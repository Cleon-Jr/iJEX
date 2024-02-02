program iJEXApp;

uses
  Vcl.Forms,
  uMain in 'Fontes\uMain.pas' {frmMain},
  uDM in 'Fontes\uDM.pas' {DM: TDataModule},
  uEContas in 'Fontes\uEContas.pas' {frmEContas},
  uSIOPE in 'Fontes\uSIOPE.pas' {frmSIOPE};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
