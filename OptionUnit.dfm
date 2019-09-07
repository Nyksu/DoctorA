object OptionForm: TOptionForm
  Left = 301
  Top = 217
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1060#1086#1088#1084#1072' "'#1056#1072#1089#1095#1077#1090'"'
  ClientHeight = 566
  ClientWidth = 825
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 825
    Height = 566
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 825
      Height = 404
      Align = alClient
      Caption = ' '#1044#1072#1085#1085#1099#1077' '
      TabOrder = 0
      object Panel3: TPanel
        Left = 137
        Top = 15
        Width = 686
        Height = 387
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Panel4: TPanel
          Left = 446
          Top = 0
          Width = 240
          Height = 387
          Align = alRight
          BevelInner = bvLowered
          BevelOuter = bvSpace
          TabOrder = 0
          DesignSize = (
            240
            387)
          object Label1: TLabel
            Left = 16
            Top = 10
            Width = 111
            Height = 13
            Caption = #1052#1077#1076#1080#1094#1080#1085#1089#1082#1080#1077' '#1091#1089#1083#1091#1075#1080' :'
          end
          object SpeedButton3: TSpeedButton
            Left = 16
            Top = 344
            Width = 209
            Height = 22
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1077#1076'. '#1091#1089#1083#1091#1075#1091
            OnClick = SpeedButton3Click
          end
          object ListBox2: TListBox
            Left = 16
            Top = 24
            Width = 209
            Height = 281
            Color = clBtnFace
            ItemHeight = 13
            TabOrder = 0
            OnDblClick = ListBox2DblClick
          end
          object MComboBox: TComboBox
            Left = 16
            Top = 312
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 1
          end
        end
        object StringGrid1: TStringGrid
          Left = 136
          Top = 0
          Width = 310
          Height = 387
          Align = alRight
          ColCount = 4
          Ctl3D = False
          DefaultColWidth = 80
          DefaultRowHeight = 15
          FixedCols = 2
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
          ParentCtl3D = False
          TabOrder = 1
          OnClick = StringGrid1Click
          OnDblClick = StringGrid1DblClick
          OnKeyUp = StringGrid1KeyUp
          OnSelectCell = StringGrid1SelectCell
          ColWidths = (
            80
            80
            69
            64)
        end
      end
      object Panel5: TPanel
        Left = 217
        Top = 15
        Width = 56
        Height = 387
        Align = alLeft
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 1
        object SpeedButton2: TSpeedButton
          Left = 8
          Top = 144
          Width = 39
          Height = 33
          Caption = '>>>'
          OnClick = SpeedButton2Click
        end
        object SpeedButton4: TSpeedButton
          Left = 8
          Top = 184
          Width = 39
          Height = 33
          Caption = 'X'
          OnClick = SpeedButton4Click
        end
      end
      object ListBox1: TListBox
        Left = 2
        Top = 15
        Width = 215
        Height = 387
        Align = alLeft
        ItemHeight = 13
        MultiSelect = True
        Sorted = True
        TabOrder = 2
        OnDblClick = ListBox1DblClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 404
      Width = 825
      Height = 96
      Align = alBottom
      Caption = ' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '
      TabOrder = 1
      DesignSize = (
        825
        96)
      object Edit1: TEdit
        Left = 16
        Top = 35
        Width = 789
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnKeyDown = Edit1KeyDown
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 500
      Width = 825
      Height = 66
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvSpace
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      DesignSize = (
        825
        66)
      object SpeedButton1: TSpeedButton
        Left = 298
        Top = 19
        Width = 126
        Height = 31
        Anchors = []
        Caption = #1055#1088#1086#1089#1090#1086#1081' '#1086#1090#1095#1077#1090
        OnClick = SpeedButton1Click
      end
      object SpeedButton5: TSpeedButton
        Left = 432
        Top = 19
        Width = 126
        Height = 31
        Caption = #1054#1090#1095#1077#1090' '#1074' MS Excel'
        OnClick = SpeedButton5Click
      end
    end
  end
end
