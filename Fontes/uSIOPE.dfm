object frmSIOPE: TfrmSIOPE
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmSIOPE'
  ClientHeight = 419
  ClientWidth = 780
  Color = clScrollBar
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label2: TLabel
    Left = 8
    Top = 31
    Width = 144
    Height = 16
    Caption = 'Selecione a Compet'#234'ncia'
  end
  object Label1: TLabel
    Left = 8
    Top = 104
    Width = 214
    Height = 16
    Caption = 'Evento de verbas a serem deduzidos.'
  end
  object SpeedButton2: TSpeedButton
    Left = 198
    Top = 159
    Width = 40
    Height = 40
    Hint = 'Salvar eventos'
    Enabled = False
    Flat = True
    Glyph.Data = {
      2E0A0000424D2E0A00000000000036000000280000001D0000001D0000000100
      180000000000F809000025160000251600000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFBF2E7F1D8B3F2DAB7F1D9B5F1D9B4F1D9B4F1D9B4
      F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9B4F1D9
      B4F1D9B4F1D9B5F2DAB7F1D8B3FBF2E7FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF2D8B3D48712D99228DB9937DB9835DB9835DB9835DB9835DB9835DB98
      35DB9835DB9835DB9835DB9835DB9835DB9835DB9835DB9835DB9835DB9937D8
      9228D58712F2D8B3FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D589
      17EFD0A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEED0A3D58917F3DBB9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D58815EFD4AAFFFFFFFE
      FEFEF1F0EDF3F1EEF3F1EEF3F1EEF3F1EEF3F1EEF3F1EEF3F1EEF3F1EEF3F1EE
      F3F1EEF3F1EEF1F0EDFEFEFEFFFFFFEFD4AAD58815F3DBB9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFF3DBB9D58815EFD3A9FFFFFFFCFBFBD7D3C9DBD7CD
      DBD7CDDBD7CDDBD7CDDBD7CDDBD7CDDBD7CDDBD7CDDBD7CDDBD7CDDBD7CDD7D3
      C9FCFBFBFFFFFFEFD3A9D58815F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF3DBB9D58815EFD3A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF
      D3A9D58815F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D588
      15EFD3A9FFFFFFFCFBFBD3CEC3D7D2C8D7D2C8D7D2C8D7D2C8D7D2C8D7D2C8D7
      D2C8D7D2C8D7D2C8D7D2C8D7D2C8D3CEC3FCFBFBFFFFFFEFD3A9D58815F3DBB9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D58815EFD3A9FFFFFFFF
      FEFFF8F7F6F9F8F7F9F8F7F9F8F7F9F8F7F9F8F7F9F8F7F9F8F7F9F8F7F9F8F7
      F9F8F7F9F8F7F8F7F6FFFEFFFFFFFFEFD3A9D58815F3DBB9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFF3DBB9D58815EFD3A9FFFFFFFDFDFDEAE8E2ECEAE5
      ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5ECEAE5EAE8
      E2FDFDFDFFFFFFEFD3A9D58815F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF3DBB9D58815EFD3A9FFFFFFFDFCFCE0DDD5E3E0D8E3E0D8E3E0D8E3E0
      D8E3E0D8E3E0D8E3E0D8E3E0D8E3E0D8E3E0D8E3E0D8E0DDD5FDFCFCFFFFFFEF
      D3A9D58815F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D588
      16F0D5ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0D5ADD58816F3DBB9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D78D1EE1AA5AEECE9FED
      CB99EDCB99EDCB99EDCB99EDCB99EDCB99EDCB99EDCB99EDCB99EDCB99EDCB99
      EDCB99EDCB99EDCB99EDCB99EECE9FE1AA58D78D1EF3DBB9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFF3DBB9D89024DA952ED89127D89127D89127D89127
      D89127D89127D89127D89127D89127D89127D89127D89127D89127D89127D891
      27D89127D89127DA952ED89024F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF3DBB9D89024DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB98
      34DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB9834DB
      9834D89024F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D890
      24DC9834DE9A35DE9A35DE9A35DD962CDD9326DD9326DD9326DD9326DD9326DD
      9326DD9326DD9326DD9326DD9427DB9630DB9834DB9834DB9834D89024F3DBB9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9D99024D49331BA8029B9
      8029B97C20C1A476C6BDAEC5BCACC5BCACC5BCACC5BCACC9C0AFD1C8B7D1C8B7
      C7BEAEC5BCAAD69E48DB9630DB9834DB9834D89024F3DBB9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFF3DBB9DA9124C78A2DB67E28B87F28B77819C5C1B9
      C4BFB3C4BEB1C4BEB1C4BEB1C8C2B5ACA69A585348565146C0BBAEC4C2BBCEAD
      79DC952BDB9834DB9834D89024F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF3DBB9DA9124C78A2DB77E28B98029B77819C5C0B7C5BEB1C5BEB0C5BE
      B0C5BEB0CAC3B5A19A8D251F13221C11BFB9ABC6C2B9CEAD78DC952BDB9834DB
      9834D89024F3DBB9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9DA91
      24C78A2DB77E28B98029B77819C5C0B6C5BEB1C5BEB0C5BEB0C5BEB0CAC3B5A3
      9C8F2B2519282216C0BAACC6C2B9CEAD78DC952BDB9834DB9834D78E21F2D9B6
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3DBB9DA9124C78A2DB77E28B9
      8029B77819C5C0B6C5BEB1C5BEB0C5BEB0C5BEB0CAC3B5A39C8F2B2519282216
      C0BAACC6C2B9CEAD78DC952BDB9834DA952FD9932AF7E9D4FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFF3DBB9DA9124C78A2DB77E28B98029B77819C5C0B6
      C5BEB1C5BEB0C5BEB0C5BEB0CAC3B59F978B1C170B191408BEB8AAC6C2B9CEAD
      78DC952BDA952FD9942DF6E7D2FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFF2D8B3D78915C3811DB17417B37618B26E08C0BBB0C0B9AAC0B8A9C0B8
      A9C0B8A9C1B9AABEB6A7B2AB9CB2AA9BC1B9AABFBBB1CBA76DD98C19D9942BF7
      E7D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFBF2E7F2D9
      B3EBD7B7E6D2B5E6D3B5E6D0AFEBE9E6EBE8E4EBE8E3EBE8E3EBE8E3EBE8E3EB
      E9E4EEEBE6EEEBE6EBE9E4EAE9E6EEE3D0F2D8B2F7EAD6FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 8
    Top = 219
    Width = 230
    Height = 45
    Hint = 'Gerar arquivo'
    Caption = 'Gerar Arquivos para SIOPE'
    Flat = True
    Glyph.Data = {
      F6120000424DF612000000000000360000002800000028000000280000000100
      180000000000C0120000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFEFDFDF8F1EEF2E1DCE1C6C0C89A90AD7C6DB17E6CB37D6FC28F82DCB9AFEF
      E1DEF7F0EFFDFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF5F4EDD9D4CEA89EAA5E44A4
      3C1D9D3819A43916B1411EB04424AE4221A83D1BA03B1CA03A1BAC5337C99383
      E9D6CFF9F5F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFCF9F8E8D5D1BF806E9F3818A02D08A43916A34325A64728A6482A
      A44629A44628A44628A6472AA54729A44325A039199E33119F3514B46952DAB6
      ABFCF9F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E8E4CB907E
      9F35159B2D0CA44223A74B2EA5482BA54527A54527A54527A54527A54527A545
      27A54527A54527A54527A6472AA84B2EA443269F34139B2B09C17F68ECD9D4FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEADCD7AD573B982905A13F1FA84C2EA547
      29A54527A54527A54527A64527A6482AA5492BA74729A6492BA6492BA54528A5
      4527A54527A54526A54628A74B2EA647299C300DA24325DBB7B1FEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFDBBAB2A23D1E9D3210A7492CA7482BA54526A54526A54526A5472AA7
      4A2DA34526A13615A43513A13E1FA23513A13310A44324A6482BA7482BA54527
      A54526A54426A6482AA7492CA03A199A2703D5AEA2FEFDFDFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDBDB49A2E0DA0
      3412A74B2DA64728A54527A54527A6482AA6492CA43918A12F0C9F3817A54C30
      AC5E45B4644BB05F48A75036A239199E310FA0391AA6472AA7492DA54426A544
      26A54527A84A2CA241219A2C0ACEA395FDFDFCFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFE2C3B9993113A24020A74A2BA54628A54527
      A54528A6482CA43F209E300EA4492DC69789E7CCC4F0E2DDF1E7E4F5E9E5F2E7
      E4EFE1DEE5CFC9D1A79BAF54399F2B0AA13918A74C2DA64629A54527A54527A6
      4A2CA1391A982507DEC1B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFF6EEEBAC4E36972808A84D2FA54628A54527A54629A646289F3716A33F
      21D5AA9FF3ECEAFCFBFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FEFEF6EEEBDACAC3A547299C2D0BA64629A7472AA54527A54527A7492C9F3617
      A43F23E8D3CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAC892819A27
      05A7492CA64729A54426A54628A64528A23A1BB66B54ECDBD6FEFDFDFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      F4EAE7C78A79992704A34021A6482AA54527A54628A647299D3211AE5A42F8F2
      F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9D5CE982807A33D1FA74A2DA54426A5
      4628A6492A9B2E0DBB7863F4EBE8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9F8C688
      769F3919A44223A64729A54527A64729A54426952200DAB4ABFFFFFFFFFFFFFF
      FFFFFFFFFFFCF9F8C68B7A952403A94C30A54526A54526A7492CA03A1BAD5A40
      F2E8E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAF9CE9D8E9E3212A4
      4224A54628A54527A7492B9A2C0AB6674EF9F5F3FFFFFFFFFFFFFFFFFFE8D4D0
      A03517A13C1DA74A2DA54426A6482AA23E1EA44124ECDAD4FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7EFEDAD563CA1391AA64729A54527
      A7482AA442239B2B08D9B9ADFFFFFFFFFFFFFEFDFDD0A3999B2F0CA84E30A443
      25A54527A74A2C972502DEBBB2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFE5CEC6A13D1EA44123A64628A54527A7492C9B2D
      0BBB7965FEFDFCFFFFFFFAF6F5B6664E9E3311A64B2EA44426A6492CA33B1BA0
      3F23F9F5F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFBF7E6B9E3413A54628A54527A84A2D9E3413AB4D30F2E5E1FC
      FAF9F3E9E59E3715A54224A54628A54527A64A2C9B2A08D8AEA4FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7
      D1C9A03919A54426A54527A6482BA23F209E3210DFC0B7F8F2F1E1C4BA9E3E1C
      A34A2FA3472BA44C31A1401F95300FEFE1DEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F4F2AB5237A33F1F
      A54527A54527A645279D2A09D1A89BF2EAE7DA9C92AD1700BA3703B63002B837
      03B01700BF5142F7EAE6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDC285729F3514A64628A54527A646
      289F310FC5907EE6D5CECAC1C3AA939AB4A3A3B2A1A2B4A3A3AA979BBEAFB2F6
      F4F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFEFDFDD3A6989A2D0CA6482BA54527A64729A03E1EBE735DDF
      B6ABFDFDFDFBFBFCFDFDFDFDFDFDFDFDFEFCFCFDFDFDFDFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFDCE9D8FA33D1EA64629A54526A74A2D9E2F0CB86B53DAB8ADFDFDFDFBFBFA
      FDFDFCFDFDFCFDFDFCFDFDFDFDFDFCFBFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFA
      FAFAFAFAFAFAFAFAFAFAFAFAFAF9F9F9FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDCF9E8FA33E1E
      A64628A44526A54A2DA42E0CB16A52CFB7ADC2BFCB8E7F959D94A79B91A59B92
      A59B90A19C94A69796B49294B59393B49394B49393B49393B49393B49394B494
      94B48A8CAF8F8EB0E4E1E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDD3A799992D0CA6482AA54527A547
      29A23E1EBA735DDAB6AB9B9AF4010DDF0622E3061DE3061DE3061EE3061EE307
      1DE1071DE1071DE1071DE1071DE1071DE1071DE1081EE1081EE10117E1091ADF
      C4C9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFEFDFDC386749E3413A64628A54527A546289E3310C48D7CE5
      D2CCCFD0F0192ABB2936BB2835BC2835BC2835BC2835BC2835BC2835BC2835BC
      2835BC2835BC2836BC2835BC2835BC2936BC2431BB2834BCCDD0EEFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9
      F5F4AA5339A33E1EA54527A54527A545279D2D0ACFA598F0E8E5E8E9F81828BD
      1B2ABF2633C02331C02331C02331C02331C02331C02331C02331C02331C02331
      C02331C02331C02432C01E2DBF2431BFCDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7D1CB9F3919A44425
      A54527A6482AA33F209F3112DDBEB4F8F2F0F4F4FB6167D00A19BC2D3BC12230
      C02332C02331C02332C02331C02331C02331C02331C02331C02331C02331C024
      32C01E2DBF2430BFCDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3826E9D3312A54628A54527A74A2C9F34
      13A94C30F0E4E0FCFAF9FDFDFEB8BBE60110BA2938C12331C02331C02331C023
      31C02331C02331C02331C02331C02331C02331C02331C02432C01E2DBF2430BF
      CDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFE6D2CBA23D1FA44121A64628A54526A7492B9B2F0DB87662FDFCFBFF
      FFFFFFFFFFE4E6F4111FBD1929BE2937C12230C02331C02331C02331C02331C0
      2331C02331C02331C02331C02331C02432C01E2DBF2431BFCDD0EFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F3F1AB573A9F
      3717A64729A54527A6482BA342239C2C09D8B6ABFFFFFFFFFFFFFFFFFFFBFBFD
      8084D8091BBB2735C12331C02331C02331C02331C02331C02331C02331C02331
      C02331C02331C02432C01E2DBF2430BFCDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFBD1AA9D9E2F0CA44223A54729A54527
      A7482B9A2C0AB5644CF8F3F2FFFFFFFFFFFFFFFFFFFFFFFFD6D6F2212BC11221
      BA2A37C22230C02331C02331C02332C02332C02332C02331C02331C02331C024
      32C01E2DBF2430BFCDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFCFAFAC89180A33A1CA44021A64629A54527A64729A64527962400D7B3
      A6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFE9596DE000AB52433C02735C122
      30C02331C02331C02331C02331C02331C02331C02331C02432C01E2DBF2431C0
      CDD0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6ECEAC793839621
      00A44122A6482AA54527A54628A647299E3313AD583EF7F1EFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF5F5FC555FD30010B82736C02633C02331C02331C0
      2331C02331C02331C02332C02331C02432C01E2DBF2430BFCED0EFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFF7F0EEE4CDC5A9492E9F3515A34526A6472AA54527A5
      4527A6482CA03918A43F21E6CFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE0E1F51D2BBE0717B92936C12533C12331C02331C02331C02331
      C02331C02331C02432C01E2CBF2530BECCD0F5FFFFFFFAF8F8EDDDD7E5CEC6D6
      B1A6AD583D9E34129F3919A7482BA6472AA54526A54527A74A2CA13C1C982807
      DBBAB2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFC7C9EB1624C00A1BBC2836C12633C02331C02331C02331C02331C02331C024
      32C0202DBE2431BEC4D1FEFFFFFFEACDBDA9533A9F37169D2F0FA2391AA54526
      A7492BA54426A54527A54527A6482BA33F21992703C99D8FFDFCFCFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D7F12D
      3AC20315B82634C02836C02230C02331C02332C02331C02432C0202DBE2431BE
      C2D1FFFFFFFFEFC1ACA94323A14123A6482BA6482BA54527A54526A54425A646
      28A74B2EA23E1E982806D5AEA3FDFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E5F54451C9010FB8
      1726BD2B39C22533C12230C02331C02432C01F2DBE2530BEC4D0FDFFFFFFEBCB
      B9AE5538A54427A54527A54527A54526A54527A74B2EA44A2D9F2C0AA43A1ADA
      B6AAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEBF9989EE11524C00211BA1C2C
      BF2937C02735C02432C0202DBE2530BEC4D1FEFFFFFFECCAB8AD5235A44326A5
      4527A54729A74B2EA6472A9E34139C2200AD6B55E4D1CBFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFECBCEF0797FD61827BD1020BD1322BD1B
      2BC0202EBE2833BFC4D1FEFFFFFFECCAB9AE5538A5472AA44528A33F209F310E
      9D2F0EA95137DEB2A9F7F4F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF6F7FCD3D6F199A0E14F58CD1D2DC50F1EBE1B27B8
      BDCCFEFFFFFFEBC1ADA73A1B9F3819A13A1AA54124C18270DFC4BBF5ECE9FFFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFDFDFEF1F2FAECEDEECFD0E8949AE6DCE2FCFFFFFFF1E1
      D7CBA192D1A294ECD6D0F4E7E4FBF8F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton3Click
  end
  object Bevel1: TBevel
    Left = 8
    Top = 270
    Width = 230
    Height = 11
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 8
    Top = 154
    Width = 188
    Height = 13
    Caption = 'Separe-os com v'#237'rgula, ex: 501,20,550'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 287
    Width = 37
    Height = 16
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Gauge1: TGauge
    Left = 0
    Top = 414
    Width = 780
    Height = 5
    Align = alBottom
    BorderStyle = bsNone
    ForeColor = clGreen
    Progress = 0
    ShowText = False
    ExplicitTop = 409
    ExplicitWidth = 770
  end
  object Label5: TLabel
    Left = 8
    Top = 309
    Width = 37
    Height = 16
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Gera'#231#227'o de Arquivos SIOPE'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 754
      Top = 3
      Width = 23
      Height = 19
      Hint = 'Fechar'
      Align = alRight
      Flat = True
      Glyph.Data = {
        2E0A0000424D2E0A00000000000036000000280000001D0000001D0000000100
        180000000000F809000025160000251600000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFD5D8FC8B92F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B92F7D6D8FCFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD4D7FC2836F324
        32F27881F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF7881F72331F22937F3D5D8FCFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF858CF82432F23441F32533F38C93F8
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C93F82533
        F33441F32332F2848CF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF7079F62634F23441F32634F2838BF8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF838BF82634F23441F32634F27079F6FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF848BF82533F23441F32735F37C84F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF7C84F82735F33441F32534F2848CF8FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF7981F72836F33441F32634F38E95F9FFFFFFFFFFFFFFFFFF8D94F92634F3
        3441F32836F37982F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717AF6
        2634F23441F32534F2828AF7FFFFFF818AF72634F23441F32634F2717BF6FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF828BF82634F23441
        F32E3BF34954F42E3BF33441F32534F2838BF8FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7780F72D3BF33542F3323FF335
        42F32D3BF37780F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF434FF43240F33643F43240F3444FF4FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF838BF72E3CF33542F33340F33542F32E3CF3838BF7FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D95F82634F23441
        F32E3BF33F4CF42E3BF33441F32634F28D95F8FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7C84F72634F23441F32534F27781F8FFFFFF77
        80F82534F23441F32634F27D84F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF848CF72836F33441F32634F3828AF7FFFFFFFFFFFFFFFFFF828AF72634F3
        3441F32836F3848CF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E95F92533F23441F3
        2836F3717AF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF717AF72836F33441F32634
        F38E95F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF7B84F82634F33441F32633F27881F7FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7881F72633F23441F32634F37B84F8FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF8F96F92332F23441F32634F3848CF8FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFE848CF82634F33441F32332F28F96F9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDD1FC2533F323
        31F26F79F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF6F78F72331F22533F3CDD1FCFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCED1FC858CF7FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF858CF7CED1FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
      ExplicitLeft = 747
      ExplicitTop = 0
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 244
    Top = 28
    Width = 533
    Height = 383
    Align = alRight
    BevelOuter = bvNone
    Color = clBtnShadow
    ParentBackground = False
    TabOrder = 1
    object Label4: TLabel
      Left = 0
      Top = 0
      Width = 533
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = 'Notifica'#231#245'es SIOPE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 134
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 25
      Width = 527
      Height = 355
      Align = alBottom
      BorderStyle = bsNone
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 53
    Width = 113
    Height = 27
    Date = 45293.000000000000000000
    Format = 'MM/yyyy'
    Time = 0.864131180554977600
    DateMode = dmUpDown
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnChange = DateTimePicker1Change
  end
  object Edit1: TEdit
    Left = 8
    Top = 126
    Width = 230
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Text = '501,20,19,550'
    OnChange = Edit1Change
  end
  object SaveDialog2: TSaveDialog
    Filter = 'Arquivos CSV|*.csv'
    InitialDir = 'c:\infortread'
    Options = []
    OptionsEx = [ofExNoPlacesBar]
    Title = 'Selecione onde o arquivo ser'#225' salvo'
    Left = 240
    Top = 8
  end
end
