unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DM, ExtCtrls, Menus, ComCtrls, Buttons, StdCtrls, Grids, ToolWin, IniFiles;

type
  Tfr_main = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Edit1: TEdit;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel7: TPanel;
    Edit3: TEdit;
    Panel10: TPanel;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    MedGrid: TStringGrid;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Panel8: TPanel;
    Panel9: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupGrid: TStringGrid;
    Splitter1: TSplitter;
    Panel11: TPanel;
    Panel12: TPanel;
    MedListBox: TListBox;
    medComboBox: TComboBox;
    MedSpeedButton: TSpeedButton;
    TabSheet3: TTabSheet;
    Panel13: TPanel;
    Panel14: TPanel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    C1: TMenuItem;
    Panel16: TPanel;
    Panel17: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    GrComboBox: TComboBox;
    CodeGrComboBox: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel15: TPanel;
    Label5: TLabel;
    Edit5: TEdit;
    Panel20: TPanel;
    Splitter2: TSplitter;
    GrListBox: TListBox;
    ProfGrid: TStringGrid;
    GrSpeedButton: TSpeedButton;
    Panel21: TPanel;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    RadioGroup2: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MedGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure GroupGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure MedSpeedButtonClick(Sender: TObject);
    procedure MedListBoxDblClick(Sender: TObject);
    procedure GrSpeedButtonClick(Sender: TObject);
    procedure ProfListBoxClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure MSpeedButtonClick(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure C1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ProfGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure MedGridClick(Sender: TObject);
    procedure GroupGridClick(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure GrListBoxDblClick(Sender: TObject);
    procedure ProfGridClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    procedure GetVersionInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_main: Tfr_main;
  prognam, progvers : string;
  MDM: TdDM;
  MedY, GroupY, MedIndex, GroupIndex: Integer;
  Operation: Integer;
  procedure LoadProfGrid(List: TList);
  procedure LoadOptionProfGrid(List: Tlist);
  procedure LoadGroupGrid(List: TList);
  procedure LoadMedGrid(List: TList);
  procedure LoadGroupInProf(List: TList; PIndex: Pointer);
  procedure FillGroupAttr;
  procedure FillMedAttr;
  procedure FillProfAttr;
  procedure LoadMedComboBox;
  procedure LoadCodeGroupComboBox;
  procedure LoadMedListBox(Index: Integer);
  procedure DeleteFromMedList(FIndex, MIndex: Integer);
  procedure LoadGroupComboBox;
  function GetVisibleItem(List: Tlist; Typ: Integer): Integer;
  function GetItemIndex(List: Tlist; ID, Typ: Integer): Integer;
  function ValidType(Value: Variant; Typ: Integer): Boolean;
  function GetDBVersion: string;

var MedValidCount, GroupValidCount, ProfValidCount: Integer;
implementation

uses Owner, Report, OptionUnit;

{$R *.dfm}



procedure DeleteFromMedList(FIndex, MIndex: Integer);
begin
  TNykGVred(dDM.GetGVbyID(FIndex)).MedServLst.Delete(MIndex);
  LoadMedListBox(FIndex);
end;

procedure LoadMedListBox(Index: Integer);
var i: Integer;
begin
  fr_main.MedListBox.Clear;
  if GetVisibleItem(GVField, 1) > 0 then
  begin
  for i := 0 to TNykGVred(dDM.GetGVbyID(Index)).MedServLst.Count - 1 do
    begin
      fr_main.MedListBox.Items.Add(TNykMedService(TNykGVred(dDM.GetGVbyID(Index)).MedServLst.Items[i]).Name);
    end;
  end;
end;



procedure LoadMedComboBox;
var i: Integer;
begin
  fr_main.medComboBox.Clear;
  OptionForm.MComboBox.Clear;
  for i := 0 to MedSField.Count - 1 do
    begin
      if (TNykMedService(MedSField.Items[i]).State <> 0) and (TNykMedService(MedSField.Items[i]).State <> 4) then
        begin
          fr_main.medComboBox.Items.AddObject(TNykMedService(MedSField.Items[i]).Name, Pointer(TNykMedService(MedSField.Items[i]).Id));
          OptionForm.MComboBox.Items.AddObject(TNykMedService(MedSField.Items[i]).Name, Pointer(TNykMedService(MedSField.Items[i]).Id));
        end;
    end;
end;

procedure LoadGroupComboBox;
var i: Integer;
begin
  fr_main.GrComboBox.Clear;
  for i := 0 to GVField.Count - 1 do
    begin
      if (TNykGVred(GVField.Items[i]).State <> 0) and (TNykGVred(GVField.Items[i]).State <> 4) then
        begin
          fr_main.GrComboBox.Items.AddObject(TNykGVred(GVField.Items[i]).Code, Pointer(TNykGVred(GVField.Items[i]).Id));
        end;
    end;
end;

procedure LoadCodeGroupComboBox;
var i: Integer;
begin
  fr_main.CodeGrComboBox.Clear;
  for i := 0 to GVField.Count - 1 do
    begin
      if (TNykGVred(GVField.Items[i]).State <> 0) and (TNykGVred(GVField.Items[i]).State <> 4) then
        begin
          fr_main.CodeGrComboBox.Items.AddObject(TNykGVred(GVField.Items[i]).Name, Pointer(TNykGVred(GVField.Items[i]).Id));
        end;
    end;
end;
       
procedure FillMedAttr;
begin
  if GetVisibleItem(MedSField, 0) > 0 then
    begin
      fr_main.Edit1.Text  := TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).Name;
      fr_main.Edit2.Text  := FloatToStr(TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).price);
      fr_main.RadioGroup1.ItemIndex := TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).TypeItem;
      fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).MaleRecip;
    end
    else
    begin
      fr_main.MedGrid.SetFocus;
      fr_main.Edit1.Clear;
      fr_main.Edit2.Clear;
      fr_main.RadioGroup1.ItemIndex := 0;
      fr_main.RadioGroup2.ItemIndex := 0;
    end;
end;

procedure FillGroupAttr;
begin
  if GetVisibleItem(GVField, 1) > 0 then
    begin
      fr_main.Edit3.Text  := TNykGVred(dDM.GetGVbyID(Integer(fr_main.GroupGrid.Objects[0, fr_main.GroupGrid.Selection.Top]))).Code;
      fr_main.Edit4.Text  := TNykGVred(dDM.GetGVbyID(Integer(fr_main.GroupGrid.Objects[0, fr_main.GroupGrid.Selection.Top]))).Name;
    end
    else
    begin
      fr_main.GroupGrid.SetFocus;
      fr_main.Edit3.Clear;
      fr_main.Edit4.Clear;
    end;
end;

procedure FillProfAttr;
begin
  fr_main.Edit5.Clear;
  if ProfField.Count > 0 then
    begin
      fr_main.Edit5.Text  := TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0, fr_main.ProfGrid.Selection.Top]))).Name;
    end;
end;

procedure LoadProfGrid(List: TList);
var i: Integer;
    CountRow: Integer;
    a, b: Integer;
begin

   for i := 1 to List.Count do
     begin
       if (TNykProfession(ProfField.Items[i-1]).State <> 0) and (TNykProfession(ProfField.Items[i-1]).State <> 4) then
         begin
           fr_main.ProfGrid.Cells[0,i] := TNykProfession(ProfField.Items[i-1]).Name;
           fr_main.ProfGrid.Objects[0,i] := Pointer(TNykProfession(ProfField.Items[i-1]).Id);
           GroupY := TNykProfession(ProfField.Items[i-1]).Id;
           Break;
         end;
     end;


   for a := 0 to fr_main.ProfGrid.RowCount-1 do
   for b := 0 to fr_main.ProfGrid.ColCount-1 do
   begin
     fr_main.ProfGrid.Cells[b,a] := '';
   end;

   fr_main.ProfGrid.Cells[0,0] := 'Наименование';

   CountRow := GetVisibleItem(ProfField, 2);

   if CountRow = 0 then fr_main.ProfGrid.RowCount := 2
                   else fr_main.ProfGrid.RowCount := CountRow + 1;

   a := 0;
   for i := 1 to List.Count do
     begin
       if (TNykProfession(ProfField.Items[i-1]).State <> 0) and (TNykProfession(ProfField.Items[i-1]).State <> 4) then
         begin
           Inc(a);
           fr_main.ProfGrid.Cells[0,a] := TNykProfession(ProfField.Items[i-1]).Name;
           fr_main.ProfGrid.Objects[0,a] := Pointer(TNykProfession(ProfField.Items[i-1]).Id);
         end;
     end;


end;

procedure LoadOptionProfGrid(List: Tlist);
var i: Integer;
    tl: TStringList;
begin
  OptionForm.ListBox1.Clear;
  for i := 0 to List.Count - 1 do
    begin
      if (TNykProfession(List.Items[i]).State <> 0) and (TNykProfession(List.Items[i]).State <> 4) then
        begin
      tl := TStringList.Create;
      tl.Add(IntToStr(TNykProfession(ProfField.Items[i]).id));
      OptionForm.ListBox1.Items.AddObject(TNykProfession(ProfField.Items[i]).Name, tl);
       end;
     end;
end;

procedure LoadGroupInProf(List: TList; PIndex: Pointer);
var i: Integer;
   ts: TStringList;
begin
   fr_main.GrListBox.Clear;
   for i := 0 to TNykProfession(PIndex).GVredLst.Count - 1 do
     begin
       ts := TStringList.Create;
       ts.Add(IntToStr(TNykGVred(TNykProfession(PIndex).GVredLst.Items[i]).Id));
       fr_main.GrListBox.Items.AddObject(TNykGVred(TNykProfession(PIndex).GVredLst.Items[i]).Code
          + ' (' + TNykGVred(TNykProfession(PIndex).GVredLst.Items[i]).Name + ')', ts)
     end; 
end;

function GetVisibleItem(List: Tlist; Typ: Integer): Integer;
var i, k: Integer;
begin
  k := 0;
  Result := k;
  for i := 0 to List.Count - 1 do
    begin
      case Typ of
        0 : if (TNykMedService(List.Items[i]).State <> 0) and (TNykMedService(List.Items[i]).State <> 4) then Inc(k);
        1 : if (TNykGVred(List.Items[i]).State <> 0) and (TNykGVred(List.Items[i]).State <> 4) then Inc(k);
        2 : if (TNykProfession(List.Items[i]).State <> 0) and (TNykProfession(List.Items[i]).State <> 4) then Inc(k)
      end;

    end;
  Result := k;
end;

function GetItemIndex(List: Tlist; ID, Typ: Integer): Integer;
var i, k: Integer;
begin
  k := -1;
  Result := k;
  for i := 0 to List.Count - 1 do
    begin
      case Typ of
        0 : begin
              if (TNykMedService(List.Items[i]).Id = ID) then
              if (TNykMedService(List.Items[i]).State <> 0) and (TNykMedService(List.Items[i]).State <> 4) then Result := i;
            end;
        1 : begin
              if (TNykGVred(List.Items[i]).Id = ID) then
              if (TNykGVred(List.Items[i]).State <> 0) and (TNykGVred(List.Items[i]).State <> 4) then Result := i;
            end;

        2 : begin
              if (TNykProfession(List.Items[i]).Id = ID) then
              if (TNykProfession(List.Items[i]).State <> 0) and (TNykProfession(List.Items[i]).State <> 4) then Result := i;
            end;
      end;
    end;
end;

procedure LoadMedGrid(List: TList);
var i: Integer;
    CountRow: Integer;
    a, b: Integer;
begin

   for a := 0 to fr_main.MedGrid.RowCount-1 do
   for b := 0 to fr_main.MedGrid.ColCount-1 do
   begin
     fr_main.MedGrid.Cells[b,a] := '';
   end;

   fr_main.MedGrid.Cells[0,0] := 'Наименование';
   fr_main.MedGrid.Cells[1,0] := 'Вид';
   fr_main.MedGrid.Cells[2,0] := 'Стоимость';
   fr_main.MedGrid.Cells[3,0] := 'Назначение';

   CountRow := GetVisibleItem(MedSField, 0);

   if CountRow = 0 then fr_main.MedGrid.RowCount := 2
                   else fr_main.MedGrid.RowCount := CountRow + 1;

   a := 0;
   for i := 0 to List.Count - 1 do
     begin
       if (TNykMedService(MedSField.Items[i]).State <> 0) and (TNykMedService(MedSField.Items[i]).State <> 4) then
         begin
         Inc(a);
           fr_main.MedGrid.Cells[0,a] := TNykMedService(MedSField.Items[i]).Name;
           case TNykMedService(MedSField.Items[i]).TypeItem of
             0 : fr_main.MedGrid.Cells[1,a] := 'Прием';
             1 : fr_main.MedGrid.Cells[1,a] := 'Процедура';
           end;
           case TNykMedService(MedSField.Items[i]).MaleRecip of
             0 : fr_main.MedGrid.Cells[3,a] := 'Для женщин';
             1 : fr_main.MedGrid.Cells[3,a] := 'Для мужчин';
             2 : fr_main.MedGrid.Cells[3,a] := 'Для всех';
           end;
           fr_main.MedGrid.Cells[2,a] := FloatToStr(TNykMedService(MedSField.Items[i]).price);
           fr_main.MedGrid.Objects[0,a] := Pointer(TNykMedService(MedSField.Items[i]).Id);
         end;

     end;

      //fr_main.Caption := IntToStr(Integer(fr_main.MedGrid.Objects[0,1]));
end;

procedure LoadGroupGrid(List: TList);
var i: Integer;
    CountRow: Integer;
    a, b: Integer;
begin

   for i := 1 to List.Count do
     begin
       if (TNykGVred(GVField.Items[i-1]).State <> 0) and (TNykGVred(GVField.Items[i-1]).State <> 4) then
         begin
           fr_main.GroupGrid.Cells[0,i] := TNykGVred(GVField.Items[i-1]).Code;
           fr_main.GroupGrid.Cells[1,i] := TNykGVred(GVField.Items[i-1]).Name;
           fr_main.GroupGrid.Objects[0,i] := Pointer(TNykGVred(GVField.Items[i-1]).Id);
           GroupY := TNykGVred(GVField.Items[i-1]).Id;
           Break;
         end;
     end;


   for a := 0 to fr_main.GroupGrid.RowCount-1 do
   for b := 0 to fr_main.GroupGrid.ColCount-1 do
   begin
     fr_main.GroupGrid.Cells[b,a] := '';
   end;

   fr_main.GroupGrid.Cells[0,0] := 'Наименование';
   fr_main.GroupGrid.Cells[1,0] := 'Код';

   CountRow := GetVisibleItem(GVField, 1);

   if CountRow = 0 then fr_main.GroupGrid.RowCount := 2
                   else fr_main.GroupGrid.RowCount := CountRow + 1;

   a := 0;
   for i := 1 to List.Count do
     begin
       if (TNykGVred(GVField.Items[i-1]).State <> 0) and (TNykGVred(GVField.Items[i-1]).State <> 4) then
         begin
           Inc(a);
           fr_main.GroupGrid.Cells[0,a] := TNykGVred(GVField.Items[i-1]).Code;
           fr_main.GroupGrid.Cells[1,a] := TNykGVred(GVField.Items[i-1]).Name;
           fr_main.GroupGrid.Objects[0,a] := Pointer(TNykGVred(GVField.Items[i-1]).Id);
         end;
     end;

end;

////////////////////////////////////////////////////////////////////////////////

procedure Tfr_main.FormCreate(Sender: TObject);
begin
  prognam:='';
  progvers:='';
  exe_path:=ExtractFilePath(Application.EXEName);
  FinalGrid := TStringGrid.Create(nil);
  FinalGrid.RowCount := 0;
  FinalGrid.ColCount := 0;
  GetVersionInfo;
  Caption:=prognam+', © ЗАО "РУСИНТЕЛ", 2007 г.      v. '+progvers;
  if GetDBVersion<>progvers then
    begin
      MessageDlg('Версия программы не совместима с версией БД.', mtError, [mbOk], 0);
      Application.Terminate;
    end;
end;

function GetDBVersion: string;
var Ini: TIniFile;
begin
  Result := '';
  try
    Ini := TIniFile.Create(GetCurrentDir + '\database.ini');
    Result := Ini.ReadString('SystemInfo', 'BaseVersion', '');
    Ini.Free;
  except
    Result := '';
  end;

end;

procedure Tfr_main.GetVersionInfo;
var
  loc_InfoBufSize : integer;
  loc_InfoBuf     : PChar;
  loc_VerBufSize  : integer;
  loc_VerBuf      : PChar;
  FLangID         :string;
  FExeName        :string;
Begin
  FExeName:=Application.ExeName;
  FLangID:='041904E3';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FExeName),DWORD(loc_InfoBufSize));
  if loc_InfoBufSize > 0 then
  begin
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    GetFileVersionInfo(PChar(FExeName),0,loc_InfoBufSize,loc_InfoBuf);

    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\FileVersion'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
    progvers:=loc_VerBuf;

    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\ProductName'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
    prognam:=loc_VerBuf;

    FreeMem(loc_InfoBuf, loc_InfoBufSize);
  end;
end;


procedure Tfr_main.FormShow(Sender: TObject);
//var Rect: TGridRect;
begin
  LoadMedGrid(MedSField);
  LoadGroupGrid(GVField);
  LoadProfGrid(ProfField);
  LoadMedComboBox;
  LoadGroupComboBox;
  LoadCodeGroupComboBox;

      if GVField.Count > 0 then
        begin
          fr_main.Edit3.Text  := fr_main.GroupGrid.Cells[0, 1];
          fr_main.Edit4.Text  := fr_main.GroupGrid.Cells[1, 1];
        end;

      if MedSField.Count > 0 then
        begin
          fr_main.Edit1.Text  := fr_main.MedGrid.Cells[0, 1];
          fr_main.Edit2.Text  := fr_main.MedGrid.Cells[2, 1];
          fr_main.RadioGroup1.ItemIndex := TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).TypeItem;
          fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID(Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]))).MaleRecip;
          if fr_main.MedGrid.Cells[2, 1] = 'Прием' then fr_main.RadioGroup1.ItemIndex := 0;
          if fr_main.MedGrid.Cells[2, 1] = 'Процедура' then fr_main.RadioGroup1.ItemIndex := 1;
        end;

      if ProfField.Count > 0 then
        begin
          fr_main.Edit5.Text  := fr_main.ProfGrid.Cells[0, 1];
          LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top])));
        end;
end;

procedure Tfr_main.MedGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  MedY := Integer(fr_main.MedGrid.Objects[0, ARow]);
  MedIndex := ARow;
end;

procedure Tfr_main.SpeedButton1Click(Sender: TObject);
begin
  fr_main.MedGrid.Enabled := False;
  fr_main.SpeedButton1.Enabled := False;
  fr_main.SpeedButton2.Enabled := False;
  fr_main.SpeedButton3.Enabled := False;
  fr_main.Edit1.Clear;
  fr_main.Edit2.Clear;
  fr_main.RadioGroup1.ItemIndex := 0;
  fr_main.SpeedButton7.Enabled := True;
  fr_main.SpeedButton8.Enabled := True;
  fr_main.TabSheet2.TabVisible := False;
  fr_main.TabSheet3.TabVisible := False;
  Operation := 1;
end;

procedure Tfr_main.SpeedButton9Click(Sender: TObject);
var PName: string;
    PCode: string;
   // IDSave: Integer;
    Rect: TGridRect;
begin
  fr_main.GroupGrid.Enabled := True;
  fr_main.SpeedButton9.Enabled := False;
  fr_main.SpeedButton10.Enabled := False;
  fr_main.SpeedButton4.Enabled := True;
  fr_main.SpeedButton5.Enabled := True;
  fr_main.SpeedButton6.Enabled := True;
  fr_main.TabSheet1.TabVisible := True;
  fr_main.TabSheet3.TabVisible := True;

  if Operation = 1 then
    begin
     if (fr_main.Edit3.Text <> '') and (fr_main.Edit4.Text <> '') then
     begin
     dDM.NewGV(fr_main.Edit3.Text, fr_main.Edit4.Text);
     LoadGroupGrid(GVField);
     Rect.Top := fr_main.GroupGrid.RowCount - 1;
     Rect.Left := 0;
     Rect.Right := 1;
     Rect.Bottom := fr_main.GroupGrid.RowCount - 1;
     fr_main.GroupGrid.Selection := Rect;
     fr_main.Edit3.Text  := TNykGVred(dDM.GetGVbyID(TNykGVred(GVField.Items[GVField.Count-1]).Id)).Code;
     fr_main.Edit4.Text  := TNykGVred(dDM.GetGVbyID(TNykGVred(GVField.Items[GVField.Count-1]).Id)).Name;
     needsave := True;
     GroupY := Integer(fr_main.GroupGrid.Objects[0,fr_main.GroupGrid.Selection.Top]);
     LoadMedListBox(GroupY);
     end;
    end;

  if Operation = 2 then
    begin
     if (fr_main.Edit3.Text <> '') and (fr_main.Edit4.Text <> '') then
     begin
     PName := fr_main.Edit4.Text;
     PCode := fr_main.Edit3.Text;
     GroupY := Integer(fr_main.GroupGrid.Objects[0,fr_main.GroupGrid.Selection.Top]);
     TNykGVred(dDM.GetGVbyID(GroupY)).ReName(PName);
     TNykGVred(dDM.GetGVbyID(GroupY)).ReCode(PCode);
     fr_main.Edit3.Text  := TNykGVred(dDM.GetGVbyID(GroupY)).Code;
     fr_main.Edit4.Text  := TNykGVred(dDM.GetGVbyID(GroupY)).Name;
     LoadGroupGrid(GVField);
     GroupY := Integer(fr_main.GroupGrid.Objects[0,fr_main.GroupGrid.Selection.Top]);
     needsave := True;
     end;
    end;

  LoadGroupComboBox;
  LoadCodeGroupComboBox;
  GroupGrid.SetFocus;
end;

procedure Tfr_main.SpeedButton10Click(Sender: TObject);
begin
  fr_main.GroupGrid.Enabled := True;
  fr_main.SpeedButton9.Enabled := False;
  fr_main.SpeedButton10.Enabled := False;
  fr_main.SpeedButton4.Enabled := True;
  fr_main.SpeedButton5.Enabled := True;
  fr_main.SpeedButton6.Enabled := True;
  fr_main.TabSheet1.TabVisible := True;
  fr_main.TabSheet3.TabVisible := True;

  fr_main.GroupGrid.SetFocus;
  if GetVisibleItem(GVField, 1) > 0 then
    begin
      fr_main.Edit3.Text  := fr_main.GroupGrid.Cells[0, GroupY];
      fr_main.Edit4.Text  := fr_main.GroupGrid.Cells[1, GroupY];
    end;
end;

procedure Tfr_main.SpeedButton5Click(Sender: TObject);
begin
  if GetVisibleItem(GVField, 1) > 0 then
    begin
      fr_main.GroupGrid.Enabled := False;
      fr_main.SpeedButton4.Enabled := False;
      fr_main.SpeedButton5.Enabled := False;
      fr_main.SpeedButton6.Enabled := False;
      fr_main.SpeedButton9.Enabled := True;
      fr_main.SpeedButton10.Enabled := True;
      fr_main.TabSheet1.TabVisible := False;
      fr_main.TabSheet3.TabVisible := False;
      Operation := 2;
    end;
end;

procedure Tfr_main.SpeedButton6Click(Sender: TObject);
begin
  if GetVisibleItem(GVField, 1) > 0 then
    begin
      GroupY := Integer(fr_main.GroupGrid.Objects[0,fr_main.GroupGrid.Selection.Top]);
      TNykGVred(dDM.GetGVbyID(GroupY)).Delete;
      LoadGroupGrid(GVField);
      LoadMedListBox(GroupY);
      GroupY := Integer(fr_main.GroupGrid.Objects[0,fr_main.GroupGrid.Selection.Top]);
      needsave := True;
    end;
  fr_main.Edit3.Clear;
  fr_main.Edit4.Clear;
  fr_main.MedListBox.Clear;
  if fr_main.GroupGrid.Cells[0, fr_main.GroupGrid.Selection.Top] <> '' then
    begin
      FillGroupAttr;
      LoadMedListBox(GroupY);
    end;
  LoadGroupComboBox;
  LoadCodeGroupComboBox;
end;

/////////////////////////////////////////////////////
procedure Tfr_main.SpeedButton4Click(Sender: TObject);
begin
  fr_main.GroupGrid.Enabled := False;
  fr_main.SpeedButton4.Enabled := False;
  fr_main.SpeedButton5.Enabled := False;
  fr_main.SpeedButton6.Enabled := False;
  fr_main.Edit3.Clear;
  fr_main.Edit4.Clear;
  fr_main.SpeedButton9.Enabled := True;
  fr_main.SpeedButton10.Enabled := True;
  fr_main.TabSheet1.TabVisible := False;
  fr_main.TabSheet3.TabVisible := False;
  Operation := 1;
end;

procedure Tfr_main.SpeedButton2Click(Sender: TObject);
begin
  if GetVisibleItem(MedSField, 0) > 0 then
    begin
      fr_main.MedGrid.Enabled := False;
      fr_main.SpeedButton1.Enabled := False;
      fr_main.SpeedButton2.Enabled := False;
      fr_main.SpeedButton3.Enabled := False;
      fr_main.SpeedButton7.Enabled := True;
      fr_main.SpeedButton8.Enabled := True;
      fr_main.TabSheet2.TabVisible := False;
      fr_main.TabSheet3.TabVisible := False;
      Operation := 2;
    end;
end;

procedure Tfr_main.SpeedButton3Click(Sender: TObject);
var i, k: Integer;
begin
  if GetVisibleItem(MedSField, 0) > 0 then
    begin
      MedY := Integer(fr_main.MedGrid.Objects[0,fr_main.MedGrid.Selection.Top]);
      TNykMedService(dDM.GetMedSbyID(MedY)).Delete;
      LoadMedGrid(MedSField);
      MedY := Integer(fr_main.MedGrid.Objects[0,fr_main.MedGrid.Selection.Top]);
      needsave := True;
    end;

      for i := 0 to GVField.Count - 1 do
        begin
          k := 0;
          while k < TNykGVred(GVField.Items[i]).MedServLst.Count do
            begin
              if TNykMedService(TNykGVred(GVField.Items[i]).MedServLst.Items[k]).Id = MedY then
                 begin
                   Dec(k);
                   TNykGVred(GVField.Items[i]).MedServLst.Delete(k);
                 end;
              Inc(k);
            end;
        end;


  FillMedAttr;
  LoadMedComboBox;
end;

procedure Tfr_main.SpeedButton7Click(Sender: TObject);
var PName: string;
    PType: Integer;
    PPrice: Real;
    PRecip: Integer;
    Rect: TGridRect;
begin
  fr_main.MedGrid.Enabled := True;
  fr_main.SpeedButton7.Enabled := False;
  fr_main.SpeedButton8.Enabled := False;
  fr_main.SpeedButton1.Enabled := True;
  fr_main.SpeedButton2.Enabled := True;
  fr_main.SpeedButton3.Enabled := True;
  fr_main.TabSheet2.TabVisible := True;
  fr_main.TabSheet3.TabVisible := True;

  if Operation = 1 then
    begin
     if (fr_main.Edit1.Text <> '') and (fr_main.Edit2.Text <> '') then
     begin
       if ValidType(fr_main.Edit2.Text, 1) then
         begin
           if fr_main.RadioGroup2.ItemIndex = 0 then dDM.NewMS(fr_main.RadioGroup1.ItemIndex, fr_main.RadioGroup2.ItemIndex, fr_main.Edit1.Text, StrToFloat(fr_main.Edit2.Text))
                                                else dDM.NewMS(fr_main.RadioGroup1.ItemIndex, fr_main.RadioGroup2.ItemIndex+1, fr_main.Edit1.Text, StrToFloat(fr_main.Edit2.Text));
           LoadMedGrid(MedSField);
           Rect.top := fr_main.MedGrid.RowCount - 1;
           Rect.Left := 0;
           Rect.Right := 2;
           Rect.Bottom := fr_main.MedGrid.RowCount - 1;
           fr_main.MedGrid.Selection := Rect;

           fr_main.Edit1.Text  := TNykMedService(dDM.GetMedSbyID(TNykMedService
                              (MedSField.Items[MedSField.Count - 1]).Id)).Name;

           fr_main.Edit2.Text  := FloatToStr(TNykMedService(dDM.GetMedSbyID
            (TNykMedService(MedSField.Items[MedSField.Count - 1]).Id)).price);

           fr_main.RadioGroup1.ItemIndex := TNykMedService(dDM.GetMedSbyID
             (TNykMedService(MedSField.Items[MedSField.Count - 1]).Id)).TypeItem;

           if TNykMedService(dDM.GetMedSbyID
             (TNykMedService(MedSField.Items[MedSField.Count - 1]).Id)).MaleRecip = 2 then
           fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID
             (TNykMedService(MedSField.Items[MedSField.Count - 1]).Id)).MaleRecip - 1 else
           fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID
             (TNykMedService(MedSField.Items[MedSField.Count - 1]).Id)).MaleRecip;
           needsave := True;
         end;

     end;
    end;

  if Operation = 2 then
    begin
     if (fr_main.Edit1.Text <> '') and (fr_main.Edit2.Text <> '') then
     begin
            if ValidType(fr_main.Edit2.Text, 1) then
         begin
     PName := fr_main.Edit1.Text;
     PType := fr_main.RadioGroup1.ItemIndex;
     PPrice := StrToFloat(fr_main.Edit2.Text);
     if fr_main.RadioGroup2.ItemIndex = 0 then PRecip := fr_main.RadioGroup2.ItemIndex
                                          else PRecip := fr_main.RadioGroup2.ItemIndex + 1;

     MedY := Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]);

     TNykMedService(dDM.GetMedSbyID(MedY)).ReName(PName);
     TNykMedService(dDM.GetMedSbyID(MedY)).RePrice(PPrice);
     TNykMedService(dDM.GetMedSbyID(MedY)).ReType(PType);
     TNykMedService(dDM.GetMedSbyID(MedY)).ReMaleRecip(PRecip);

     fr_main.Edit1.Text  := TNykMedService(dDM.GetMedSbyID(MedY)).Name;
     fr_main.Edit2.Text  := FloatToStr(TNykMedService(dDM.GetMedSbyID(MedY)).price);
     fr_main.RadioGroup1.ItemIndex := TNykMedService(dDM.GetMedSbyID(MedY)).TypeItem;
     if TNykMedService(dDM.GetMedSbyID(MedY)).MaleRecip = 2 then
     fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID(MedY)).MaleRecip - 1
                                                            else
     fr_main.RadioGroup2.ItemIndex := TNykMedService(dDM.GetMedSbyID(MedY)).MaleRecip;                                                       
     LoadMedGrid(MedSField);
     MedY := Integer(fr_main.MedGrid.Objects[0, fr_main.MedGrid.Selection.Top]);
     needsave := True;
     end;
     end;
    end;

  LoadMedComboBox;
  MedGrid.SetFocus;
end;

procedure Tfr_main.SpeedButton8Click(Sender: TObject);
begin
  fr_main.MedGrid.Enabled := True;
  fr_main.SpeedButton7.Enabled := False;
  fr_main.SpeedButton8.Enabled := False;
  fr_main.SpeedButton1.Enabled := True;
  fr_main.SpeedButton2.Enabled := True;
  fr_main.SpeedButton3.Enabled := True;
  fr_main.TabSheet2.TabVisible := True;
  fr_main.TabSheet3.TabVisible := True;

  fr_main.MedGrid.SetFocus;
  if GetVisibleItem(MedSField, 0) > 0 then
    begin
      fr_main.Edit1.Text  := TNykMedService(MedSField.Items[GetItemIndex(MedSField, MedY, 0)]).Name;
      fr_main.Edit2.Text  := FloatToStr(TNykMedService(MedSField.Items[GetItemIndex(MedSField, MedY, 0)]).price);
      fr_main.RadioGroup1.ItemIndex := TNykMedService(dDM.GetMedSbyID(MedY)).TypeItem;
    end;
end;

procedure Tfr_main.TabSheet1Show(Sender: TObject);
begin
  MedGrid.SetFocus;
end;

procedure Tfr_main.TabSheet2Show(Sender: TObject);
begin
  GroupGrid.SetFocus;
end;

procedure Tfr_main.GroupGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  GroupY := Integer(fr_main.GroupGrid.Objects[0, ARow]);
  LoadMedListBox(GroupY);
end;

procedure Tfr_main.MedSpeedButtonClick(Sender: TObject);
var i:Integer; Flag: Boolean;
begin
if (GVField.Count > 0) then
 begin
  if (fr_main.medComboBox.ItemIndex <> -1) then
    begin
      Flag := False;
      for i := 0 to TNykGVred(dDM.GetGVbyID(GroupY)).MedServLst.Count - 1 do
        begin
          if TNykMedService(TNykGVred(dDM.GetGVbyID(GroupY)).MedServLst.Items[i]).Id =
             Integer(fr_main.medComboBox.Items.Objects[fr_main.medComboBox.ItemIndex])
             then  Flag := True;
        end;
      if Flag = False then
        begin
          TNykGVred(dDM.GetGVbyID(GroupY)).AddMedServiceItem(dDM.GetMedSbyID(Integer(fr_main.medComboBox.Items.Objects[fr_main.medComboBox.ItemIndex])));
          dDM.LoadProfession;
          LoadMedListBox(GroupY);
          fr_main.medComboBox.ItemIndex := -1;
          needsave := True;
        end
        else
        begin
          MessageDlg('Уже состоит в этой группе!', mtInformation, [mbOk], 0);
        end;
    end
    else
    begin
      MessageDlg('Не выбрана мед. услуга!', mtInformation, [mbOk], 0);
    end;
 end
 else
 begin
   MessageDlg('Список групп пуст!', mtInformation, [mbOk], 0);
 end;
end;

procedure Tfr_main.MedListBoxDblClick(Sender: TObject);
begin
  DeleteFromMedList(GroupY, fr_main.MedListBox.ItemIndex);
  needsave := True;
end;

procedure Tfr_main.GrSpeedButtonClick(Sender: TObject);
var i: Integer; Flag: Boolean;
begin
 if fr_main.RadioButton1.Checked then
     begin
  if ProfField.Count > 0 then
    begin
  if (fr_main.GrComboBox.ItemIndex <> -1) then
     begin
       Flag := False;
       for i := 0 to TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).GVredLst.Count - 1 do
        begin
          if TNykGVred(TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).GVredLst.Items[i]).Id =
             Integer(fr_main.GrComboBox.Items.Objects[fr_main.GrComboBox.ItemIndex])
             then  Flag := True;
        end;
        if Flag = False then
          begin
            NeedSave := True;
            TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).AddGVredItem(GVField.Items[fr_main.GrComboBox.ItemIndex]);
            LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top])));
          end
          else
          begin
            MessageDlg('Профессия уже включена в эту группу!', mtInformation, [mbOk], 0);
          end;
     end
     else
     begin
       MessageDlg('Не выбрана группа!', mtInformation, [mbOk], 0);
     end;
     end
     else
     begin
       MessageDlg('Нет профессий!', mtInformation, [mbOk], 0);
     end;
        fr_main.GrComboBox.ItemIndex := -1;
    end;

   if fr_main.RadioButton2.Checked then
     begin
       if ProfField.Count > 0 then
    begin
  if (fr_main.CodeGrComboBox.ItemIndex <> -1) then
     begin
       Flag := False;
       for i := 0 to TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).GVredLst.Count - 1 do
        begin
          if TNykGVred(TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).GVredLst.Items[i]).Id =
             Integer(fr_main.CodeGrComboBox.Items.Objects[fr_main.CodeGrComboBox.ItemIndex])
             then  Flag := True;
        end;
        if Flag = False then
          begin
            NeedSave := True;
            TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).AddGVredItem(GVField.Items[fr_main.CodeGrComboBox.ItemIndex]);
            LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top])));
          end
          else
          begin
            MessageDlg('Профессия уже включена в эту группу!', mtInformation, [mbOk], 0);
          end;
     end
     else
     begin
       MessageDlg('Не выбрана группа!', mtInformation, [mbOk], 0);
     end;
     end
     else
     begin
       MessageDlg('Нет профессий!', mtInformation, [mbOk], 0);
     end;
       fr_main.CodeGrComboBox.ItemIndex := -1;
     end;

end;

procedure Tfr_main.ProfListBoxClick(Sender: TObject);
begin
  //LoadGroupInProf(ProfField, fr_main.ProfListBox.ItemIndex);
//  FillProfAttr;
 // fr_main.Caption := TStringList(fr_main.ProfListBox.Items.Objects[fr_main.ProfListBox.ItemIndex]).Strings[0];
end;

procedure Tfr_main.N2Click(Sender: TObject);
begin
  fr_main.Enabled := False;
  OwnerForm.Show;
end;

procedure Tfr_main.MSpeedButtonClick(Sender: TObject);
var i: Integer; Flag: Boolean;
begin

end;

procedure Tfr_main.SpeedButton11Click(Sender: TObject);
begin
  fr_main.SpeedButton11.Enabled := False;
  fr_main.SpeedButton12.Enabled := False;
  fr_main.SpeedButton13.Enabled := False;
  fr_main.Panel16.Enabled := False;
  fr_main.Edit5.Clear;
  fr_main.SpeedButton14.Enabled := True;
  fr_main.SpeedButton15.Enabled := True;
  fr_main.TabSheet1.TabVisible := False;
  fr_main.TabSheet2.TabVisible := False;
  Operation := 1;
end;

procedure Tfr_main.SpeedButton12Click(Sender: TObject);
begin
if ProfField.Count > 0 then
  begin
    fr_main.SpeedButton11.Enabled := False;
    fr_main.SpeedButton12.Enabled := False;
    fr_main.SpeedButton13.Enabled := False;
    fr_main.Panel16.Enabled := False;
    fr_main.SpeedButton14.Enabled := True;
    fr_main.SpeedButton15.Enabled := True;
    fr_main.TabSheet1.TabVisible := False;
    fr_main.TabSheet2.TabVisible := False;
    Operation := 2;
  end;
end;

procedure Tfr_main.SpeedButton15Click(Sender: TObject);
begin

  fr_main.SpeedButton14.Enabled := False;
  fr_main.SpeedButton15.Enabled := False;
  fr_main.SpeedButton11.Enabled := True;
  fr_main.SpeedButton12.Enabled := True;
  fr_main.SpeedButton13.Enabled := True;
  fr_main.Panel16.Enabled := True;
  fr_main.TabSheet1.TabVisible := True;
  fr_main.TabSheet2.TabVisible := True;

  {if MedSField.Count > 0 then
    begin }
     FillProfAttr;
    //end;
end;

procedure Tfr_main.SpeedButton14Click(Sender: TObject);
var PName: string;
    PCount: Integer;
    SaveIndex: Integer;
begin
  fr_main.SpeedButton14.Enabled := False;
  fr_main.SpeedButton15.Enabled := False;
  fr_main.SpeedButton11.Enabled := True;
  fr_main.SpeedButton12.Enabled := True;
  fr_main.SpeedButton13.Enabled := True;
  fr_main.Panel16.Enabled := True;
  fr_main.TabSheet1.TabVisible := True;
  fr_main.TabSheet2.TabVisible := True;

  if Operation = 1 then
    begin
      if (fr_main.Edit5.Text <> '') then
        begin
          dDM.NewPrf(fr_main.Edit5.Text, 0);
          LoadProfGrid(ProfField);
          fr_main.Edit5.Clear;
          FillProfAttr;
          NeedSave := True;
        end;
    end;

  if Operation = 2 then
    begin
      if (fr_main.Edit5.Text <> '') then
        begin
          PName := fr_main.Edit5.Text;
          TNykProfession(dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]))).ReName(PName);
          LoadProfGrid(ProfField);
          NeedSave := True;
       end;
    end;
FillProfAttr;
end;

procedure Tfr_main.N7Click(Sender: TObject);
begin
 fr_main.Close;
end;

procedure Tfr_main.SpeedButton18Click(Sender: TObject);
var i: Integer;
begin
{ if fr_main.MListBox.Count > 0 then
 begin
  for i := 0 to fr_main.MListBox.Count - 1 do
    begin
      TNykProfession(ProfField.Items[fr_main.ProfListBox.ItemIndex])
      .DelMedServiceItem(TNykMedService(TNykProfession(ProfField.Items[fr_main.ProfListBox.ItemIndex])
      .MedServLst.Items[0]).Id);
    end;
  LoadGroupInProf(ProfField, fr_main.ProfListBox.ItemIndex);
  end; }
end;

{function CheckExists(List: TList; Typ, ID: Integer): Boolean;
var i: Integer;
    Count: Integer;
begin
  Result := True;
  case Typ of
    0 : begin
          Count := TNykMedService()
        end;
    1 : begin
        end;
    2 : begin
        end;
  end;              
  for i := 0 to
end; }

function ValidType(Value: Variant; Typ: Integer): Boolean;
var VInteger: Integer;
    VReal: Real; 
begin
  Result := False;
  case Typ of
     0 : begin
           try
             VInteger := StrToInt(Value);
             Result := True;
           except on E:Exception do
             begin
               MessageDlg('Значение "'+Value+'" не корректно!', mtInformation, [mbOk], 0);
             end;
             
           end
         end;
     1 : begin
           try
             VReal := StrToFloat(Value);
             Result := True;
           except on E:Exception do
             begin
               MessageDlg('Значение "'+Value+'" не корректно!', mtInformation, [mbOk], 0);
             end;
           end     
         end;
  end;
end;

procedure Tfr_main.N5Click(Sender: TObject);
begin
  //ReportForm.QuickRep2.Preview;
  If StartReport(2)=1 Then MessageDlg('Ошибка печати или принтер не доступен.', mtError,[mbOk], 0);
end;

procedure Tfr_main.N6Click(Sender: TObject);
begin
  //ReportForm.QuickRep3.Preview;
  If StartReport(3)=1 Then MessageDlg('Ошибка печати или принтер не доступен.', mtError,[mbOk], 0);
end;

procedure Tfr_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if needsave then
    begin
    if MessageDlg('Сохранить изменения?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dDM.SaveAlltoINI;
  end
  else
  begin
    needsave := False;
  end;
  end;
end;

procedure Tfr_main.C1Click(Sender: TObject);
begin
   if needsave then
     begin
    if MessageDlg('Сохранить изменения?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dDM.SaveAlltoINI;
    needsave := False;
  end;
  end;
end;

procedure Tfr_main.RadioButton1Click(Sender: TObject);
begin
 if fr_main.RadioButton1.Checked then
   begin
     fr_main.GrComboBox.Enabled := True;
     fr_main.CodeGrComboBox.Enabled := False;
   end;
end;

procedure Tfr_main.RadioButton2Click(Sender: TObject);
begin
 if fr_main.RadioButton2.Checked then
   begin
     fr_main.CodeGrComboBox.Enabled := True;
     fr_main.GrComboBox.Enabled := False;
   end;
end;

procedure Tfr_main.ProfGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0, ARow])));
end;

procedure Tfr_main.MedGridClick(Sender: TObject);
begin
  FillMedAttr;
end;

procedure Tfr_main.GroupGridClick(Sender: TObject);
begin
  FillGroupAttr;
end;

procedure Tfr_main.SpeedButton13Click(Sender: TObject);
begin
  if GetVisibleItem(ProfField, 2) > 0 then
    begin
      GroupY := Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]);
      TNykProfession(dDM.GetPRbyID(GroupY)).Delete;
      LoadProfGrid(ProfField);
      GroupY := Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]);
      needsave := True;
    end;
  fr_main.Edit5.Clear;
  fr_main.GrListBox.Clear;
  if fr_main.ProfGrid.Cells[0, fr_main.ProfGrid.Selection.Top] <> '' then
    begin
      FillProfAttr;
      LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0, fr_main.ProfGrid.Selection.Top])));
    end;
end;

procedure Tfr_main.GrListBoxDblClick(Sender: TObject);
var i, k, g, CurVred: Integer;
    CurProf: Pointer;
begin
  CurProf := dDm.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0,fr_main.ProfGrid.Selection.Top]));
  CurVred := StrToInt(TStringList(fr_main.GrListBox.Items.Objects[fr_main.GrListBox.ItemIndex]).Strings[0]);
  TNykProfession(CurProf).DelGVredItem(CurVred);
  LoadGroupInProf(ProfField, dDM.GetPRbyID(Integer(fr_main.ProfGrid.Objects[0, fr_main.ProfGrid.Selection.Top])));
  NeedSave := True;
end;

procedure Tfr_main.ProfGridClick(Sender: TObject);
begin
FillProfAttr;
end;

procedure Tfr_main.N8Click(Sender: TObject);
var i, k: Integer;  p: Pointer;
    Test: string;
begin
 OptionForm.Show;
 ButonCorrect;
 for k := 0 to ProfField.Count - 1 do
   begin
     TNykProfession(ProfField.Items[k]).MedServOutLst.Clear;
     Test := TNykProfession(ProfField.Items[k]).Name;
       for i := 0 to TNykProfession(ProfField.Items[k]).MedServLst.Count - 1 do
         begin
           TNykProfession(ProfField.Items[k]).MedServOutLst.Add(TNykProfession(ProfField.Items[k]).MedServLst.Items[i]);
         end;
   end;
 LoadOptionProfGrid(ProfField);
 fr_main.Enabled := False;
 OptionForm.GroupBox2.Visible := False;
end;

procedure Tfr_main.N4Click(Sender: TObject);
var i, k: Integer;  p: Pointer;
    Test: string;
begin
 OptionForm.Show;
 ButonCorrect;
 for k := 0 to ProfField.Count - 1 do
   begin
     TNykProfession(ProfField.Items[k]).MedServOutLst.Clear;
     Test := TNykProfession(ProfField.Items[k]).Name;
       for i := 0 to TNykProfession(ProfField.Items[k]).MedServLst.Count - 1 do
         begin
           TNykProfession(ProfField.Items[k]).MedServOutLst.Add(TNykProfession(ProfField.Items[k]).MedServLst.Items[i]);
         end;
   end;
 LoadOptionProfGrid(ProfField);
 fr_main.Enabled := False;
end;

end.
