unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, IniFiles;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    contentMain: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Image2: TImage;
    Label6: TLabel;
    FileOpenDialog1: TFileOpenDialog;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    SpeedButton6: TSpeedButton;
    Label7: TLabel;
    procedure SpeedButton3Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }


    inst: string;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uDM, uEContas, uSIOPE;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if(DM.connectStatus = 'Off')then
    begin
      Image2.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/imgs/database-off.png');
      label6.Caption:= 'Desconectado.';
      label6.Font.Color:= clRed;
    end;
  if(DM.connectStatus = 'On')then
    begin
      Image2.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/imgs/database-on.png');
      label6.Caption:= 'Conectado!';
      label6.Font.Color:= clGreen;
    end;
end;

procedure TfrmMain.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $f012;

begin
ReleaseCapture;
Perform(WM_SYSCOMMAND, sc_DragMove, 0);

end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  if(Screen.FormCount <= 1)then
    begin
      Application.CreateForm(TfrmEContas, frmEContas);
      frmEContas.Parent:= contentMain;
      frmEContas.Show;
      frmEContas.Top:= 0;
      frmEContas.Left:= 0;
    end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  if(Screen.FormCount <= 1)then
    begin
      Application.CreateForm(TfrmSIOPE, frmSIOPE);
      frmSIOPE.Parent:= contentMain;
      frmSIOPE.Show;
      frmSIOPE.Top:= 0;
      frmSIOPE.Left:= 0;
    end;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
Application.Terminate;

end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
begin
  if(edit3.Text <> '')then
    begin
      DM.FDConnection.Connected:= false;
      DM.FDConnection.Params.Clear;
      DM.FDConnection.Params.DriverID:= 'FB';
      DM.FDConnection.Params.Add('Server=' + edit1.Text);
      DM.FDConnection.Params.Add('Port=' + edit2.Text);
      DM.FDConnection.Params.Database:= edit3.Text;
      DM.FDConnection.Params.UserName:= 'sysdba';
      DM.FDConnection.Params.Password:= 'masterkey';
      DM.FDPhysFBDriverLink1.VendorLib:= ExtractFilePath(ParamStr(0)) + '/fbclient.dll';

      try
        DM.FDConnection.Connected:= true;

        Image2.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/imgs/database-on.png');
        label6.Caption:= 'Conectado!';
        label6.Font.Color:= clGreen;

        inst:= DM.FDConnection.ExecSQLScalar('select first 1 * from empresa');
        label2.Caption:= ' iJEX | ' + inst;
        SpeedButton1.Enabled:= true;
        SpeedButton2.Enabled:= true;
        SpeedButton5.Visible:= true;
        SpeedButton4.Enabled:= false;


      Except on E: Exception do
        begin
          Application.MessageBox(Pchar('Erro ao tentar se conectar com o banco de dados! ' + E.Message), ' iJEX | Erro', MB_ICONERROR + MB_OK);

          Image2.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/imgs/database-off.png');
          label6.Caption:= 'Desconectado.';
          label6.Font.Color:= clRed;
          SpeedButton4.Enabled:= true;

          Abort;
        end;

      end;

    end
    else
    begin
      Application.MessageBox('Selecione o banco de dados antes de prosseguir!',' iJEX | ATEN��O', MB_ICONSTOP + MB_OK);
    end;

end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
DM.FDConnection.Connected:= false;
Image2.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/imgs/database-off.png');
label6.Caption:= 'Desconectado.';
label6.Font.Color:= clRed;
SpeedButton1.Enabled:= false;
SpeedButton2.Enabled:= false;
SpeedButton5.Visible:= false;
SpeedButton4.Enabled:= true;

end;

procedure TfrmMain.SpeedButton6Click(Sender: TObject);
begin
  SpeedButton4.Caption:= 'Aguarde...';
  FileOpenDialog1.Execute;
  if(FileOpenDialog1.FileName <> '')then
    begin
      edit3.Text:= FileOpenDialog1.FileName;
      SpeedButton4.Caption:= 'Conectar';
    end

end;

end.
