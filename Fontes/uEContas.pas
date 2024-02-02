unit uEContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Samples.Gauges, Data.DB, Vcl.Grids,
  Vcl.DBGrids, ShellAPI, System.JSON, System.DateUtils;

type
  TfrmEContas = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Gauge1: TGauge;
    SpeedButton2: TSpeedButton;
    Panel2: TPanel;
    Label3: TLabel;
    Bevel1: TBevel;
    SaveDialog1: TSaveDialog;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure gerarFolhaDePagamento;
    procedure gerarFolhaDePagamentoServidor;
    procedure gerarServidor;
    procedure gerarDetalheFolha;
    procedure gerarDependenteServidor;
    procedure gerarAtoCessaoDisposicao;
    procedure gerarEventosFolha;
    procedure gerarBeneficiarioPensao;
    procedure gerarCargosPlano;
    procedure gerarAtosAdmissaoFolha;


  public
    { Public declarations }
    procedure consultaUO;
    procedure duplicationUO;
    procedure delDuplication;
    procedure cleanGrid;
    procedure addUO(year, codLotacao, codUO: string);
    procedure associationUO(year, codLotacao: string);
    procedure insertUO(codLotacao, codUO, year: string);

    function strPadLeft(val: string; i: integer; ch: char): string;
    function toDate(Data: string): string;
    function toDateVigencia(Data: string): string;
    function strPad(val: string; i: integer): string;
    function removeCharSpecials(val: string): string;


    var
    UOList: TStringList;
    Folder, G_Month, G_Year: string;

  end;

var
  frmEContas: TfrmEContas;


const
  Acentuado = '����������������������������';
  NaoAcentuado = 'aaeouaoaeioucuAAEOUAOAEIOUCU';


implementation

{$R *.dfm}

uses uDM, uMain;

//Verifica se existe a lota��o na compet�ncia anterior
procedure TfrmEContas.associationUO(year, codLotacao: string);
var
qry, codUO: string;
beforeYear: integer;

begin
beforeYear:= StrToInt(year) - 1;

qry:= 'select distinct l.codigo, ld.uni_codigo, ld.ano ' +
      'from lotacao l ' +
      'join lotacao_dotacao ld on ld.codigo_lotacao = l.codigo ' +
      'where ld.ano = :year and ld.codigo_lotacao = :codLotacao ' + //--,0104029,0104028,0104027)
      'group by 1,2,3';

      with(DM.sqlAssociation)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          ParamByName('year').AsInteger:= beforeYear;
          ParamByName('codLotacao').AsString:= codLotacao;
          Open;

          if(RowsAffected > 0)then //caso exista, o Uni_codigo � armazenada para passar � procedure de inser��o
            begin
              codUO:= FieldByName('uni_codigo').AsString;

              insertUO(codLotacao, codUO, year);
              Close;
            end;
        end;


end;


procedure TfrmEContas.cleanGrid;
var
ln: integer;

begin
  for ln := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Rows[ln].Clear;
    end;
end;

// Realiza a consulta por Lota��es sem associa��o
procedure TfrmEContas.consultaUO;
var
qry1, qry2: string;
year: string;
ln, qnt: integer;

begin
cleanGrid; //Lmpa o grid

//UOList:= TStringList.Create(); //Cria�ao da StringList para ser usado na compara��o de C�digos para as associa��es de UOs

year:= FormatDateTime('yyyy', DateTimePicker1.Date);

ln:= 1;
//Colunm, line - defini��o do cabe�alho do GRID
StringGrid1.Cells[0,0]:= 'COD Lota��o';
StringGrid1.Cells[1,0]:= 'Descri��o Lota��o';
StringGrid1.Cells[2,0]:= 'UND Or�ament�ria';

// Select para pegar apenas as UOs em falta
qry1:= 'SELECT DISTINCT l.codigo, l.nome, ld.uni_codigo ' +
    'FROM lotacao l ' +
    'LEFT JOIN lotacao_dotacao ld ON ld.codigo_lotacao = l.codigo AND ld.ano = ' + year +
    ' LEFT JOIN capa_variavel cv ON cv.codigo_lotacao = l.codigo ' +
        'WHERE cv.ano = ' + year + ' AND ld.uni_codigo IS NULL ' +// OR ld.uni_codigo = '''' ' +
        'order by l.codigo';

    with(DM.sqlUO)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry1);
        Open;
        FetchAll;

        qnt:= RecordCount;

        if(RowsAffected > 0)then //Havendo alguma UO em falta, � exibido uma mensagem
          begin // ...tamb�m mostra os labels e controles que estavam ocultos
            Application.MessageBox('H� registro(s) precisando de sua aten��o!',' iJEX | ATEN��O', MB_ICONWARNING + MB_OK);

            label4.Caption:= 'Unidades Or�ament�rias';
            label5.Visible:= true;
            label5.Caption:= 'H� ' + IntToStr(qnt) + ' registro(s) precisando de sua aten��o!';
            label5.Font.Color:= clYellow;
            label6.Visible:= true;
            SpeedButton3.Visible:= true;
            SpeedButton4.Visible:= true;

            StringGrid1.Visible:= true;
            // ...ent�o � refeito o SELECT pegando todas as UOs com e sem associa��o e carregada na StringGrid
            qry2:= 'SELECT DISTINCT l.codigo, l.nome, ld.uni_codigo ' +
              'FROM lotacao l ' +
              'LEFT JOIN lotacao_dotacao ld ON ld.codigo_lotacao = l.codigo AND ld.ano = ' + year +
              ' LEFT JOIN capa_variavel cv ON cv.codigo_lotacao = l.codigo ' +
                  'WHERE cv.ano = ' + year + //' AND ld.uni_codigo IS NULL OR ld.uni_codigo = '''' ' +
                  ' order by l.codigo';

            Close;
            SQL.Clear;
            SQL.Add(qry2);
            Open;
            FetchAll;

            StringGrid1.RowCount:= RecordCount; //Definindo o n� de linhas do Grid dinamicamente

            if(RowsAffected > 0)then
              begin
                while not(Eof) do
                  begin
                    StringGrid1.Cells[0,ln]:= FieldByName('codigo').AsString;
                    StringGrid1.Cells[1,ln]:= FieldByName('nome').AsString;
                    StringGrid1.Cells[2,ln]:= FieldByName('uni_codigo').AsString;
                    ln:= ln + 1;
                    Next;
                  end;
                  Close;
              end;

          end
          else
          begin //Se n�o houver nenhuma ocorr�ncia na compet�ncia selecionada, os elementos s�o escondidos
            label4.Caption:= 'Notifica��es e-Contas';
            label5.Visible:= false;
            label6.Visible:= false;
            StringGrid1.Visible:= false;
            SpeedButton3.Visible:= false;
            SpeedButton4.Visible:= false;
          end;
      end;

end;

procedure TfrmEContas.DateTimePicker1Change(Sender: TObject);
begin
G_Month:= FormatDateTime('MM', DateTimePicker1.Date);
G_Year:= FormatDateTime('yyyy', DateTimePicker1.Date);
label3.Visible:= false;

duplicationUO;

consultaUO;
end;

// Caso haja, faz a exclus�o de registros de UO duplicados
procedure TfrmEContas.delDuplication;
var
qry, year: string;

begin
year:= FormatDateTime('yyyy', DateTimePicker1.Date);

qry:= 'delete from lotacao_dotacao ld ' +
    'where ld.ano = ' + year + ' and ld.codigo_lotacao in(' +
        'SELECT ld.CODIGO_LOTACAO ' +
        'FROM LOTACAO_DOTACAO ld ' +
        'WHERE ld.ANO = ' + year +
        ' GROUP BY ld.CODIGO_LOTACAO ' +
        'HAVING COUNT(*) > 1)';

      with(DM.sqlDuplication)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          ExecSQL;

          if(RowsAffected > 0)then
            begin
              Application.MessageBox(Pchar('Corre��o de ' + inttostr(RowsAffected) + ' registro(s) realizado com sucesso!'),' iJEX | SUCESSO', MB_ICONEXCLAMATION + MB_OK);

              Close;
            end;
        end;

end;

// Realiza a consulta por registros de UO duplicados...
procedure TfrmEContas.duplicationUO;
var
qry, year: string;

begin
year:= FormatDateTime('yyyy', DateTimePicker1.Date);

qry:= 'SELECT ld.CODIGO_LOTACAO, COUNT(*) ' +
    'FROM LOTACAO_DOTACAO ld ' +
    'WHERE ld.ANO = ' + year +
    ' GROUP BY ld.CODIGO_LOTACAO ' +
    'HAVING COUNT(*) > 1';

    with(DM.sqlDuplication)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;

          // Caso haja registros duplicados, � chamado a Procedure delDuplication
          if(RowsAffected > 0)then
            begin
              Application.MessageBox('Foram encontrados registros de Lota��o duplicados e ser�o corrigidos.',' iJEX | ATEN��O', MB_ICONINFORMATION + MB_OK);

              //Exclui os registros duplicados
              delDuplication;
              Close;
            end;
        end;



end;

procedure TfrmEContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DM.sqlUO.Close;
action:= cafree;
end;

procedure TfrmEContas.FormShow(Sender: TObject);
begin
G_Year:= FormatDateTime('yyyy', DateTimePicker1.Date);
G_Month:= FormatDateTime('MM', DateTimePicker1.Date);

consultaUO;

end;

//Gera��o do arquivo FolhaDePagamento.json
procedure TfrmEContas.gerarAtoCessaoDisposicao;
var
qry: string;
jsonAtoCessaoDisposicao: TStringList;
count: integer;

begin
jsonAtoCessaoDisposicao:= TStringList.Create();
jsonAtoCessaoDisposicao.Add('[');

qry:= 'select f.cnpf, cv.matricula, ' +
      'case movtc.tal_codigo ' +
        'when 1 then ''OUT'' when 2 then ''DEC'' when 3 then ''DEC'' when 4 then ''OUT'' ' +
        'when 5 then ''OUT'' when 6 then ''OUT'' when 7 then ''OUT'' when 8 then ''OUT'' when 9 then ''OUT'' ' +
        'when 99 then ''OUT'' when 11 then ''DEC'' end tipo_ato, movtc.mtc_numero_ato as num_ato, ' +
        'movtc.mtc_data_publicacao as data_publicacao, '''' as Onus, ''N'' as DispEntPriv, '''' as CNPJCedente ' +
      'from funcionario f ' +
      'join capa_variavel cv on cv.matricula = f.codigo ' +
      'join funcionario_movtc movtc on movtc.matricula = f.codigo ' +
          'where cv.ano = ' + G_Year + ' and cv.mes = ' + G_Month;

      with(DM.sqlAtoCessaoDisp)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;

          count:= RecordCount;

          while not(Eof) do
            begin
              jsonAtoCessaoDisposicao.Add(
                '{"cpf":"' + strPadLeft(FieldByName('CNPF').AsString,11,'0') + '",' +
                '"matricula":"' + strPadLeft(FieldByName('MATRICULA').AsString,15,'0') + '",' +
                '"tpAto":"' + strPad(FieldByName('TIPO_ATO').AsString,3) + '",' +
                '"numero":"' + strPad(FieldByName('NUM_ATO').AsString,15) + '",' +
                '"dtAto":"' + toDate(FieldByName('DATA_PUBLICACAO').AsString) + '",' +
                '"onus":"' + strPad(FieldByName('ONUS').AsString,3) + '",' +
                '"disposicaoEntidadePrivada":"N",');
                if(count > 0)then
                  begin
                    jsonAtoCessaoDisposicao.Add('"cnpjCedenteCessionario":"' + strPad('0',14) + '"},');
                  end
                  else
                  begin
                    jsonAtoCessaoDisposicao.Add('"cnpjCedenteCessionario":"' + strPad('0',14) + '"}');
                  end;
              Next;
            end;
            jsonAtoCessaoDisposicao.Add(']');
            jsonAtoCessaoDisposicao.SaveToFile(Folder + '/AtoCessaoDisposicao.json');
            jsonAtoCessaoDisposicao.Free;
            Close;
        end;


end;

procedure TfrmEContas.gerarAtosAdmissaoFolha;
var
qry, firstDay, lastDay, colocacao, dtPublicacao, inscServidor, ordemJudicial, listAprov: string;
jsonAtosAdmissaoFolha: TStringList;
count: integer;

begin
firstDay:= '01.' + G_Month + '.' + G_Year; //primeiro dia de compet�ncia para DT_Admiss�o
lastDay:= FormatDateTime('dd.MM.yyyy', EndOfTheMonth(DateTimePicker1.Date)); //�ltimo dia da compet�ncia para DT_Admiss�o

jsonAtosAdmissaoFolha:= TStringList.Create();
jsonAtosAdmissaoFolha.Add('[');

qry:= 'SELECT distinct f.cnpf as cpf, fmtc.matricula as matricula, ' +
      'case fmtc.tal_codigo ' +
      'when 1 then ''LEI'' when 2 then ''DEC'' when 3 then ''DEC'' when 4 then ''POR'' ' +
      'when 5 then ''RES'' when 6 then ''RES'' when 7 then ''RES'' when 8 then ''RES'' when 9 then ''ATO'' ' +
      'when 99 then ''RES'' when 11 then ''DEC'' end tipo_ato, fmtc.mtc_numero_ato as num_ato, ' +
      'fmtc.mtc_data_publicacao as data_publicacao, fmtc.codigo_cargo as cod_cargo, ''1'' as colocacao, ' +
      'fmtc.mtc_numero_concurso as edital, s.data_publicacao as data_edital, ' +
      'f.codigo_formaingresso as tipo_selecao, fmtc.mtc_ctr_data_ini as inicio_contrato, fmtc.mtc_ctr_data_fim as final_contrato, ' +
      'ld.uni_codigo, fmtc.mtc_numero_inscricao as insc_servidor, ''N'' as ordem_judicial, ''AC'' as lista_aprov ' +
    'FROM FUNCIONARIO f ' +
          'join funcionario_movtc fmtc on fmtc.matricula = f.codigo ' +
          'join capa_variavel cv ON cv.matricula = f.codigo ' +
          'LEFT JOIN siga_concurso s ON s.numero = fmtc.mtc_numero_concurso ' +
          'join lotacao_dotacao ld on ld.codigo_lotacao = cv.codigo_lotacao and ld.ano = ''' + G_Year + ''' ' +
          'WHERE f.data_admissao between ''' + firstDay + ''' and ''' + lastDay + ''' and ' +
          'f.codigo_grupo_01 not in (''2'', ''3'', ''6'') and cv.ano = ' + G_Year;

      with(DM.sqlAtosAdmissao)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;

          count:= RecordCount;

          while not(Eof) do
            begin
              if(FieldByName('TIPO_SELECAO').AsString = '4')then
                begin
                  colocacao:= '000000';
                  dtPublicacao:= '00000000';
                  inscServidor:= '000000000000000';
                  ordemJudicial:= 'N';
                  listAprov:= '';
                end
                else
                begin
                  colocacao:= strPadLeft(FieldByName('COLOCACAO').AsString,6,'0');
                  dtPublicacao:= toDate(FieldByName('DATA_EDITAL').AsString);
                  inscServidor:= strPadLeft(FieldByName('INSC_SERVIDOR').AsString,15,'0');
                  ordemJudicial:= 'N';
                  listAprov:= FieldByName('LISTA_APROV').AsString;
                end;

              count:= count - 1;

              jsonAtosAdmissaoFolha.Add(
                '{"cpf":"' + strPad(FieldByName('CPF').AsString,11) + '",' +
                '"matricula":"' + strPad(FieldByName('MATRICULA').AsString,15) + '",' +
                '"tpAto":"' + strPad(FieldByName('TIPO_ATO').AsString,3) + '",' +
                '"numero":"' + strPad(FieldByName('NUM_ATO').AsString,15) + '",' +
                '"dtPublicacaoAto":"' + toDate(FieldByName('DATA_PUBLICACAO').AsString) + '",' +
                '"codUnicoIdentificacaoCargo":"' + strPad(FieldByName('COD_CARGO').AsString,20) + '",' +
                '"colocacao":"' + colocacao + '",' +
                '"edital":"' + strPad(FieldByName('EDITAL').AsString,20) + '",' +
                '"dtPublicacaoEdital":"' + dtPublicacao + '",' +
                '"tpSelecao":"' + strPadLeft(FieldByName('TIPO_SELECAO').AsString,2,'0') + '",' +
                '"dtInicioContrato":"' + toDate(FieldByName('INICIO_CONTRATO').AsString) + '",' +
                '"dtTerminoContrato":"' + toDate(FieldByName('FINAL_CONTRATO').AsString) + '",' +
                '"codUnidadeOrcamentariaIngresso":"' + strPad(FieldByName('UNI_CODIGO').AsString,6) + '",' +
                '"numInscricao":"' + strPadLeft(inscServidor,15,'0') + '",' +
                '"admissaoDecorrenteDeOrdemJudicial":"' + strPad(FieldByName('ORDEM_JUDICIAL').AsString,1) + '",' +
                '"listaConcorrencia":"' + strPad(listAprov,2) + '",' +
                '"professorUniversitario":"N",' +
                '"areaAtuacao":"' + strPad('',3) + '",' +
                '"nomeCurso":"' + strPad('',150) + '",' +
                '"nomeEscola":"' + strPad('',150) + '",' +
                '"contratoTemporarioProrrogado":"' + strPad('N',1) + '",' +
                '"dtTerminoContratoProrrogado":"00000000",');
                if(count > 0)then
                  begin
                    jsonAtosAdmissaoFolha.Add('"codUnicoTCE":"' + strPad('0',23) + '"},');
                  end
                  else
                  begin
                    jsonAtosAdmissaoFolha.Add('"codUnicoTCE":"' + strPad('0',23) + '"}');
                  end;
              Next;
            end;
            jsonAtosAdmissaoFolha.Add(']');
            jsonAtosAdmissaoFolha.SaveToFile(Folder + '/AtosAdmissaoFolha.json');
            jsonAtosAdmissaoFolha.Free;
            Close;
        end;

end;


procedure TfrmEContas.gerarBeneficiarioPensao;
var
//qry: string;
//jsonBeneficiarioPensao: TJSONObject;
jsonBeneficiarioPensao: TStringList;

begin
jsonBeneficiarioPensao:= TStringList.Create();
 {
qry:= 'select distinct ldt.uni_codigo as uo, f.cnpf as cpf_servidor, f.codigo as matricula_servidor, ' +
      'f.nome as nome_beneficiario, f.cnpf as cpf_beneficiario, f.nascimento as data_nascimento, ' +
      '100 as percentual_pensao, f.dtpublicacao as data_publicacao ' +
      'from funcionario f ' +
      'join capa_variavel cv on cv.matricula = f.codigo ' +
      'left join lotacao_dotacao ldt ON ldt.codigo_lotacao = f.codigo_lotacao ' +
      'where f.codigo_grupo_01 = 9 and cv.ano = ' + G_Year + ' and cv.mes = ' + G_Month;

    with(DM.sqlBeneficiario)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        while not(Eof) do
          begin
            jsonBeneficiarioPensao:= TJSONObject.Create;

            jsonBeneficiarioPensao.AddPair('codUnidadeOrcamentaria',strPad(FieldByName('UO').AsString,6));
            jsonBeneficiarioPensao.AddPair('cpdServidor',strPad(FieldByName('CPF_SERVIDOR').AsString,11));
            jsonBeneficiarioPensao.AddPair('matriculaServidor',strPadLeft(FieldByName('MATRICULA_SERVIDOR').AsString,15,'0'));
            jsonBeneficiarioPensao.AddPair('nomeBeneficiario',strPad(FieldByName('NOME_BENEFICIARIO').AsString,120));
            jsonBeneficiarioPensao.AddPair('cpfBeneficiario',strPad(FieldByName('CPF_BENEFICIARIO').AsString,11));
            jsonBeneficiarioPensao.AddPair('percentualPensao','100');
            jsonBeneficiarioPensao.AddPair('dtAto',toDate(FieldByName('DATA_PUBLICACAO').AsString));
            jsonBeneficiarioPensao.AddPair('categoriaParentesco',strPad('0',1));

            arquivo.Add(jsonBeneficiarioPensao.ToString);
            Next;
          end;

          jsonBeneficiarioPensao.DisposeOf;      }
          jsonBeneficiarioPensao.Add('[');
          jsonBeneficiarioPensao.Add(
          '"codUnidadeOrcamentaria":"",' +
          '"cpdServidor":"",' +
          '"matriculaServidor":"",' +
          '"nomeBeneficiario":"",' +
          '"cpfBeneficiario":"",' +
          '"percentualPensao":"",' +
          '"dtAto":' + '00000000,' +
          '"categoriaParentesco":""'
          );

          jsonBeneficiarioPensao.SaveToFile(Folder + '/BeneficiarioPensao.json');
          jsonBeneficiarioPensao.Free;
//          Close;
     // end;

end;

procedure TfrmEContas.gerarCargosPlano;
var
qry: string;
jsonCargosPlano: TStringList;
count: integer;

begin
jsonCargosPlano:= TStringList.Create();
jsonCargosPlano.Add('[');

qry:= 'SELECT l.numero_lei as dispositivo_criacao, l.data_ini_vigencia as data_vigencia, ' +
      'c.codigo as cod_cargo, c.nome as nome_cargo, c.vagas_ocupadas as numero_vagas, ' +
      'COALESCE(c.codigo_tipo, 1) as tipo_cargo ' +
      'from cargo c ' +
      'left join lei l on l.id = c.codigo_lei_criacao ' +
      'where c.vagas_ocupadas > 0';

      with(DM.sqlCargosPlano)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;

          count:= RecordCount;

          while not(Eof) do
            begin
              count:= count - 1;

              jsonCargosPlano.Add(
                '{"leiCargo":"' + strPad(FieldByName('DISPOSITIVO_CRIACAO').AsString,20) + '",' +
                '"dtVigencia":"' + toDate(FieldByName('DATA_VIGENCIA').AsString) + '",' +
                '"codCargo":"' + strPad(FieldByName('COD_CARGO').AsString,20) + '",' +
                '"nomeCargo":"' + strPad(FieldByName('NOME_CARGO').AsString,50) + '",' +
                '"numeroVagas":"' + strPadLeft(FieldByName('NUMERO_VAGAS').AsString,5,'0') + '",');
                if(count > 0)then
                  begin
                    jsonCargosPlano.Add('"tbCargoPlano":"' + strPadLeft(FieldByName('TIPO_CARGO').AsString,2,'0') + '"},');
                  end
                  else
                  begin
                    jsonCargosPlano.Add('"tbCargoPlano":"' + strPadLeft(FieldByName('TIPO_CARGO').AsString,2,'0') + '"}');
                  end;
              Next;
            end;
            jsonCargosPlano.Add(']');
            jsonCargosPlano.SaveToFile(Folder + '/CargosPlano.json');
            jsonCargosPlano.Free;
            Close;
        end;

end;

procedure TfrmEContas.gerarDependenteServidor;
var
qry, competencia: string;
jsonDependenteServidor: TStringList;
count: Integer;

begin
jsonDependenteServidor:= TStringList.Create();
jsonDependenteServidor.Add('[');

qry:= 'select f.cnpf, f.codigo, dep.cnpf as cpfDependente, dep.nome, dep.nascimento, ' +
      'dep.tipo, dep.virgencia, dep.data_cadastro ' +
    'from funcionario f ' +
    'join capa_variavel cv on cv.matricula = f.codigo ' +
    'join dependente dep on dep.codigo_fun = f.codigo ' +
    'where cv.ano = ' + G_Year + ' and cv.mes = ' + G_Month;

    with(DM.sqlDependenteServidor)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        count:= RecordCount;

        while not(Eof) do
          begin             //Tratamento de dados
            if(FieldByName('virgencia').AsString <> '')then
              begin
                competencia:= Copy(FieldByName('virgencia').AsString, 3);
                competencia:= competencia + Copy(FieldByName('virgencia').AsString, 1, 2);
              end;
                          //Fim do tratamento de dados

            count:= count - 1;

            jsonDependenteServidor.Add(
              '{"cpfServidor":"' + strPadLeft(FieldByName('CNPF').AsString,11,'0') + '",' +
              '"matriculaServidor":"' + strPadLeft(FieldByName('CODIGO').AsString,15,'0') + '",' +
              '"cpfDependente":"' + strPadLeft(FieldByName('CPFDEPENDENTE').AsString,11,'0') + '",' +
              '"nomeDependente":"' + strPad(FieldByName('NOME').AsString,50) + '",' +
              '"dtNascimentoDependente":"' + toDate(FieldByName('NASCIMENTO').AsString) + '",' +
              '"tbParentesco":"' + FieldByName('TIPO').AsString + '",' +
              '"competencia":"' + competencia + '",' +
              '"dtInicioDependencia":"' + toDate(FieldByName('DATA_CADASTRO').AsString) + '",');
              if(count > 0)then
                begin
                  jsonDependenteServidor.Add('"dtEncerramentoDependente":"00000000"},');
                end
                else
                begin
                  jsonDependenteServidor.Add('"dtEncerramentoDependente":"00000000"}');
                end;

            Next;
          end;
          jsonDependenteServidor.Add(']');
          jsonDependenteServidor.SaveToFile(Folder + '/DependenteServidor.json');
          jsonDependenteServidor.Free;
          Close;
      end;

end;

procedure TfrmEContas.gerarDetalheFolha;
var
qry: string;
jsonDetalheFolha: TStringList;
count: Integer;

begin
jsonDetalheFolha:= TStringList.Create();
jsonDetalheFolha.Add('[');

qry:= 'SELECT LDT.UNI_CODIGO||''.''||CV.ANO||''.''||TRIM(IIF(CV.MES<=9, ''0'', ''''))||CV.MES||''.''||TRIM(IIF(CV.SEQUENCIA<=9, ''0'', ''''))||CV.SEQUENCIA ' +
    'AS IDENTIFICADOR, COALESCE(FU.CNPF, '''') AS CPF, '''' AS CPFPENSIONISTA, ' +
    'CV.MATRICULA, V.PROVENTO AS EVENTO, V.VALOR AS VALOR_EVENTO ' +
    'FROM CAPA_VARIAVEL CV ' +
    'JOIN VARIAVEL V ON V.MATRICULA = CV.MATRICULA AND V.MES = CV.MES AND V.ANO = CV.ANO AND V.SEQUENCIA = CV.SEQUENCIA ' +
    'JOIN FUNCIONARIO FU ON FU.CODIGO = CV.MATRICULA ' +
    'JOIN LOTACAO_DOTACAO LDT ON LDT.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LDT.ANO = CV.ANO AND LDT.MES_INICIAL = ' +
                '(SELECT MAX(LD .MES_INICIAL) FROM LOTACAO_DOTACAO LD ' +
                'WHERE LD.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LD.ANO = CV.ANO AND LD.MES_INICIAL <= CV.MES) ' +
    'WHERE SUBSTRING(CV.CODIGO_CARGO FROM 1 FOR 2) <> ''99'' ' +
    'AND SUBSTRING(CV.CODIGO_LOTACAO FROM 1 FOR 2) <> ''99'' ' +
    'AND CV.ANO = ' + G_Year + ' AND CV.MES = ' + G_Month;

    with(DM.sqlDetalheFolha)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        count:= RecordCount;

        while not(Eof) do
          begin
            count:= count - 1;

            jsonDetalheFolha.Add(
              '{"codIdentificadorFolha":"' + strPadLeft(FieldByName('IDENTIFICADOR').AsString,17,'0') + '",' +
              '"cpfServidor":"' + strPadLeft(FieldByName('CPF').AsString,11,'0') + '",' +
              '"cpfPensionista":"' + strPadLeft(FieldByName('CPFPENSIONISTA').AsString,11,'0') + '",' +
              '"matriculaServidor":"' + strPad(FieldByName('MATRICULA').AsString,15) + '",' +
              '"codEventoFP":"' + strPad(FieldByName('EVENTO').AsString,10) + '",');
              if(count > 0)then
                begin
                  jsonDetalheFolha.Add('"vlEventoFP":"' + strPadLeft(StringReplace(FieldByName('VALOR_EVENTO').AsString,',','.',[rfReplaceAll]), 16,'0') + '"},');
                end
                else
                begin
                  jsonDetalheFolha.Add('"vlEventoFP":"' + strPadLeft(StringReplace(FieldByName('VALOR_EVENTO').AsString,',','.',[rfReplaceAll]),16,'0') + '"}');
                end;

            Next;
          end;

          jsonDetalheFolha.Add(']');
          jsonDetalheFolha.SaveToFile(Folder + '/DetalheFolha.json');
          jsonDetalheFolha.Free;
          Close;
      end;

end;

procedure TfrmEContas.gerarEventosFolha;
var
qry: string;
jsonEventosFolha: TStringList;
count: integer;

begin
jsonEventosFolha:= TStringList.Create();
jsonEventosFolha.Add('[');

qry:= 'SELECT LDT.UNI_CODIGO AS UO, V.PROVENTO AS EVENTO, P.NOME AS NOME, IIF(P.SINAL = ''R'', 1, 2) AS TIPO_EVENTO, ''R'' as CLASSIFICACAO,' +
      ' ''N'' AS ABATE_TETO, P.PREVIDENCIA AS BASE_INSS, P.PREVIDENCIA AS BASE_PREV_PROPRIA, P.IR AS BASE_IR ' +
      'FROM CAPA_VARIAVEL CV ' +
          'JOIN VARIAVEL V ON V.MATRICULA = CV.MATRICULA AND V.MES = CV.MES AND V.ANO = CV.ANO AND V.SEQUENCIA = CV.SEQUENCIA ' +
          'JOIN PROVENTO P ON P.CODIGO = V.PROVENTO ' +
          'JOIN LOTACAO_DOTACAO LDT ON LDT.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LDT.ANO = CV.ANO AND LDT.MES_INICIAL = ' +
      '(SELECT MAX(LD.MES_INICIAL) FROM LOTACAO_DOTACAO LD WHERE LD.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LD.ANO = CV.ANO AND LD.MES_INICIAL <= CV.MES) ' +
      'WHERE SUBSTRING(CV.CODIGO_CARGO FROM 1 FOR 2) <> ''99'' AND SUBSTRING(CV.CODIGO_LOTACAO FROM 1 FOR 2) <> ''99'' AND CV.ANO = ' + G_Year + ' AND CV.MES = ' + G_Month +
      ' GROUP BY LDT.UNI_CODIGO, V.PROVENTO, P.NOME, P.SINAL, P.PREVIDENCIA, P.IR';

      with(DM.sqlEventosFolha)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;

          count:= RecordCount;

          while not(Eof) do
            begin
              count:= count - 1;

              jsonEventosFolha.Add(
              '{"codUnidadeOrcamentaria":"' + strPad(FieldByName('UO').AsString,6) + '",' +
              '"codEventoFP":"' + strPad(FieldByName('EVENTO').AsString,10) + '",' +
              '"desEventoFP":"' + strPad(FieldByName('NOME').AsString,60) + '",' +
              '"codTipoEventoFP":"' + strPad(FieldByName('TIPO_EVENTO').AsString,1) + '",' +
              '"codTipoVerba":"' + strPad(FieldByName('CLASSIFICACAO').AsString,1) + '",' +
              '"abateTeto":"' + strPad(FieldByName('ABATE_TETO').AsString,1) + '",' +
              '"compoeBaseINSS":"' + strPad(FieldByName('BASE_INSS').AsString,1) + '",' +
              '"compoeBasePrevPropria":"' + strPad(FieldByName('BASE_PREV_PROPRIA').AsString,1) + '",');
              if(count > 0)then
                begin
                  jsonEventosFolha.Add('"compoeBaseIRRF":"' + strPad(FieldByName('BASE_IR').AsString,1) + '"},');
                end
                else
                begin
                  jsonEventosFolha.Add('"compoeBaseIRRF":"' + strPad(FieldByName('BASE_IR').AsString,1) + '"}');
                end;

              Next;
            end;

            jsonEventosFolha.Add(']');
            jsonEventosFolha.SaveToFile(Folder + '/EventosFolha.json');
            jsonEventosFolha.Free;
            Close;
        end;


end;

procedure TfrmEContas.gerarFolhaDePagamento;
var
qry: string;
count: integer;
jsonFolhaDePagamento: TStringList;

begin
jsonFolhaDePagamento:= TStringList.Create();
jsonFolhaDePagamento.Add('[');

qry:= 'SELECT LDT.UNI_CODIGO||''.''||CV.ANO||''.''||TRIM(IIF(CV.MES<=9, ''0'', ''''))||CV.MES||''.''||TRIM(IIF(CV.SEQUENCIA<=9, ''0'', ''''))||CV.SEQUENCIA AS IDENTIFICADOR, ' +
      'LDT.UNI_CODIGO AS UO, ' +
      '(SELECT DTA_FINAL FROM FIRST_LAST_DAY(CV.MES, CV.ANO)) AS DATAFOLHA, ' +
      'CASE CV.SEQUENCIA WHEN 0 THEN ''M'' WHEN 13 THEN ''D'' ELSE ''E'' END  AS TIPO, CV.ANO, CV.MES, ' +
      'CV.SEQUENCIA, COUNT(CV.MATRICULA) AS NUMSERVIDOR, ' +
      'SUM(CV.DEP_IR) AS DEP_IRRF, SUM(CV.BASE_IR) AS BASE_IR, ' +
      'SUM(CASE WHEN CV.TIPO_PREV = 1 THEN CV.BASE_INSS_PATRONAL ELSE 0 END ) AS BASE_INSS_PATRONAL, ' +
      'SUM(CASE WHEN CV.TIPO_PREV = 1 THEN ' +
      'CAST((CV.BASE_INSS_PATRONAL * (SELECT COALESCE(CF.PERCENTUAL_CE,20) + ( COALESCE(CF.SEFIP_SAT,0) * COALESCE(TM.ALIQ_FAP,1)) ' +
          'FROM  CONFIG CF, TABELA_MENSAL TM WHERE TM.ANO=CV.ANO AND TM.MES=CV.MES ) / 100) AS NUMERIC(15,2)) ELSE 0 END) AS DEVIDO_INSS_PATRONAL, ' +
          'SUM(CASE WHEN CV.TIPO_PREV = 1 THEN CV.VALOR_INSS ELSE 0 END ) AS DEVIDO_INSS_SEGURADO, ' +
          'SUM(CASE WHEN CV.TIPO_PREV = 3 THEN CV.BASE_INSS_PATRONAL ELSE 0 END) AS BASE_PROPRIA_PATRONAL, ' +
          'SUM(CASE WHEN CV.TIPO_PREV = 3 THEN CAST((CV.BASE_INSS_PATRONAL * (SELECT COALESCE(CF.PERCENTUAL_PM,0) FROM  CONFIG CF ) / 100) AS NUMERIC(15,2)) ELSE 0 END) AS DEVIDO_PROPRIA_PATRONAL, ' +
          'SUM(CASE WHEN CV.TIPO_PREV = 3 THEN CV.VALOR_INSS ELSE 0 END) AS DEVIDO_PROPRIA_SEGURADO, ' +
          'CV.ANO||TRIM(IIF(CV.MES<=9, ''0'', ''''))||CV.MES AS COMPETENCIA, ' +
          'CASE CV.codigo_grupo_01 when 4 THEN ''AP'' WHEN 8 then ''AP'' WHEN 9 THEN ''AP'' else ''AT'' end AS TIPO_FOLHA ' +
          'FROM CAPA_VARIAVEL CV ' +
      'JOIN LOTACAO_DOTACAO LDT ON LDT.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LDT.ANO = CV.ANO AND ' +
      'LDT.MES_INICIAL = (SELECT MAX(LD .MES_INICIAL) FROM LOTACAO_DOTACAO LD WHERE LD.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LD.ANO = CV.ANO AND LD.MES_INICIAL <= CV.MES) ' +
      'WHERE SUBSTRING(CV.CODIGO_CARGO FROM 1 FOR 2) <> ''99'' ' +
      'AND SUBSTRING(CV.CODIGO_LOTACAO FROM 1 FOR 2) <> ''99'' ' +
      'AND CV.ANO = ' + G_Year + ' AND CV.MES = ' + G_Month +
      ' GROUP BY LDT.UNI_CODIGO,CV.ANO,CV.MES,CV.SEQUENCIA,TIPO_FOLHA';

      with(DM.sqlFolhaPagamento)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          Open;
          FetchAll;
          First;

          count:= RecordCount;

          while not(Eof) do
            begin
              count:= count - 1;

              jsonFolhaDePagamento.Add(
                '{"codIdentificadorFolha":"' + strPadLeft(FieldByName('IDENTIFICADOR').AsString,17,'0') + '",' +
                '"codUnidadeOrcamentaria":"' + strPadLeft(FieldByName('UO').AsString,6,'0') + '",' +
                '"dtProcessamento":' + toDate(FieldByName('DATAFOLHA').AsString) + ',' +
                '"codTipoPagamentoFP":"' + FieldByName('TIPO').AsString + '",' +
                '"qtServidores":"' + strPadLeft(FieldByName('NUMSERVIDOR').AsString,6,'0') + '",' +
                '"qtDependentesIRRF":"' + strPadLeft(FieldByName('DEP_IRRF').AsString,6,'0') + '",' +
                '"vlBaseIRRF":"' + strPadLeft(StringReplace(FieldByName('BASE_IR').AsString, ',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlBaseINSSPatronal":"' + strPadLeft(StringReplace(FieldByName('BASE_INSS_PATRONAL').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlDevidoINSSPatronal":"' + strPadLeft(StringReplace(FieldByName('DEVIDO_INSS_PATRONAL').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlDevidoINSSSegurado":"' + strPadLeft(StringReplace(FieldByName('DEVIDO_INSS_SEGURADO').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlBasePrevPropriaPatronal":"' + strPadLeft(StringReplace(FieldByName('BASE_PROPRIA_PATRONAL').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlDevidoPrevPropriaPatronal":"' + strPadLeft(StringReplace(FieldByName('DEVIDO_PROPRIA_PATRONAL').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlDevidoPrevPropriaPatronalFundoFinanceiro":"' + strPadLeft('0',16,'0') + '",' +
                '"vlDevidoPrevPropriaPatronalFundoPrevidenciario":"' + strPadLeft('0',16,'0') + '",' +
                '"vlDevidoPrevPropriaSegurado":"' + strPadLeft(StringReplace(FieldByName('DEVIDO_PROPRIA_SEGURADO').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
                '"vlDevidoPrevPropriaSeguradoFundoFinanceiro":"' + strPadLeft('0',16,'0') + '",' +
                '"vlDevidoPrevPropriaSeguradoFundoPrevidenciario":"' + strPadLeft('0',16,'0') + '",' +
                '"competencia":' + FieldByName('COMPETENCIA').AsString + ',');
                //Verifica se � o �ltimo registro
                if(count > 0)then     //...caso n�o seja, � adicionado a v�rgula separando e dando sequ�ncia � cadeia de dados...
                  begin
                    jsonFolhaDePagamento.Add('"codTipoFolha":"' + FieldByName('TIPO_FOLHA').AsString + '"},');
                  end
                  else
                  begin              //...caso seja, o �ltimo dado � terminado sem v�rgula
                    jsonFolhaDePagamento.Add('"codTipoFolha":"' + FieldByName('TIPO_FOLHA').AsString + '"}');
                  end;
              Next;

            end;
            jsonFolhaDePagamento.Add(']');
            jsonFolhaDePagamento.SaveToFile(Folder + '/FolhaDePagamento.json');
            jsonFolhaDePagamento.Free;
            Close;
        end;
      
end;

//Ger��o do arquivo FolhaDePagamentoServidor.json
procedure TfrmEContas.gerarFolhaDePagamentoServidor;
var
qry: string;
count: integer;
JsonFolhaPagamentoServidor: TStringList;

begin
JsonFolhaPagamentoServidor:= TStringList.Create();
JsonFolhaPagamentoServidor.Add('[');

qry:= 'SELECT LDT.UNI_CODIGO||''.''||CV.ANO||''.''||TRIM(IIF(CV.MES<=9, ''0'', ''''))||CV.MES||''.''||TRIM(IIF(CV.SEQUENCIA<=9, ''0'', ''''))||CV.SEQUENCIA ' +
      'AS IDENTIFICADOR, COALESCE(FU.CNPF, '''') AS CPF, CV.MATRICULA,(SELECT (CASE WHEN CODIGO_GRUPO_01 = ''9'' THEN ''PS'' WHEN CODIGO_GRUPO_01 = ''8'' THEN ''PS'' ELSE ''ER'' END) AS SITUACAOSERVIDOR ' +
      'FROM FUNCIONARIO WHERE CODIGO = CV.MATRICULA) AS SITUACAOSERVIDOR, FU.CODIGO_GRUPO_01, FU.BENEFICIO_DTINICIO, ' +
      'CASE FU.FORMACAOTECNICA1 WHEN 10 THEN 10 WHEN 40 THEN 40 WHEN 60 THEN 60 WHEN 99 THEN 99 ELSE ''99'' END FONTE_RECURSO, ' +
      '(select v.referencia from variavel v where v.ANO = cv.ano and v.mes = cv.mes and v.sequencia = cv.sequencia and v.MATRICULA = cv.matricula and v.provento = ''501'') as faltas, ' +
'SUM(CV.TOTAL_PROVENTOS) AS TOTAL_REMUNERACAO, ' +
'SUM(CV.TOTAL_DESCONTOS) as TOTAL_DESCONTOS, ' +
    'CASE ' +
       'WHEN (SUM(CV.total_proventos - CV.total_descontos) <= 0) THEN 0.00 ' +
       'ELSE (SUM(CV.total_proventos - CV.total_descontos)) END AS TOTAL_LIQUIDO, cv.salario_base as SAL_BASE ' +
'FROM CAPA_VARIAVEL CV ' +
    'JOIN FUNCIONARIO FU ON FU.CODIGO = CV.MATRICULA ' +
    'JOIN LOTACAO_DOTACAO LDT ON LDT.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LDT.ANO = CV.ANO AND ' +
    'LDT.MES_INICIAL = (SELECT MAX(LD.MES_INICIAL) FROM LOTACAO_DOTACAO LD WHERE LD.CODIGO_LOTACAO = CV.CODIGO_LOTACAO AND LD.ANO = CV.ANO AND LD.MES_INICIAL <= CV.MES) ' +
    'WHERE SUBSTRING(CV.CODIGO_CARGO FROM 1 FOR 2) <> ''99'' ' +
    'AND SUBSTRING(CV.CODIGO_LOTACAO FROM 1 FOR 2) <> ''99'' ' +
    'AND CV.ANO = ' + G_Year + ' AND CV.MES = ' + G_Month + //*and cv.matricula = 737 /*and cv.afastado = 'N'*/
    'GROUP BY LDT.UNI_CODIGO, CV.ANO,CV.MES,CV.SEQUENCIA, CV.MATRICULA, FU.CNPF, FU.CODIGO_GRUPO_01, FU.FORMACAOTECNICA1, cv.afastado, FU.BENEFICIO_DTINICIO, cv.salario_base ' +
    'order by CV.MATRICULA desc';

    with(DM.sqlFolhaPagamentoServidor)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        count:= RecordCount;

        while not(Eof) do
          begin
            count:= count - 1;

            JsonFolhaPagamentoServidor.Add(
              '{"codIdentificadorFolha":"' + strPadLeft(FieldByName('IDENTIFICADOR').AsString,17,'0') + '",' +
              '"cpfServidor":"' + strPadLeft(FieldByName('CPF').AsString,11,'0') + '",' +
              '"matriculaServidor":"' + strPadLeft(FieldByName('MATRICULA').AsString,15,'0') + '",' +
              '"codSituacaoServidor":"' + FieldByName('SITUACAOSERVIDOR').AsString + '",' +
              '"vlRemuneracaoBruta":"' + strPadLeft(StringReplace(FieldByName('TOTAL_REMUNERACAO').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
              '"vlTotalDeducoes":"' + strPadLeft(StringReplace(FieldByName('TOTAL_DESCONTOS').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
              '"vlRemuneracaoLiquida":"' + strPadLeft(StringReplace(FieldByName('TOTAL_LIQUIDO').AsString,',','.',[rfReplaceAll]),16,'0') + '",' +
              '"dtInicioLicenca":"' + strPadLeft('0',8,'0') + '",' +
              '"codServidorCedidoRelotado":"NA",' +
              '"codFonteRecursoFP":"' + strPadLeft(FieldByName('FONTE_RECURSO').AsString,2,'0') + '",' +
              '"totalFaltas":"' + strPadLeft(FieldByName('FALTAS').AsString,2,'0') + '",' +
              '"vlVencimentoBase":"' + strPadLeft(StringReplace(FieldByName('SAL_BASE').AsString,',','.',[rfReplaceAll]),16,'0') + '",');
              if(count > 0)then
                begin
                  JsonFolhaPagamentoServidor.Add('"cnpjCedenteCessionarioLotacao":"' + strPadLeft('0',14,'0') + '"},');
                end
                else
                begin
                  JsonFolhaPagamentoServidor.Add('"cnpjCedenteCessionarioLotacao":"' + strPadLeft('0',14,'0') + '"}');
                end;

            Next;
          end;
          JsonFolhaPagamentoServidor.Add(']');
          JsonFolhaPagamentoServidor.SaveToFile(Folder + '/FolhaDePagamentoServidor.json');
          JsonFolhaPagamentoServidor.Free;
          Close;
      end;

end;

// gera��o do arquivo Servidor.json
procedure TfrmEContas.gerarServidor;
var
qry, firstDay, lastDay, dtObito, prof, prosaude, sexo, comissionado, comPosse, comCargo: string;
jsonServidor: TStringList;
count: integer;

begin
jsonServidor:= TStringList.Create();
jsonServidor.Add('[');

firstDay:= '01.' + G_Month + '.' + G_Year; //primeiro dia de compet�ncia para DT_Admiss�o
lastDay:= FormatDateTime('dd.MM.yyyy', EndOfTheMonth(DateTimePicker1.Date)); //�ltimo dia da compet�ncia para DT_Admiss�o

qry:= 'select distinct F.CNPF, F.CODIGO AS MATRICULA, ' +
//Grau de instrucao
'CASE F.GRAU_INSTRUCAO WHEN 1 THEN ''01'' WHEN 2 THEN ''01'' WHEN 3 THEN ''01'' WHEN 4 THEN ''01'' ' +
  'WHEN 5 THEN ''02'' WHEN 6 THEN ''03'' WHEN 7 THEN ''04'' WHEN 8 THEN ''05'' WHEN 9 THEN ''06'' ' +
  'WHEN 10 THEN ''09'' WHEN 11 THEN ''10'' WHEN 12 THEN ''12'' END GRAU_INSTRUCAO, ' +
'F.NOME, F.MAE, F.PAI, F.NASCIMENTO, F.DATA_ADMISSAO, H.DATA AS DTDESLIGAMENTO, F.BENEFICIO_DTINICIO AS DTAPOSENTADORIA, F.PIS_PASEP, F.CODIGO_CARGO, ' +
'case ' +
    'when (c.codigo_cbo BETWEEN 231105 AND 239435) then ''1'' ' + //*professor*/
    'when ((c.codigo_cbo BETWEEN 201105 AND 214935) or (c.codigo_cbo BETWEEN 251105 AND 252215) or ( c.codigo_cbo BETWEEN 300105 AND 353225)) then ''2'' ' + //*tecnico, cientifico*/
    'when (c.codigo_cbo BETWEEN 221105 AND 225350) then ''3'' ' + //*saude*/
    'when (c.codigo_cbo = 111120 ) then ''4'' ' + //*vereador*/
    'when ((c.codigo_cbo = 111255) or (c.codigo_cbo = 111250) ) then ''5'' ' + //*prefeito - vice*/
    'when (c.codigo_cbo BETWEEN 111105 AND 111510) then ''6'' ' +
    'when ((c.codigo_cbo BETWEEN 113005 AND 142710) or (c.codigo_cbo BETWEEN 215105 AND 215315) or (c.codigo_cbo BETWEEN 241005 AND 242410) or ' +
    '(c.codigo_cbo BETWEEN 252305 AND 271110) or (c.codigo_cbo BETWEEN 353230 AND 992225) ) then ''7'' ' +
    'when ((c.codigo_cbo > 0) and (c.codigo_cbo <= 039999)) then ''8'' ' + //*militar*/
  'else ''7'' end tipo_cargo, L.CODIGO AS CODIGO_LOTACAO, C.NOME AS NOME_CARGO, F.EMAIL, ' +
'case ' +
    'F.CODIGO_GRUPO_01 WHEN ''1'' then ''ES'' WHEN ''3'' then ''CO'' WHEN ''6'' then ''AP'' ' +
                      'WHEN ''2'' then ''CE'' WHEN ''9'' THEN ''OU'' WHEN ''8'' THEN ''OU'' WHEN ''A'' THEN ''OU'' WHEN ''B'' THEN ''OU'' WHEN ''C'' THEN ''OU'' ELSE ''TE'' END AS TIPO_VINCULO, ' +
    'C.HORAS_SEMANAIS, H.AFA_RET, H.CODIGO_TAB_AFAS, H.data, L.NOME AS NOME_LOTACAO, E.cnpj AS CNPJUG, F.CODIGO_GRUPO_01 AS GRUPO1, F.CODIGO_GRUPO_02 AS GRUPO2, F.SEXO ' +
'from CAPA_VARIAVEL CV JOIN EMPRESA E ON 1 = 1 ' +
    'JOIN FUNCIONARIO F ON F.CODIGO=CV.MATRICULA ' +
    'JOIN CARGO C ON C.CODIGO=F.CODIGO_CARGO ' +
    'JOIN LOTACAO L ON L.CODIGO=CV.CODIGO_LOTACAO AND L.NIVEL=3 ' +
    'LEFT JOIN HISTORICO H ON H.MATRICULA = F.CODIGO AND H.CODIGO_TAB_AFAS IN(3,10,12,13,16) ' +
    'AND H.DATA=(SELECT MAX(H1.DATA) ' +
    'FROM HISTORICO H1 ' +
    'WHERE H1.MATRICULA=H.MATRICULA AND H1.AFA_RET=''A'') ' +
    'WHERE CV.ANO = ' + G_Year + ' AND CV.MES = ' + G_Month +

    ' union ' +

    //* SERVIDOR SEM CAPA VARI�VEL */

'select distinct F.CNPF, F.CODIGO AS MATRICULA, ' +
//* Grau de instru��o >>*/
'CASE F.GRAU_INSTRUCAO WHEN 1 THEN ''01'' WHEN 2 THEN ''01'' WHEN 3 THEN ''01'' WHEN 4 THEN ''01'' ' +
  'WHEN 5 THEN ''02'' WHEN 6 THEN ''03'' WHEN 7 THEN ''04'' WHEN 8 THEN ''05'' WHEN 9 THEN ''06'' ' +
  'WHEN 10 THEN ''09'' WHEN 11 THEN ''10'' WHEN 12 THEN ''12'' END GRAU_INSTRUCAO, ' +
  'F.NOME, F.MAE, F.PAI,  F.NASCIMENTO, F.DATA_ADMISSAO, H.DATA AS DTDESLIGAMENTO, F.BENEFICIO_DTINICIO AS DTAPOSENTADORIA, F.PIS_PASEP, F.CODIGO_CARGO, ' +
   'case ' +
    'when (c.codigo_cbo BETWEEN 231105 AND 239435) then ''1'' ' + //*professor*/
    'when ((c.codigo_cbo BETWEEN 201105 AND 214935) or (c.codigo_cbo BETWEEN 251105 AND 252215) or ( c.codigo_cbo BETWEEN 300105 AND 353225)) then ''2'' ' + //*tecnico, cientifico*/
    'when (c.codigo_cbo BETWEEN 221105 AND 225350) then ''3'' ' + //*saude*/
    'when (c.codigo_cbo = 111120 ) then ''4'' ' +  //*vereador*/
    'when ((c.codigo_cbo = 111255) or (c.codigo_cbo = 111250) ) then ''5'' ' +   //*prefeito - vice*/
    'when (c.codigo_cbo BETWEEN 111105 AND 111510) then ''6'' ' +
    'when ((c.codigo_cbo BETWEEN 113005 AND 142710) or (c.codigo_cbo BETWEEN 215105 AND 215315) or (c.codigo_cbo BETWEEN 241005 AND 242410) or (c.codigo_cbo BETWEEN 252305 AND 271110) or ' +
    '(c.codigo_cbo BETWEEN 353230 AND 992225) ) then ''7'' when ((c.codigo_cbo > 0) and (c.codigo_cbo <= 039999)) then ''8'' ' + //*militar*/
    'else ''7'' end tipo_cargo, L.CODIGO AS CODIGO_LOTACAO, C.NOME AS NOME_CARGO, F.EMAIL, ' +
    'case F.CODIGO_GRUPO_01 WHEN ''1'' then ''ES'' WHEN ''3'' then ''CO'' WHEN ''6'' then ''AP'' WHEN ''2'' then ''CE'' WHEN ''A'' THEN ''TE'' WHEN ''B'' THEN ''TE'' WHEN ''C'' THEN ''TE'' ' +
        'ELSE ''TE'' END AS TIPO_VINCULO, C.HORAS_SEMANAIS, H.AFA_RET, H.CODIGO_TAB_AFAS, H.data, L.NOME AS NOME_LOTACAO, E.cnpj AS CNPJUG, F.CODIGO_GRUPO_01 AS GRUPO1, F.CODIGO_GRUPO_02 AS GRUPO2, F.SEXO ' +
'from FUNCIONARIO F JOIN EMPRESA E ON 1 = 1 ' +
'JOIN CARGO C ON C.CODIGO=F.CODIGO_CARGO ' +
'JOIN LOTACAO L ON L.CODIGO = F.CODIGO_LOTACAO AND L.NIVEL=3 ' +
    'LEFT JOIN HISTORICO H ON H.MATRICULA=F.CODIGO AND H.CODIGO_TAB_AFAS IN(3,10,12,13,16) ' +
    'AND H.DATA=(SELECT MAX(H1.DATA) ' +
    'FROM HISTORICO H1 ' +
    'WHERE H1.MATRICULA=H.MATRICULA AND H1.AFA_RET=''A'') ' +
    'WHERE F.data_admissao between ''' + firstDay + ''' and ''' + lastDay + ''' and f.codigo not in ' +
    '(select cv.matricula from capa_variavel cv where cv.mes = ''' + G_Month + ''' and cv.ano = ''' + G_Year + ''' and cv.sequencia = 0) ' +
    'and f.codigo_grupo_01 not in (''2'', ''3'', ''6'')';

    with(DM.sqlServidor)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        Open;
        FetchAll;

        count:= RecordCount;

        while not(Eof) do
          begin           //Tratamento de dados
            if(FieldByName('GRUPO1').AsString = '3')then
              begin
                comissionado:= 'S';
                comPosse:= toDate(FieldByName('DATA_ADMISSAO').AsString);
                comCargo:= FieldByName('CODIGO_CARGO').AsString;
              end
              else
              begin
                comissionado:= 'N';
                comPosse:= '00000000';
                comCargo:= '';
              end;

            if(FieldByName('CODIGO_TAB_AFAS').AsString = '3')then
              begin
                dtObito:= toDate(FieldByName('DATA').AsString);
              end
              else
              begin
                dtObito:= '00000000';
              end;

            if(FieldByName('TIPO_CARGO').AsString = '1')then
              begin
                prof:= 'S';
              end
              else
              begin
                prof:= 'N';
              end;

            if(FieldByName('TIPO_CARGO').AsString = '3')then
              begin
                prosaude:= 'S';
              end
              else
              begin
                prosaude:= 'N';
              end;

            if(FieldByName('SEXO').AsString = 'F')then
              begin
                sexo:= 'FE';
              end
              else
              begin
                sexo:= 'MA';
              end;
                        //Fim do tratamento de dados
            count:= count - 1;

            jsonServidor.Add(
              '{"cpf":"' + strPadLeft(FieldByName('CNPF').AsString,11,'0') + '",' +
              '"matricula":"' + strPadLeft(FieldByName('MATRICULA').AsString,15,'0') + '",' +
              '"nome":"' + strPad(FieldByName('NOME').AsString,120) + '",' +
              '"nomeMae":"' + strPad(FieldByName('MAE').AsString,120) + '",' +
              '"nomePai":"' + strPad(FieldByName('PAI').AsString,120) + '",' +
              '"dtNascimento":"' + toDate(FieldByName('NASCIMENTO').AsString) + '",' +
              '"dtAdmissao":"' + toDate(FieldByName('DATA_ADMISSAO').AsString) + '",' +
              '"dtDesligamento":"' + toDate(FieldByName('DTDESLIGAMENTO').AsString) + '",' +
              '"dtAposentadoria":"' + toDate(FieldByName('DTAPOSENTADORIA').AsString) + '",' +
              '"numPISPASEP":"' + strPadLeft(FieldByName('PIS_PASEP').AsString,15,'0') + '",' +
              '"codCargo":"' + strPad(FieldByName('CODIGO_CARGO').AsString,20) + '",' +
              '"codTipoCargoFP":"' + strPad(FieldByName('TIPO_CARGO').AsString,1) + '",' +
              '"nomeOcupacao":"' + strPad(removeCharSpecials(FieldByName('NOME_CARGO').AsString),120) + '",' +
              '"codLotacao":"' + strPad(FieldByName('CODIGO_LOTACAO').AsString,30) + '",' +
              '"nomeLotacao":"' + strPad(StringReplace(FieldByName('NOME_LOTACAO').AsString,'�','',[rfReplaceAll]),120) + '",' +
              '"codTipoVinculoFP":"' + strPad(FieldByName('TIPO_VINCULO').AsString,2) + '",' +
              '"cargaHoraria":"' + strPadLeft(FieldByName('HORAS_SEMANAIS').AsString,2,'0') + '",' +
              '"dedicacaoExclusiva":"N",' +
              '"codTipoRegistroCadastralFP":"1",' +
              '"dtRegistroCadastral":"' + toDate(FieldByName('DATA_ADMISSAO').AsString) + '",' +
              '"cnpjLotacao":"' + strPadLeft(FieldByName('CNPJUG').AsString,14,'0') + '",' +
              '"servidorEfetivoCargoComissionado":"' + comissionado + '",' +
              '"dtAdmissaoCargoComissionado":"' + comPosse + '",' +
              '"codCargoComissionado":"' + strPadLeft(comCargo,20,'0') + '",' +
              '"codNivelInstrucaoFP":"' + strPad(FieldByName('GRAU_INSTRUCAO').AsString,2) + '",' +
              '"email":"' + strPad(FieldByName('EMAIL').AsString,60) + '",' +
              '"dtObito":"' + dtObito + '",' +
              '"professor":"' + prof + '",' +
              '"profissionalSaude":"' + prosaude + '",');
              if(count > 0)then
                begin
                  jsonServidor.Add('"sexo":"' + sexo + '"},');
                end
                else
                begin
                  jsonServidor.Add('"sexo":"' + sexo + '"}');
                end;

            Next;
          end;

          jsonServidor.Add(']');
          jsonServidor.SaveToFile(Folder + '/Servidor.json');
          jsonServidor.Free;
          Close;
      end;

end;

//Faz a inser��o da lota��o associando a UO na compet�ncia atual
procedure TfrmEContas.insertUO(codLotacao, codUO, year: string);
var
qry: string;

begin
qry:= 'insert into lotacao_dotacao values(' +
      ':codLotacao, :year, 1, :codUO, null, null, null, null)';

      with(DM.sqlInsertUO)do
        begin
          Close;
          SQL.Clear;
          SQL.Add(qry);
          ParamByName('codLotacao').AsString:= codLotacao;
          ParamByName('year').AsString:= year;
          ParamByName('codUO').AsString:= codUO;

          try
            ExecSQL;
            Close;
          Except on E: Exception do
            begin
              ShowMessage(E.Message);
            end;

          end;

        end;


end;

function TfrmEContas.removeCharSpecials(val: string): string;
begin
val:= StringReplace(val,'�','',[rfReplaceAll]);
val:= StringReplace(val,'�','',[rfReplaceAll]);
result:= val;
end;

procedure TfrmEContas.SpeedButton1Click(Sender: TObject);
begin
self.Close;
end;

procedure TfrmEContas.SpeedButton2Click(Sender: TObject);
var
inst, month, year: string;

begin
label3.Visible:= true;
label3.Caption:= 'Gerando arquivos. Aguarde...';
label7.Visible:= true;
label7.Caption:= '';

month:= FormatDateTime('MM', DateTimePicker1.Date);
year:= FormatDateTime('yyyy', DateTimePicker1.Date);
inst:= frmMain.inst;
SaveDialog1.FileName:= 'eContas ' + StringReplace(inst,' ',EmptyStr,[rfReplaceAll]);

  if(SaveDialog1.Execute())then
    begin
      Folder:= SaveDialog1.FileName + ' - ' + year + '-' + month;
      if not(DirectoryExists(Folder)) then
        begin
          MkDir(Folder);
        end;

        Gauge1.MinValue:= 0;
        Gauge1.MaxValue:= 100;
        Gauge1.Progress:= 1;

        label7.Caption:= 'Gerando FolhaDePagamento.json';
        label7.Update;
        gerarFolhaDePagamento;
        Gauge1.Progress:= 10;

        label7.Caption:= 'Gerando FolhaDePagamentoServidor.json';
        label7.Update;
        gerarFolhaDePagamentoServidor;
        Gauge1.Progress:= 20;

        label7.Caption:= 'Gerando Servidor.json';
        label7.Update;
        gerarServidor;
        Gauge1.Progress:= 30;

        label7.Caption:= 'Gerando DependenteServidor.json';
        Label7.Update;
        gerarDependenteServidor;
        Gauge1.Progress:= 40;

        label7.Caption:= 'Gerando AtoCessaoDisposicao.json';
        label7.Update;
        gerarAtoCessaoDisposicao;
        Gauge1.Progress:= 50;

        label7.Caption:= 'Gerando DetalheFolha.json';
        label7.Update;
        gerarDetalheFolha;
        Gauge1.Progress:= 60;

        label7.Caption:= 'Gerando EventosFolha.json';
        label7.Update;
        gerarEventosFolha;
        Gauge1.Progress:= 70;

        label7.Caption:= 'Gerando BeneficiarioPensao.json';
        label7.Update;
        gerarBeneficiarioPensao;
        Gauge1.Progress:= 80;

        label7.Caption:= 'Gerando CargosPlano.json';
        Label7.Update;
        gerarCargosPlano;
        Gauge1.Progress:= 90;

        label7.Caption:= 'Gerando AtosAdmissaoFolha.json';
        label7.Update;
        gerarAtosAdmissaoFolha;
        Gauge1.Progress:= 99;
        Sleep(1000);

        Gauge1.Progress:= 100;
        label3.Caption:= 'Arquivos prontos!';
        label3.Font.Color:= clGreen;
        label3.Update;
        label7.Visible:= false;

    end;
    Application.MessageBox('Arquivos gerados com sucesso! A pasta ser� aberta.',' iJEX - Gera��o de Arquivo para eContas | Sucesso', MB_ICONEXCLAMATION + MB_OK);

    ShellExecute(Application.Handle, 'open', PChar(Folder), nil, nil, SW_NORMAL);

end;

//Percorre o Grid para tentar associal as UOs em falta
procedure TfrmEContas.SpeedButton3Click(Sender: TObject);
var
codLotacao, year: string;
i: integer;

begin
year:= FormatDateTime('yyyy', DateTimePicker1.Date);

  for I := 1 to StringGrid1.RowCount - 1 do
      begin
        if(StringGrid1.Cells[2,i] = '')then
          begin
            codLotacao:= StringGrid1.Cells[0,i];

            associationUO(year, codLotacao);
          end;
      end;

      consultaUO;
end;

//Percorre o grid para verificar com a procedure AddUO, se existe a LoDota��o na compet�ncia atual
procedure TfrmEContas.SpeedButton4Click(Sender: TObject);
var
qry, year, codLotacao, codUO: string;
i: integer;

begin
year:= FormatDateTime('yyyy', DateTimePicker1.Date);

  for I := 1 to StringGrid1.RowCount - 1 do
      begin
        codLotacao:= StringGrid1.Cells[0,i];
        codUO:= StringGrid1.Cells[2,i];

        addUO(year, codLotacao, codUO);
      end;

      consultaUO;

end;

function TfrmEContas.strPad(val: string; i: integer): string;
var
valor: string;
x: integer;
begin
valor:= val + StringOfChar(' ',(i) - Length(val));
StringReplace(valor, #13, ' ', [rfReplaceAll]);

for x := 1 to Length(valor) do
  begin
    if(Pos(valor[x], Acentuado)<> 0)then
      begin
        valor[x]:= NaoAcentuado[Pos(valor[x], Acentuado)];
      end;
  end;
  result:= valor;

end;

function TfrmEContas.strPadLeft(val: string; i: integer; ch: char): string;
var
  j, max: Integer;
  s: string;
begin
  s := '';
  max := i - Length(val);
  for j := 1 to max do
  begin
    s := s + ch;
  end;
  result := s + val;

end;

function TfrmEContas.toDate(Data: string): string;
begin
  if(Data <> '')then
    begin
      result:= FormatDateTime('YYYYmmdd', StrToDate(Data));
    end
    else
    begin
      result:= '00000000';
    end;

end;

function TfrmEContas.toDateVigencia(Data: string): string;
begin
  if(Data <> '')then
    begin
      result:= FormatDateTime('YYYYmm', StrToDate(Data));
    end
    else
    begin
      result:= '000000';
    end;
end;

procedure TfrmEContas.addUO(year, codLotacao, codUO: string);
var
qry: string;

begin //Verifica se existe a lota��o na tabela Lotacao_dotacao na compet�ncia atual
qry:= 'select distinct l.codigo, ld.uni_codigo, ld.ano ' +
      'from lotacao l ' +
      'join lotacao_dotacao ld on ld.codigo_lotacao = l.codigo ' +
      'where ld.ano = :year and ld.codigo_lotacao = :codLotacao ' + //--,0104029,0104028,0104027)
      'group by 1,2,3';

    with(DM.sqlAssociation)do
      begin
        Close;
        SQL.Clear;
        SQL.Add(qry);
        ParamByName('year').AsString:= year;
        ParamByName('codLotacao').AsString:= codLotacao;
        Open;

        if(RowsAffected <= 0)then  //caso n�o exista, � realizado a inser��o com a UO preenchida no Grid na compet�ncia atual
          begin
            qry:= 'insert into lotacao_dotacao values(' +
            ':codLotacao, :year, 1, :codUO, null, null, null, null)';

            Close;
            SQL.Clear;
            SQL.Add(qry);
            ParamByName('codLotacao').AsString:= codLotacao;
            ParamByName('year').AsString:= year;
            ParamByName('codUO').AsString:= codUO;

            try
              ExecSQL;
              Close;
            Except on E: Exception do
              begin
                ShowMessage(E.Message);
                abort;
              end;


            end;
          end;

      end;

end;

end.
