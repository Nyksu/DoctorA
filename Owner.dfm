object OwnerForm: TOwnerForm
  Left = 540
  Top = 303
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1087#1072#1085#1080#1103
  ClientHeight = 241
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 241
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 112
      Top = 208
      Width = 97
      Height = 25
      Caption = 'OK'
      OnClick = SpeedButton1Click
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 320
      Height = 193
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 11
        Width = 82
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' :'
      end
      object Label2: TLabel
        Left = 16
        Top = 51
        Width = 37
        Height = 13
        Caption = #1040#1076#1088#1077#1089' :'
      end
      object Label3: TLabel
        Left = 16
        Top = 91
        Width = 51
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085' :'
      end
      object Label4: TLabel
        Left = 16
        Top = 128
        Width = 119
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1072' :'
      end
      object Edit1: TEdit
        Left = 16
        Top = 27
        Width = 289
        Height = 21
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 16
        Top = 67
        Width = 289
        Height = 21
        TabOrder = 1
      end
      object Edit3: TEdit
        Left = 16
        Top = 107
        Width = 289
        Height = 21
        TabOrder = 2
      end
      object Edit4: TEdit
        Left = 16
        Top = 144
        Width = 289
        Height = 21
        TabOrder = 3
      end
    end
  end
end
