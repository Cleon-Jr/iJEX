unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Comp.UI, vcl.Dialogs, IniFiles, vcl.Forms, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    sqlUO: TFDQuery;
    sqlDuplication: TFDQuery;
    sqlUOCODIGO: TStringField;
    sqlUONOME: TStringField;
    sqlUOUNI_CODIGO: TStringField;
    sqlAssociation: TFDQuery;
    sqlInsertUO: TFDQuery;
    sqlFolhaPagamento: TFDQuery;
    sqlFolhaPagamentoServidor: TFDQuery;
    sqlServidor: TFDQuery;
    sqlDetalheFolha: TFDQuery;
    sqlBeneficiario: TFDQuery;
    sqlEventosFolha: TFDQuery;
    sqlCargosPlano: TFDQuery;
    sqlAtosAdmissao: TFDQuery;
    sqlDependenteServidor: TFDQuery;
    sqlAtoCessaoDisp: TFDQuery;
    sqlSIOPE: TFDQuery;
    sqlErrors: TFDQuery;
    sqlUpdates: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    connectStatus: string;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uMain;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
connectStatus:= 'Off';
end;

end.
