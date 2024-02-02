object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 427
  Width = 735
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 48
    Top = 104
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 184
  end
  object sqlUO: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT DISTINCT l.codigo as Codigo, l.nome, ld.uni_codigo'
      '    FROM lotacao l'
      
        '    LEFT JOIN lotacao_dotacao ld ON ld.codigo_lotacao = l.codigo' +
        ' AND ld.ano = 2020'
      '    LEFT JOIN capa_variavel cv ON cv.codigo_lotacao = l.codigo'
      
        '    WHERE cv.ano = 2020 AND ld.uni_codigo IS NULL OR (ld.uni_cod' +
        'igo = '#39#39')'
      '    order by l.codigo')
    Left = 176
    Top = 32
    object sqlUOCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 7
    end
    object sqlUONOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object sqlUOUNI_CODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNI_CODIGO'
      Origin = 'UNI_CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
  end
  object sqlDuplication: TFDQuery
    Connection = FDConnection
    Left = 176
    Top = 112
  end
  object sqlAssociation: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 32
  end
  object sqlInsertUO: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 112
  end
  object sqlFolhaPagamento: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 40
  end
  object sqlFolhaPagamentoServidor: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 112
  end
  object sqlServidor: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 184
  end
  object sqlDetalheFolha: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 248
  end
  object sqlBeneficiario: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 320
  end
  object sqlEventosFolha: TFDQuery
    Connection = FDConnection
    Left = 544
    Top = 40
  end
  object sqlCargosPlano: TFDQuery
    Connection = FDConnection
    Left = 544
    Top = 112
  end
  object sqlAtosAdmissao: TFDQuery
    Connection = FDConnection
    Left = 544
    Top = 184
  end
  object sqlDependenteServidor: TFDQuery
    Connection = FDConnection
    Left = 544
    Top = 264
  end
  object sqlAtoCessaoDisp: TFDQuery
    Connection = FDConnection
    Left = 544
    Top = 344
  end
  object sqlSIOPE: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 192
  end
  object sqlErrors: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 264
  end
  object sqlUpdates: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 328
  end
end
