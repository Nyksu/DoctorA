object fr_main: Tfr_main
  Left = 280
  Top = 256
  Width = 798
  Height = 571
  Caption = #1056#1072#1089#1095#1105#1090' '#1084#1077#1076#1091#1089#1083#1091#1075' '#1087#1086' '#1075#1088#1091#1087#1087#1072#1084' '#1074#1088#1077#1076#1085#1086#1089#1090#1080'. '#169' '#1047#1040#1054' "'#1056#1059#1057#1048#1053#1058#1045#1051'", 2007 '#1075'.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 517
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 790
      Height = 517
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1052#1077#1076#1080#1094#1080#1085#1089#1082#1080#1077' '#1091#1089#1083#1091#1075#1080
        OnShow = TabSheet1Show
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 489
          Align = alClient
          Anchors = []
          BevelOuter = bvNone
          TabOrder = 0
          object Panel3: TPanel
            Left = 0
            Top = 435
            Width = 782
            Height = 54
            Align = alBottom
            BevelInner = bvLowered
            TabOrder = 0
            DesignSize = (
              782
              54)
            object Panel6: TPanel
              Left = 149
              Top = 8
              Width = 504
              Height = 33
              Anchors = [akTop]
              BevelOuter = bvNone
              TabOrder = 0
              object SpeedButton1: TSpeedButton
                Left = 0
                Top = 0
                Width = 97
                Height = 33
                Caption = #1044#1086#1073#1072#1074#1080#1090#1100
                OnClick = SpeedButton1Click
              end
              object SpeedButton2: TSpeedButton
                Left = 96
                Top = 0
                Width = 97
                Height = 33
                Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                OnClick = SpeedButton2Click
              end
              object SpeedButton3: TSpeedButton
                Left = 192
                Top = 0
                Width = 97
                Height = 33
                Caption = #1059#1076#1072#1083#1080#1090#1100
                OnClick = SpeedButton3Click
              end
              object SpeedButton7: TSpeedButton
                Left = 288
                Top = 0
                Width = 97
                Height = 33
                Caption = #1055#1088#1080#1085#1103#1090#1100
                Enabled = False
                OnClick = SpeedButton7Click
              end
              object SpeedButton8: TSpeedButton
                Left = 384
                Top = 0
                Width = 97
                Height = 33
                Caption = #1054#1090#1084#1077#1085#1072
                Enabled = False
                OnClick = SpeedButton8Click
              end
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 782
            Height = 320
            Align = alClient
            Caption = 'Panel4'
            TabOrder = 1
            object MedGrid: TStringGrid
              Left = 1
              Top = 1
              Width = 780
              Height = 318
              Align = alClient
              ColCount = 4
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
              TabOrder = 0
              OnClick = MedGridClick
              OnSelectCell = MedGridSelectCell
              ColWidths = (
                429
                73
                64
                99)
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 320
            Width = 782
            Height = 115
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            DesignSize = (
              782
              115)
            object Label1: TLabel
              Left = 8
              Top = 5
              Width = 82
              Height = 13
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' :'
            end
            object Label2: TLabel
              Left = 288
              Top = 61
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' ('#1088#1091#1073'.):'
            end
            object Edit1: TEdit
              Left = 8
              Top = 21
              Width = 764
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object Edit2: TEdit
              Left = 288
              Top = 77
              Width = 484
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object RadioGroup1: TRadioGroup
              Left = 8
              Top = 47
              Width = 115
              Height = 65
              Caption = ' '#1042#1080#1076' '#1091#1089#1083#1091#1075#1080' '
              ItemIndex = 0
              Items.Strings = (
                #1055#1088#1080#1077#1084
                #1055#1088#1086#1094#1077#1076#1091#1088#1072)
              TabOrder = 2
            end
            object RadioGroup2: TRadioGroup
              Left = 136
              Top = 47
              Width = 115
              Height = 65
              Caption = ' '#1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '
              ItemIndex = 0
              Items.Strings = (
                #1044#1083#1103' '#1078#1077#1085#1097#1080#1085
                #1044#1083#1103' '#1074#1089#1077#1093)
              TabOrder = 3
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1043#1088#1091#1087#1087#1099' '#1074#1088#1077#1076#1085#1086#1089#1090#1080
        ImageIndex = 1
        OnShow = TabSheet2Show
        object Panel7: TPanel
          Left = 0
          Top = 328
          Width = 782
          Height = 107
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            782
            107)
          object Label3: TLabel
            Left = 8
            Top = 5
            Width = 82
            Height = 13
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' :'
          end
          object Label4: TLabel
            Left = 8
            Top = 53
            Width = 25
            Height = 13
            Caption = #1050#1086#1076' :'
          end
          object Edit3: TEdit
            Left = 8
            Top = 21
            Width = 764
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object Edit4: TEdit
            Left = 8
            Top = 69
            Width = 764
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
        end
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 328
          Align = alClient
          TabOrder = 1
          object Splitter1: TSplitter
            Left = 524
            Top = 1
            Height = 326
            Align = alRight
            Color = clSkyBlue
            ParentColor = False
          end
          object GroupGrid: TStringGrid
            Left = 1
            Top = 1
            Width = 523
            Height = 326
            Align = alClient
            ColCount = 2
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
            TabOrder = 0
            OnClick = GroupGridClick
            OnSelectCell = GroupGridSelectCell
            ColWidths = (
              296
              138)
          end
          object Panel11: TPanel
            Left = 527
            Top = 1
            Width = 254
            Height = 326
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object Panel12: TPanel
              Left = 0
              Top = 267
              Width = 254
              Height = 59
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 0
              DesignSize = (
                254
                59)
              object MedSpeedButton: TSpeedButton
                Left = 8
                Top = 32
                Width = 241
                Height = 22
                Anchors = [akLeft, akTop, akRight]
                Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1077#1076'. '#1091#1089#1083#1091#1075#1091' '#1074' '#1075#1088#1091#1087#1087#1091
                OnClick = MedSpeedButtonClick
              end
              object medComboBox: TComboBox
                Left = 8
                Top = 8
                Width = 241
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ItemHeight = 13
                TabOrder = 0
              end
            end
            object MedListBox: TListBox
              Left = 0
              Top = 0
              Width = 254
              Height = 267
              Align = alClient
              ItemHeight = 13
              TabOrder = 1
              OnDblClick = MedListBoxDblClick
            end
          end
        end
        object Panel8: TPanel
          Left = 0
          Top = 435
          Width = 782
          Height = 54
          Align = alBottom
          BevelInner = bvLowered
          TabOrder = 2
          DesignSize = (
            782
            54)
          object Panel9: TPanel
            Left = 149
            Top = 8
            Width = 504
            Height = 33
            Anchors = [akTop]
            BevelOuter = bvNone
            TabOrder = 0
            object SpeedButton4: TSpeedButton
              Left = 0
              Top = 0
              Width = 97
              Height = 33
              Caption = #1044#1086#1073#1072#1074#1080#1090#1100
              OnClick = SpeedButton4Click
            end
            object SpeedButton5: TSpeedButton
              Left = 96
              Top = 0
              Width = 97
              Height = 33
              Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
              OnClick = SpeedButton5Click
            end
            object SpeedButton6: TSpeedButton
              Left = 192
              Top = 0
              Width = 97
              Height = 33
              Caption = #1059#1076#1072#1083#1080#1090#1100
              OnClick = SpeedButton6Click
            end
            object SpeedButton9: TSpeedButton
              Left = 288
              Top = 0
              Width = 97
              Height = 33
              Caption = #1055#1088#1080#1085#1103#1090#1100
              Enabled = False
              OnClick = SpeedButton9Click
            end
            object SpeedButton10: TSpeedButton
              Left = 384
              Top = 0
              Width = 97
              Height = 33
              Caption = #1054#1090#1084#1077#1085#1072
              Enabled = False
              OnClick = SpeedButton10Click
            end
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1080
        ImageIndex = 2
        object Panel13: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 489
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel13'
          TabOrder = 0
          object Panel14: TPanel
            Left = 0
            Top = 0
            Width = 782
            Height = 489
            Align = alClient
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 0
            object Splitter2: TSplitter
              Left = 531
              Top = 1
              Height = 325
              Align = alRight
              Color = clSkyBlue
              ParentColor = False
            end
            object Panel16: TPanel
              Left = 534
              Top = 1
              Width = 247
              Height = 325
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object Panel17: TPanel
                Left = 0
                Top = 210
                Width = 247
                Height = 115
                Align = alBottom
                TabOrder = 0
                DesignSize = (
                  247
                  115)
                object Label7: TLabel
                  Left = 23
                  Top = 4
                  Width = 73
                  Height = 13
                  Caption = #1055#1086' '#1085#1072#1079#1074#1072#1085#1080#1102' :'
                end
                object Label8: TLabel
                  Left = 23
                  Top = 44
                  Width = 46
                  Height = 13
                  Caption = #1055#1086' '#1082#1086#1076#1091' :'
                end
                object GrSpeedButton: TSpeedButton
                  Left = 24
                  Top = 86
                  Width = 217
                  Height = 22
                  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088'. '#1074#1088#1077#1076#1085#1086#1089#1090#1080' '#1074' '#1087#1088#1086#1092#1077#1089#1089#1080#1102
                  OnClick = GrSpeedButtonClick
                end
                object GrComboBox: TComboBox
                  Left = 24
                  Top = 20
                  Width = 218
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  TabOrder = 0
                end
                object CodeGrComboBox: TComboBox
                  Left = 24
                  Top = 60
                  Width = 218
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  Enabled = False
                  ItemHeight = 13
                  TabOrder = 1
                end
                object RadioButton1: TRadioButton
                  Left = 5
                  Top = 22
                  Width = 17
                  Height = 17
                  Checked = True
                  TabOrder = 2
                  TabStop = True
                  OnClick = RadioButton1Click
                end
                object RadioButton2: TRadioButton
                  Left = 5
                  Top = 63
                  Width = 17
                  Height = 17
                  TabOrder = 3
                  OnClick = RadioButton2Click
                end
              end
              object GrListBox: TListBox
                Left = 0
                Top = 0
                Width = 247
                Height = 210
                Align = alClient
                ItemHeight = 13
                TabOrder = 1
                OnDblClick = GrListBoxDblClick
              end
            end
            object Panel15: TPanel
              Left = 1
              Top = 326
              Width = 780
              Height = 162
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              DesignSize = (
                780
                162)
              object Label5: TLabel
                Left = 8
                Top = 5
                Width = 82
                Height = 13
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' :'
              end
              object Edit5: TEdit
                Left = 8
                Top = 21
                Width = 765
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 0
              end
              object Panel20: TPanel
                Left = 0
                Top = 108
                Width = 780
                Height = 54
                Align = alBottom
                BevelInner = bvLowered
                TabOrder = 1
                DesignSize = (
                  780
                  54)
                object Panel21: TPanel
                  Left = 148
                  Top = 8
                  Width = 489
                  Height = 41
                  Anchors = [akTop]
                  BevelOuter = bvNone
                  TabOrder = 0
                  object SpeedButton11: TSpeedButton
                    Left = 0
                    Top = 0
                    Width = 97
                    Height = 33
                    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
                    OnClick = SpeedButton11Click
                  end
                  object SpeedButton12: TSpeedButton
                    Left = 96
                    Top = 0
                    Width = 97
                    Height = 33
                    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                    OnClick = SpeedButton12Click
                  end
                  object SpeedButton13: TSpeedButton
                    Left = 192
                    Top = 0
                    Width = 97
                    Height = 33
                    Caption = #1059#1076#1072#1083#1080#1090#1100' '
                    OnClick = SpeedButton13Click
                  end
                  object SpeedButton14: TSpeedButton
                    Left = 288
                    Top = 0
                    Width = 97
                    Height = 33
                    Caption = #1055#1088#1080#1085#1103#1090#1100
                    Enabled = False
                    OnClick = SpeedButton14Click
                  end
                  object SpeedButton15: TSpeedButton
                    Left = 384
                    Top = 0
                    Width = 97
                    Height = 33
                    Caption = #1054#1090#1084#1077#1085#1072
                    Enabled = False
                    OnClick = SpeedButton15Click
                  end
                end
              end
            end
            object ProfGrid: TStringGrid
              Left = 1
              Top = 1
              Width = 530
              Height = 325
              Align = alClient
              ColCount = 1
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
              TabOrder = 2
              OnClick = ProfGridClick
              OnSelectCell = ProfGridSelectCell
              ColWidths = (
                501)
            end
          end
        end
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 12
    Top = 43
    object N3: TMenuItem
      Caption = #1054#1090#1095#1077#1090#1099
      object N4: TMenuItem
        Caption = #1060#1086#1088#1084#1072' "'#1056#1072#1089#1095#1077#1090'"'
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = '"'#1052#1077#1076'. '#1091#1089#1083#1091#1075#1080'"'
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = '"'#1043#1088#1091#1087#1087#1099' '#1074#1088#1077#1076#1085#1086#1089#1090#1080'"'
        OnClick = N6Click
      end
    end
    object C1: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = C1Click
    end
    object N1: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N2: TMenuItem
        Caption = #1050#1086#1084#1087#1072#1085#1080#1103'...'
        OnClick = N2Click
      end
    end
    object N7: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N7Click
    end
  end
end
