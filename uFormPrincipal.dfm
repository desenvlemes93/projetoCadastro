object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Formulario de Cadastro'
  ClientHeight = 420
  ClientWidth = 1332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = -2
    Width = 1329
    Height = 419
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 18
      Width = 14
      Height = 13
      Caption = 'Id:'
    end
    object Label2: TLabel
      Left = 12
      Top = 57
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 351
      Top = 57
      Width = 51
      Height = 13
      Caption = 'CPF/ CNPJ'
    end
    object Label4: TLabel
      Left = 12
      Top = 99
      Width = 52
      Height = 13
      Caption = 'Identidade'
    end
    object Label5: TLabel
      Left = 123
      Top = 99
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object Label14: TLabel
      Left = 324
      Top = 99
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object edtId: TEdit
      Left = 9
      Top = 33
      Width = 19
      Height = 21
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 9
      Top = 76
      Width = 336
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object edtRG: TEdit
      Left = 9
      Top = 115
      Width = 104
      Height = 21
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 3
      Top = 139
      Width = 534
      Height = 230
      Caption = 'Endere'#231'o'
      TabOrder = 4
      object Label6: TLabel
        Left = 9
        Top = 14
        Width = 23
        Height = 13
        Caption = 'Cep:'
      end
      object Label7: TLabel
        Left = 6
        Top = 66
        Width = 59
        Height = 13
        Caption = 'Logradouro:'
      end
      object Label8: TLabel
        Left = 133
        Top = 66
        Width = 41
        Height = 13
        Caption = 'Numero:'
      end
      object Label9: TLabel
        Left = 182
        Top = 66
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object Label10: TLabel
        Left = 6
        Top = 111
        Width = 32
        Height = 13
        Caption = 'Bairro:'
      end
      object Label11: TLabel
        Left = 133
        Top = 112
        Width = 37
        Height = 13
        Caption = 'Cidade:'
      end
      object Label12: TLabel
        Left = 263
        Top = 112
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label13: TLabel
        Left = 6
        Top = 156
        Width = 23
        Height = 13
        Caption = 'Pais:'
      end
      object edtCep: TEdit
        Left = 6
        Top = 31
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object buscarCep: TButton
        Left = 133
        Top = 31
        Width = 75
        Height = 21
        Caption = 'Buscar'
        TabOrder = 0
        OnClick = buscarCepClick
      end
      object edtLogradouro: TEdit
        Left = 6
        Top = 83
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 2
      end
      object edtNumero: TEdit
        Left = 133
        Top = 83
        Width = 41
        Height = 21
        TabOrder = 3
      end
      object edtComplemento: TEdit
        Left = 182
        Top = 83
        Width = 199
        Height = 21
        TabOrder = 4
      end
      object edtBairro: TEdit
        Left = 6
        Top = 129
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 5
      end
      object edtCidade: TEdit
        Left = 133
        Top = 129
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 6
      end
      object edtPais: TEdit
        Left = 3
        Top = 175
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object edtEstado: TEdit
        Left = 260
        Top = 129
        Width = 35
        Height = 21
        Enabled = False
        TabOrder = 7
      end
    end
    object edtEmail: TEdit
      Left = 123
      Top = 115
      Width = 178
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object DBGrid1: TDBGrid
      Left = 502
      Top = 18
      Width = 824
      Height = 398
      DataSource = DataModule1.dsCliente
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Identidade'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'email'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Logradouro'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bairro'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cidade'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Estado'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Pais'
          Visible = True
        end>
    end
    object Button1: TButton
      Left = 248
      Top = 375
      Width = 74
      Height = 25
      Caption = '&Limpar'
      TabOrder = 6
      OnClick = Button1Click
    end
    object mskTelefone: TMaskEdit
      Left = 324
      Top = 115
      Width = 91
      Height = 21
      EditMask = '!\(999\)00000-0000;1;_'
      MaxLength = 15
      TabOrder = 7
      Text = '(   )     -    '
    end
  end
  object btnSalvar: TButton
    Left = 86
    Top = 373
    Width = 75
    Height = 25
    Caption = '&Salvar'
    Enabled = False
    TabOrder = 1
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 167
    Top = 373
    Width = 75
    Height = 25
    Caption = '&Excluir'
    Enabled = False
    TabOrder = 2
    OnClick = btnExcluirClick
  end
  object btnSair: TButton
    Left = 324
    Top = 373
    Width = 75
    Height = 25
    Caption = 'Sai&r'
    TabOrder = 3
    OnClick = btnSairClick
  end
  object mskeditCPF: TMaskEdit
    Left = 351
    Top = 74
    Width = 121
    Height = 21
    TabOrder = 4
    Text = ''
    OnExit = mskeditCPFExit
  end
  object btnNovo: TButton
    Left = 5
    Top = 373
    Width = 75
    Height = 24
    Caption = 'Nov&o'
    TabOrder = 5
    OnClick = btnNovoClick
  end
end
