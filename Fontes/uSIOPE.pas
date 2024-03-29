unit uSIOPE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Samples.Gauges, ShellAPI;

type
  TfrmSIOPE = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    Label4: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Bevel1: TBevel;
    Label3: TLabel;
    Label6: TLabel;
    Gauge1: TGauge;
    Memo1: TMemo;
    SaveDialog2: TSaveDialog;
    Label5: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    procedure gerarSIOPE;
    procedure verifyFUNDEB;
    procedure updateFUNDEBServidor(matricula: string);
    
  public
    { Public declarations }


    var
    g_month, g_year, Folder: string;
    
  end;

var
  frmSIOPE: TfrmSIOPE;

implementation

{$R *.dfm}

uses uMain, uDM;

procedure TfrmSIOPE.DateTimePicker1Change(Sender: TObject);
begin
g_month:= FormatDateTime('MM', DateTimePicker1.Date);
g_year:= FormatDateTime('yyyy', DateTimePicker1.Date);
label5.Visible:= false;
label6.Visible:= false;
Gauge1.Progress:= 0;

verifyFUNDEB;
end;

procedure TfrmSIOPE.Edit1Change(Sender: TObject);
begin
SpeedButton2.Enabled:= true;
end;

procedure TfrmSIOPE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:= cafree;
end;

procedure TfrmSIOPE.FormShow(Sender: TObject);
var
evText: TextFile;
codEvents: string;

begin
g_month:= FormatDateTime('MM', DateTimePicker1.Date);
g_year:= FormatDateTime('yyyy', DateTimePicker1.Date);

     if not FileExists(ExtractFilePath(ParamStr(0)) + '/codEvents.txt') then
        begin
          codEvents:= edit1.Text;
          AssignFile(evText, ExtractFilePath(ParamStr(0)) + '/codEvents.txt');
          Rewrite(evText);
          Writeln(evText, codEvents);
          Reset(evText);
          CloseFile(evText);
        end
        else
        begin
             AssignFile(evText, ExtractFilePath(ParamStr(0)) + '/codEvents.txt');
             Reset(evText);
             Readln(evText, codEvents);
             Edit1.Text:= codEvents;
             CloseFile(evText);
        end;


end;

procedure TfrmSIOPE.gerarSIOPE;
var
qry, inst: string;
fileCSV: TStringList;
prog, count, ln, horas_mes: integer;
situacao_siope, segmento_atuacao_siope, tipo_cat_codigo: string;

begin
inst:= frmMain.inst;
label5.Visible:= true;
label6.Visible:= true;

ln:= 0;
count:= 0;

fileCSV:= TStringList.Create();



qry:= 'select distinct cv.matricula, cv.mes, f.cnpf, f.nome, cv.localidade_siope as loc_codigo, l.nome as loc_nome, ' +
'ca.horas_mes, coalesce(cv.tipo_categoria_siope,0) as tipo_cat_codigo, tcs.descricao as tipo_cat_nome, coalesce(cv.situacao_siope,0) as situacao_siope, ' +
'coalesce(f.segmento_atuacao_siope,0) as segmento_atuacao_siope, ' +
'cv.categoria_siope as cat_codigo, cs.descricao as cat_descricao, cv.fundeb70_siope, cv.fundeb30_siope, ' +
'f.art61_phnms_siope, f.art61_tepdp_siope, f.art61_tepdc_siope, f.art61_tepeu_siope, f.art61_pgtfc_siope, f.art61_outros_siope, ' +
'f.art1_psp_siope, f.art1_psss_siope, f.art1_outros_siope, ' +
'iif(cv.salario_cargo > 0, cv.salario_cargo, 954) as salario_base, ' +
'iif((cv.fundeb70_siope = ''S''), ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor)' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + edit1.Text + ') ' +
        'group by vv.matricula) ' +
    '),' +
    '0)' +
   ',0) as fundeb_70, ' +
'iif((cv.fundeb30_siope = ''S''), ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0)' +
   ',0) as fundeb_30, ' +
'iif(f.fundef_25 = ''S'', ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0)' +
   ',0) as fundeb_25,' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0) as total_proventos ' +
'from capa_variavel cv ' +
'inner join funcionario f on f.codigo = cv.matricula ' +
'left join localidade_siope l on l.codigo = cv.localidade_siope ' +
'left join cargo ca on ca.codigo = cv.codigo_cargo ' +
'left join tipo_categoria_siope tcs on tcs.codigo = cv.tipo_categoria_siope ' +
'left join categoria_siope cs on cs.codigo = cv.categoria_siope ' +
'where cv.mes = ' + g_month +
'and cv.ano = ' + g_year +
'and cv.localidade_siope is not null and cv.tipo_categoria_siope is not null and cv.categoria_siope is not null ' +
'and cv.sequencia in (0) ' +
'and (coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula) ' +
    '),' +
    '0)) > 0 ' +

'union all ' +

'select distinct cv.matricula, cv.mes, f.cnpf, f.nome, cv.localidade_siope as loc_codigo, l.nome as loc_nome, ' +
'ca.horas_mes, coalesce(cv.tipo_categoria_siope,0) as tipo_cat_codigo, tcs.descricao as tipo_cat_nome, coalesce(cv.situacao_siope,0) as situacao_siope, ' +
'coalesce(f.segmento_atuacao_siope,0) as segmento_situacao_siope, ' +
'cv.categoria_siope as cat_codigo, cs.descricao as cat_descricao, cv.fundeb70_siope, cv.fundeb30_siope, ' +
'f.art61_phnms_siope, f.art61_tepdp_siope, f.art61_tepdc_siope, f.art61_tepeu_siope, f.art61_pgtfc_siope, f.art61_outros_siope, ' +
'f.art1_psp_siope, f.art1_psss_siope, f.art1_outros_siope, ' +
'iif(cv.salario_cargo > 0, cv.salario_cargo, 954) as salario_base, ' +
'iif(cv.fundeb70_siope = ''S'', ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula) ' +
    '),' +
    '0)' +
   ',0) as fundeb_70, ' +
'iif(cv.fundeb30_siope = ''S'', ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0)' +
   ',0) as fundeb_30, ' +
'0 as zero, ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0)' +
'as total_proventos ' +
'from capa_variavel cv ' +
'inner join funcionario f on f.codigo = cv.matricula ' +
'left join localidade_siope l on l.codigo = cv.localidade_siope ' +
'left join cargo ca on ca.codigo = cv.codigo_cargo ' +
'left join tipo_categoria_siope tcs on tcs.codigo = cv.tipo_categoria_siope ' +
'left join categoria_siope cs on cs.codigo = cv.categoria_siope ' +
'where cv.mes = ' + g_month +
'and cv.ano = ' + g_year +
'and cv.localidade_siope is not null and cv.tipo_categoria_siope is not null and cv.categoria_siope is not null ' +
'and (coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.sinal = ''R'' and vv.matricula = cv.matricula ' +
        'group by vv.matricula)' +
     '),0)' +
    ' - ' +
    'coalesce(' +
    '(' +
        '(select sum(vv.valor) ' +
        'from variavel vv ' +
        'where vv.mes = cv.mes and vv.ano = cv.ano and vv.matricula = cv.matricula and vv.provento in (' + Edit1.Text + ') ' +
        'group by vv.matricula)' +
    '),' +
    '0)) > 0 ' +
'and cv.sequencia in (13, 1) and ' +
'cv.matricula not in (' +
    'select ccv.matricula ' +
    'from capa_variavel ccv ' +
    'where ccv.matricula = cv.matricula and ccv.mes = cv.mes and ccv.ano = cv.ano and ccv.sequencia = 0)';

     with(DM.sqlSIOPE)do
         begin
            Memo1.Clear;

            Close;
            SQL.Clear;
            SQL.Add(qry);
            Open;
            FetchAll;
            First;

            Gauge1.MinValue:= 0;
            Gauge1.MaxValue:= RecordCount;
            Gauge1.Progress:= 1;


            while not(Eof) do
              begin
                  ln:= ln + 1;
                  Gauge1.Progress:= ln;

                  //Tratamento de dados
                  if(FieldByName('tipo_cat_codigo').AsString = '1')then
                    begin
                      tipo_cat_codigo:= 'Profissionais do Magist�rio';
                    end;
                  if(FieldByName('tipo_cat_codigo').AsString = '2')then
                    begin
                      tipo_cat_codigo:= 'Outros Profissionais da Educa��o';
                    end;

                    case StrToInt(FieldByName('situacao_siope').AsString) of
                    1:
                      situacao_siope := 'EFETIVO';
                    2:
                      situacao_siope := 'TEMPOR�RIO';
                    3:
                      situacao_siope := 'PROFISSIONAL DA EDUCA��O EM ATIVIDADE ALHEIA � MDE';
                    4:
                      situacao_siope := 'OUTROS';
                    else
                      situacao_siope := 'OUTROS';
                    end;


                    case Strtoint(FieldByName('SEGMENTO_ATUACAO_SIOPE').AsString) of
                      1:
                      segmento_atuacao_siope:= 'Creche';
                      2:
                      segmento_atuacao_siope:= 'Pre-Escola';
                      3:
                      segmento_atuacao_siope:= 'Fundamental 1';
                      4:
                      segmento_atuacao_siope:= 'Fundamental 2';
                      5:
                      segmento_atuacao_siope:= 'Medio';
                      6:
                      segmento_atuacao_siope:= 'Profissional';
                      7:
                      segmento_atuacao_siope:= 'Administrativo';
                      else
                      segmento_atuacao_siope:= 'OUTROS';
                    end;

                    if (FieldByName('horas_mes').AsString <> '') then
                    begin
                      horas_mes:= (FieldByName('horas_mes').AsInteger) div 5;
                    end;

                    
                    //Cria��o do arquivo CSV
                    fileCSV.Add(
                    'I;' +
                    '0;' +
                    FieldByName('mes').AsString + ';' +
                    FieldByName('cnpf').AsString + ';' +
                    FieldByName('matricula').AsString + ';' +
                    FieldByName('nome').AsString + ';' +
                    FieldByName('loc_codigo').AsString + ';' +
                    FieldByName('loc_nome').AsString + ';' +
                    inttostr(horas_mes) + ';' +
                    FieldByName('tipo_cat_codigo').AsString + ';' +
                    FieldByName('tipo_cat_nome').AsString + ';' +
                    FieldByName('cat_codigo').AsString + ';' +
                    FieldByName('cat_descricao').AsString + ';' +
                    FieldByName('situacao_siope').AsString + ';' +
                    situacao_siope + ';' +
                    FieldByName('segmento_atuacao_siope').AsString + ';' +
                    segmento_atuacao_siope + ';' +
                    FieldByName('salario_base').AsString + ';' +
                    FieldByName('fundeb_70').AsString + ';' +
                    FieldByName('fundeb_30').AsString + ';' +
                    FieldByName('fundeb_25').AsString + ';' +
                    FieldByName('total_proventos').AsString + ';' +
                    FieldByName('art61_phnms_siope').AsString + ';' +
                    FieldByName('art61_tepdp_siope').AsString + ';' +
                    FieldByName('art61_tepdc_siope').AsString + ';' +
                    FieldByName('art61_tepeu_siope').AsString + ';' +
                    FieldByName('art61_pgtfc_siope').AsString + ';' +
                    FieldByName('art61_outros_siope').AsString + ';' +
                    FieldByName('art1_psp_siope').AsString + ';' +
                    FieldByName('art1_psss_siope').AsString + ';' +
                    FieldByName('art1_outros_siope').AsString + ';' +
                    ''
                    );

                    // Erros
                    if(FieldByName('tipo_cat_codigo').AsString <> null) then
                      begin
                        if(FieldByName('fundeb70_siope').AsString = 'N') and (FieldByName('fundeb30_siope').AsString = 'N') then
                          begin
                            Memo1.Lines.Add('Linha ' +
                            inttostr(ln) + '- Matr�cula: ' + FieldByName('matricula').AsString + ' CPF: ' + FieldByName('cnpf').AsString +
                            ' - ' + tipo_cat_codigo + ' - Fundeb n�o definido: 30% ou 70%'
                            );
                          end;
                      end;

                    if(FieldByName('tipo_cat_codigo').AsString <> null)then
                      begin
                        if(FieldByName('art61_phnms_siope').AsString = 'N') and
                          (FieldByName('art61_tepdp_siope').AsString = 'N') and
                          (FieldByName('art61_tepdc_siope').AsString = 'N') and
                          (FieldByName('art61_tepeu_siope').AsString = 'N') and
                          (FieldByName('art61_pgtfc_siope').AsString = 'N') and
                          (FieldByName('art61_outros_siope').AsString = 'N') and
                          (FieldByName('art1_psp_siope').AsString = 'N') and
                          (FieldByName('art1_psss_siope').AsString = 'N') and
                          (FieldByName('art1_outros_siope').AsString = 'N')then
                          begin
                            Memo1.Lines.Add('Linha ' +
                            inttostr(ln) + '- Matr�cula: ' + FieldByName('matricula').AsString + ' CPF: ' + FieldByName('cnpf').AsString +
                            ' - Qualifica��o do FUNDEB n�o informada!'
                            );
                          end;

                        if(FieldByName('art61_phnms_siope').AsString = '') and
                          (FieldByName('art61_tepdp_siope').AsString = '') and
                          (FieldByName('art61_tepdc_siope').AsString = '') and
                          (FieldByName('art61_tepeu_siope').AsString = '') and
                          (FieldByName('art61_pgtfc_siope').AsString = '') and
                          (FieldByName('art61_outros_siope').AsString = '') and
                          (FieldByName('art1_psp_siope').AsString = '') and
                          (FieldByName('art1_psss_siope').AsString = '') and
                          (FieldByName('art1_outros_siope').AsString = '')then
                          begin
                            Memo1.Lines.Add('Linha ' +
                            inttostr(ln) + '- Matr�cula: ' + FieldByName('matricula').AsString + ' CPF: ' + FieldByName('cnpf').AsString +
                            ' - Qualifica��o do FUNDEB n�o informada!'
                            );
                          end;

                      end;

                  label5.Caption:= 'Registros processados ' + IntToStr(ln);
                  label5.Update;

                  Next;
              end;

              label6.Caption:= 'Arquivo pronto!';
              label6.Font.Color:= clGreen;
              label6.Update;

              fileCSV.SaveToFile(Folder + '/siope - ' + g_month + '-' + g_year + '.csv');
              fileCSV.Free;

              Application.MessageBox('Arquivo gerado com sucesso! A pasta ser� aberta.',' iJEX - Gera��o de arquivo SIOPE | Sucesso', MB_ICONEXCLAMATION + MB_OK);

              Close;
         end;


end;

procedure TfrmSIOPE.SpeedButton1Click(Sender: TObject);
begin
self.Close;
end;

procedure TfrmSIOPE.SpeedButton2Click(Sender: TObject);
var
evText: TextFile;
codEvents: string;

begin
codEvents:= edit1.Text;
AssignFile(evText, ExtractFilePath(ParamStr(0)) + '/codEvents.txt');
Rewrite(evText);
Writeln(evText, codEvents);
Reset(evText);
CloseFile(evText);

Application.MessageBox('C�digo de Eventos salvo com sucesso!',' iJEX | SUCESSO', MB_ICONEXCLAMATION + MB_OK);
SpeedButton2.Enabled:= false;
end;

procedure TfrmSIOPE.SpeedButton3Click(Sender: TObject);
var
inst: string;

begin
inst:= frmMain.inst;
SaveDialog2.FileName:= 'SIOPE ' + StringReplace(inst,' ',EmptyStr,[rfReplaceAll]);

    if(SaveDialog2.Execute())then
       begin
            Folder:= SaveDialog2.FileName + ' - ' + g_year + '-' + g_month;
            if not(DirectoryExists(Folder)) then
               begin
                 MkDir(Folder);
               end;


               gerarSIOPE;
            
       end;

       ShellExecute(Application.Handle, 'open', PChar(Folder), nil, nil, SW_NORMAL);



end;


procedure TfrmSIOPE.updateFUNDEBServidor(matricula: string);
var
qryUp: string;

begin
qryUp:= 'update capa_variavel cv ' +
      'set cv.fundeb70_siope = ''S'', cv.fundeb30_siope = ''N'', cv.fundef_40 = ''N'', cv.fundef_60 = ''S'' ' +
      'where cv.ano = ' + g_year + ' and cv.mes = ' + g_month + ' and cv.matricula = :mat';

      with(DM.sqlUpdates)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qryUp);
          ParamByName('mat').AsString:= matricula;

          try
            ExecSQL;

          Except on E: Exception do
            begin
              Application.MessageBox(Pchar('N�o foi poss�vel corrigir o registro! ' + E.Message),' iJEX | ERRO', MB_ICONERROR + MB_OK);
              Abort;
            end;

          end;

        end;

end;



procedure TfrmSIOPE.verifyFUNDEB;
var
qry: string;
qnt: integer;

begin
qry:= 'select distinct cv.matricula, cv.mes, cv.ano, cv.fundef_25, cv.fundef_40, cv.fundef_60, cv.fundeb30_siope, cv.fundeb70_siope ' +
    'from capa_variavel cv ' +
    'join funcionario f on f.codigo = cv.matricula ' +
    'where cv.ano = ' + g_year + ' and cv.mes = ' + g_month + ' and cv.tipo_categoria_siope is not null and cv.fundeb70_siope = ''N''';

    with(DM.sqlErrors)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        if(RowsAffected > 0)then
          begin
            if(Application.MessageBox(Pchar(IntToStr(RecordCount) + ' inconsist�ncia(s) encontrada(s): defini��o de 30% ou 70% do FUNDEB ausente.' + #13 +
            'Deseja que a aplica��o corrija esses registros? Registros ser�o definidos para 70% do FUNDEB.'),' iJEX | ATEN��O', MB_ICONQUESTION + MB_YESNO) = IDYES)then
                begin
                  while not(Eof) do
                    begin
                      updateFUNDEBServidor(FieldByName('matricula').AsString);

                      Next;
                    end;
                    Application.MessageBox('Registros corrigidos com sucesso!',' iJEX | SUCESSO', MB_ICONEXCLAMATION + MB_OK);

                    Close;
                end;
          end;
      end;

end;


end.
