unit OptionUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Grids, DM, ValEdit,
  Excel2000, ComObj;

type
  TOptionForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    ListBox1: TListBox;
    SpeedButton2: TSpeedButton;
    ListBox2: TListBox;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    MComboBox: TComboBox;
    SpeedButton4: TSpeedButton;
    StringGrid1: TStringGrid;
    SpeedButton5: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionForm: TOptionForm;
  Routine : Integer;
  Excel: Variant;
  function MyFormatLine(const Key, Value: string): string;
  procedure DoListBox;
  procedure DoListBoxGrid;
  procedure ButonCorrect;
  procedure Summ;
  function StartExcelReport: Boolean;
  function PaintReportTitle: Boolean;
  function DoReportMarking: Boolean;
  function DoReportPageSetup: Boolean;
  function PutSumma(X,Y: Integer; Summa:Real): Boolean;
  function PutServiceName(X,Y: Integer; SName:string): Boolean;
  function PutCostService(X,Y: Integer; Cost:Real): Boolean;
  function PutProfName(X,Y: Integer; PName:string): Boolean;
  function Calculate(CalcGrid: TStringGrid): Boolean;
  function Ramka(X, Y: Integer): Boolean;
  procedure DeleteRowFromGird(Sender: TObject);

implementation

uses Main, Report;

{$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
function StartExcelReport: Boolean;
var Param: OleVariant; i: Integer;
begin
  try
    Excel := CreateOLEObject('Excel.Application');
    Excel.WorkBooks.Add;
    Excel.Visible := True;

    DoReportPageSetup;
    PaintReportTitle;
    DoReportMarking;
    Calculate(OptionForm.StringGrid1);
    Result := True;
  except
    Result := False;
  end;
end;

function DoReportPageSetup: Boolean;
begin
  try
    Excel.ActiveSheet.PageSetup.Orientation := xlLandscape;
    Excel.ActiveSheet.PageSetup.LeftMargin := 0;
    Excel.ActiveSheet.PageSetup.RightMargin := 0;
    Excel.ActiveSheet.PageSetup.TopMargin := 0;
    Excel.ActiveSheet.PageSetup.BottomMargin := 0;
    Result := True;
  except
    Result := False;
  end;
end;


function PaintReportTitle: Boolean;
var Title: TStringList;
    i: Integer;
    T2: Variant;
begin
  try

    Title := TStringList.Create;
    Title.LoadFromFile(GetCurrentDir + '\ReportTitle.txt');
    for i := 0 to Title.Count - 1 do
      begin
        T2 := T2 + Title.Strings[i];
      end;
    Excel.Cells[2, 3] := T2;
    Excel.Range[Excel.Cells[2,3], Excel.Cells[2,11]].Select;
    Excel.Selection.MergeCells := True;
    Excel.Selection.WrapText := True;
    Excel.Selection.HorizontalAlignment := 3;
    Excel.Selection.VerticalAlignment := 3;
    Title.Free;
    Result := True;
  except
    Result := False;
  end;
end;

function DoReportMarking;
var i: Integer;
begin
  try
    Excel.Rows['2:2'].RowHeight := 70;

    Excel.Columns['A:N'].ColumnWidth := 15;
    Excel.Columns['A:A'].ColumnWidth := 5;
    Excel.Columns['B:B'].ColumnWidth := 25;
    Excel.Columns['C:C'].ColumnWidth := 5;

    Excel.Columns['D:D'].ColumnWidth := 5;
    Excel.Columns['F:F'].ColumnWidth := 5;
    Excel.Columns['H:H'].ColumnWidth := 5;
    Excel.Columns['J:J'].ColumnWidth := 5;
    Excel.Columns['L:L'].ColumnWidth := 5;
    Result := True;
  except
    Result := False;
  end;
end;

function PutSumma(X,Y: Integer; Summa:Real): Boolean;
begin
  try
    Excel.Cells[X,Y] := FloatToStr(Summa);
    Result := True;
  except
    Result := False;
  end;
end;


function PutServiceName(X,Y: Integer; SName:string): Boolean;
begin
  try
    Excel.Cells[X,Y] := SName;
    Result := True;
  except
    Result := False;
  end;
end;

function PutCostService(X,Y: Integer; Cost:Real): Boolean;
begin
  try
    Excel.Cells[X,Y] := FloatToStr(Cost);
    Result := True;
  except
    Result := False;
  end;
end;

function PutProfName(X,Y: Integer; PName:string): Boolean;
begin
  try
    Excel.Cells[X,Y] := PName;
    Result := True;
  except
    Result := False;
  end;
end;

function Calculate(CalcGrid: TStringGrid): Boolean;
var i,g,k,e: Integer;
    StartPart, FinalPart, PartCount: Integer;
    CurPro: Pointer;
    MSID: Integer;
    CList: TList;
    AddFlag: Boolean;
    Position, SavePosition, SumPos, Stolb: Integer;
    ProfSumm: Variant;
    AllSumma: Real;
begin
  Excel.Cells.Select;
  Excel.Selection.WrapText:=True;

  ProfSumm := VarArrayCreate([1,(CalcGrid.RowCount - 1)*5], varDouble);

  ////количество проходов по 5 профессиий
  if (CalcGrid.RowCount - 1) > 5 then
    begin
      PartCount := ((CalcGrid.RowCount - 1) div 5);
      if (PartCount * 5) < (CalcGrid.RowCount - 1) then PartCount := PartCount + 1;
    end
    else
      PartCount := 1;

  StartPart := 1;
  if (CalcGrid.RowCount - 1) >=5 then FinalPart := 5
                                 else FinalPart := (CalcGrid.RowCount - 1);

  Position := 4;
  for i := 0 to PartCount - 1 do
    begin
      SavePosition := Position;
      //////// выводим медуслуги по 5 профессий
      CList := TList.Create;
      Stolb := 4;
      for k := StartPart to FinalPart do
        begin

          CurPro := dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,k])));
          PutProfName(Position, Stolb, TNykProfession(CurPro).Name);
          Excel.Range[Excel.Cells[Position,Stolb], Excel.Cells[Position,Stolb+1]].Select;
          Excel.Selection.MergeCells := True;
          Excel.Selection.HorizontalAlignment :=3;
          Stolb := Stolb +2;
          //// для всех кроме женщин
          for g := 0 to TNykProfession(CurPro).MedServOutLst.Count - 1 do
            begin
              AddFlag := True;
              for e := 0 to CList.Count - 1 do
                begin
                  if TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).Id = TNykMedService(CList.Items[e]).Id then AddFlag := False;
                end;
              if AddFlag and (TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).MaleRecip <> 0) then CList.Add(TNykProfession(CurPro).MedServOutLst.Items[g]);
            end;

          //// только для женщин
          for g := 0 to TNykProfession(CurPro).MedServOutLst.Count - 1 do
            begin
              AddFlag := True;
              for e := 0 to CList.Count - 1 do
                begin
                  if TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).Id = TNykMedService(CList.Items[e]).Id then AddFlag := False;
                end;
              if AddFlag and (TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).MaleRecip = 0) then CList.Add(TNykProfession(CurPro).MedServOutLst.Items[g]);
            end;
      end;

        PutServiceName(Position,2, 'Услуга');
        Excel.Cells[Position, 2].Select;
        Excel.Selection.HorizontalAlignment :=3;
        PutServiceName(Position,3, 'Цена');
        Excel.Cells[Position, 3].Select;
        Excel.Selection.HorizontalAlignment :=3;
        Inc(Position);

        SumPos := 0;
        for e := 0 to CList.Count - 1 do
          begin

            if TNykMedService(CList.Items[e]).MaleRecip <> 0 then
              begin
                Inc(SumPos);
                PutServiceName(Position,2, TNykMedService(CList.Items[e]).Name);
                PutCostService(Position,3, TNykMedService(CList.Items[e]).price);
                Excel.Cells[Position, 3].Select;
                Excel.Selection.HorizontalAlignment :=3;
                Stolb := 5;
                for k := StartPart to FinalPart do
                  begin
                    CurPro := dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,k])));
                    for g := 0 to TNykProfession(CurPro).MedServOutLst.Count - 1 do
                      begin
                        if TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).Id = TNykMedService(CList.Items[e]).Id then
                          begin
                            ProfSumm[((k-1)*5)+1] := ProfSumm[((k-1)*5)+1] + TNykMedService(CList.Items[e]).price;
                            PutCostService(Position,Stolb, TNykMedService(CList.Items[e]).price);
                          end;
                        Excel.Cells[Position, Stolb].Select;
                        Excel.Selection.HorizontalAlignment :=3;
                       end;
                    Stolb := Stolb +2;
                  end;
                Inc(Position);
              end;
              if e = CList.Count - 1 then
               begin
                Stolb := 5;
                for k := StartPart to FinalPart do
                  begin
                    Excel.Cells[Position, Stolb] := FloatToStr(ProfSumm[((k-1)*5)+1]);
                    Excel.Cells[Position, Stolb].Select;
                    Excel.Selection.HorizontalAlignment := 3;
                    Stolb := Stolb +2;
                  end;
               end;
           end;

        PutServiceName(Position,2, 'Итого муж');
        Inc(Position);

        PutServiceName(Position,2, 'для женщин доп.');
        Inc(Position);

        SumPos := 0;
        for e := 0 to CList.Count - 1 do
          begin

            if TNykMedService(CList.Items[e]).MaleRecip = 0 then
              begin
                Inc(SumPos);
                PutServiceName(Position,2, TNykMedService(CList.Items[e]).Name);
                PutCostService(Position,3, TNykMedService(CList.Items[e]).price);
                Excel.Cells[Position, 3].Select;
                Excel.Selection.HorizontalAlignment :=3;
                Stolb := 5;
                for k := StartPart to FinalPart do
                  begin
                    CurPro := dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,k])));
                    for g := 0 to TNykProfession(CurPro).MedServOutLst.Count - 1 do
                      begin
                        if TNykMedService(TNykProfession(CurPro).MedServOutLst.Items[g]).Id = TNykMedService(CList.Items[e]).Id then
                          begin
                            ProfSumm[((k-1)*5)+2] := ProfSumm[((k-1)*5)+2] + TNykMedService(CList.Items[e]).price;
                            PutCostService(Position,Stolb, TNykMedService(CList.Items[e]).price);
                          end;
                        Excel.Cells[Position, Stolb].Select;
                        Excel.Selection.HorizontalAlignment := 3;
                      end;
                    Stolb := Stolb +2;
                  end;
                Inc(Position);
              end;
              if e = CList.Count - 1 then
               begin
                Stolb := 5;
                for k := StartPart to FinalPart do
                  begin
                    Excel.Cells[Position, Stolb] := FloatToStr(ProfSumm[((k-1)*5)+2] + ProfSumm[((k-1)*5)+1]);
                    Excel.Cells[Position, Stolb].Select;
                    Excel.Selection.HorizontalAlignment := 3;
                    Stolb := Stolb +2;
                  end;
               end;
          end;
        PutServiceName(Position,2, 'Итого жен');
        Inc(Position);
        PutServiceName(Position,2, 'Всего: муж -');
        Stolb := 5;
        for k := StartPart to FinalPart do
          begin
            Excel.Cells[Position, Stolb-1] := CalcGrid.Cells[2,k];
            Excel.Cells[Position, Stolb-1].Select;
            Excel.Selection.HorizontalAlignment :=3;
            ProfSumm[((k-1)*5)+3] := FloatToStr(ProfSumm[((k-1)*5)+1]*StrToInt(CalcGrid.Cells[2,k]));
            Excel.Cells[Position, Stolb] := FloatToStr(ProfSumm[((k-1)*5)+3]);
            Excel.Cells[Position, Stolb].Select;
            Excel.Selection.HorizontalAlignment :=3;
            Stolb := Stolb +2;
          end;
        Inc(Position);
        PutServiceName(Position,2, 'Всего: жен -');
        Stolb := 5;
        for k := StartPart to FinalPart do
          begin
            Excel.Cells[Position, Stolb-1] := CalcGrid.Cells[3,k];
            Excel.Cells[Position, Stolb-1].Select;
            Excel.Selection.HorizontalAlignment :=3;
            if ProfSumm[((k-1)*5)+2] > 0 then ProfSumm[((k-1)*5)+4] := FloatToStr((ProfSumm[((k-1)*5)+2]+ProfSumm[((k-1)*5)+1])*StrToInt(CalcGrid.Cells[3,k]))
                                         else ProfSumm[((k-1)*5)+4] := FloatToStr(ProfSumm[((k-1)*5)+1]*StrToInt(CalcGrid.Cells[3,k]));
            Excel.Cells[Position, Stolb] := FloatToStr(ProfSumm[((k-1)*5)+4]);
            Excel.Cells[Position, Stolb].Select;
            Excel.Selection.HorizontalAlignment :=3;
            Stolb := Stolb +2;
          end;
        Inc(Position);
        Stolb := 5;
        for k := StartPart to FinalPart do
          begin
            ProfSumm[((k-1)*5)+5] := FloatToStr(ProfSumm[((k-1)*5)+3] + ProfSumm[((k-1)*5)+4]);
            Excel.Cells[Position, Stolb] := FloatToStr(ProfSumm[((k-1)*5)+5]);
            Excel.Cells[Position, Stolb].Select;
            Excel.Selection.HorizontalAlignment := 3;
            Stolb := Stolb +2;
          end;
        Ramka(SavePosition, Position);
        Inc(Position);
        Inc(Position);
        StartPart := FinalPart + 1;
        FinalPart := 6;
        CList.Free;
    end;
    AllSumma := 0;
    for k := 1 to CalcGrid.RowCount - 1 do
      begin
        AllSumma := AllSumma + ProfSumm[((k-1)*5)+5];
      end;
    Excel.Cells[Position, 13].Select;
    Excel.Selection.WrapText := True;
    Excel.Selection.HorizontalAlignment :=3;
    Excel.Cells[Position, 13] := FloatToStr(AllSumma);
end;

function Ramka(X, Y: Integer): Boolean;
begin
  try
    Excel.Range[Excel.Cells[X, 2], Excel.Cells[Y, 13]].Select;
    Excel.Selection.Borders[xlEdgeLeft].LineStyle := xlContinuous;
    Excel.Selection.Borders[xlEdgeTop].LineStyle := xlContinuous;
    Excel.Selection.Borders[xlEdgeBottom].LineStyle := xlContinuous;
    Excel.Selection.Borders[xlEdgeRight].LineStyle := xlContinuous;
    Excel.Selection.Borders[xlInsideHorizontal].LineStyle := xlContinuous;
    Excel.Selection.Borders[xlInsideVertical].LineStyle := xlContinuous;
    Result := True;
  except
    Result := False;
  end;
end;
////////////////////////////////////////////////////////////////////////////////

procedure ShowPreview;
begin
  if Routine = 0 then
    begin
      if (OptionForm.Edit1.Text <> '') then
        begin
          if StartReport(1)=1 then MessageDlg('Ошибка печати или принтер не доступен.', mtError,[mbOk], 0);
        end
        else
        begin
          MessageDlg('Введите наименование организации!', mtInformation, [mbOk], 0);
        end;
    end;
  if Routine = 1 then StartExcelReport;
end;

procedure TOptionForm.SpeedButton1Click(Sender: TObject);
var i: Integer;
    Flag: Boolean;
begin
  Routine := 0;
  if OptionForm.StringGrid1.Cells[0,1] <> '' then
  begin
    Flag := True;
      for i := 1 to OptionForm.StringGrid1.RowCount - 1 do
        begin
          if not ValidType(OptionForm.StringGrid1.Cells[1, i], 0) then Flag := False;
          if not ValidType(OptionForm.StringGrid1.Cells[2, i], 0) then Flag := False;
          if not ValidType(OptionForm.StringGrid1.Cells[3, i], 0) then Flag := False;
        end;
    if Flag then ShowPreview;
  end
  else
  begin
    MessageDlg('Не выбраны профессии.', mtInformation, [mbOk], 0);
  end;
end;



procedure TOptionForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then ShowPreview;
end;

function MyFormatLine(const Key, Value: string): string;
begin
  Result := Format('%s=%s', [Key, Value]);
end;

function ExistsKey(KeyName: string): Boolean;
var i: Integer;
begin
  Result := False;
  {for i := 0 to OptionForm.ValueListEditor1.RowCount - 1 do
    begin
      if OptionForm.ValueListEditor1.Keys[i] = KeyName then Result := True;
    end;}
end;

function ExistsKeyGrid(KeyName: string): Boolean;
var i: Integer;
begin
  Result := False;
  for i := 0 to OptionForm.StringGrid1.RowCount - 1 do
    begin
      if OptionForm.StringGrid1.Cells[0,i+1] = KeyName then Result := True;
    end;
end;

procedure TOptionForm.SpeedButton2Click(Sender: TObject);
var i, k: Integer;
    ProName: string;
    ProID: string;
    ts: TStringList;
begin
////////////////////////////////////////////////////////////////////////////////

 { for i := 0 to OptionForm.ListBox1.Count - 1 do
    begin
      if OptionForm.ListBox1.Selected[i] then
        begin
          ProID := TStringList(OptionForm.ListBox1.Items.Objects[i]).Strings[0];
          ProName := TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).Name;
          if not ExistsKey(ProName) then
          begin
          ts := TStringList.Create;
          ts.Add(ProID);
          TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServOutLst.Clear;
          OptionForm.ValueListEditor1.Strings.AddObject(MyFormatLine(ProName,'0'), ts);
          for k := 0 to TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServLst.Count - 1 do
            begin
              TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServOutLst.Add(TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServLst.Items[k]);
            end;
          if (OptionForm.ValueListEditor1.Cells[1,1] <> '') and (OptionForm.ValueListEditor1.Cells[0,1] = '')then
           OptionForm.ValueListEditor1.DeleteRow(1);
          end
          else MessageDlg('Профессия уже добавлена!',mtInformation,[mbOk], 0);
        end;
    end;
    OptionForm.ValueListEditor1.RestoreCurrentRow;
    DoListBox;
    ButonCorrect;  }
////////////////////////////////////////////////////////////////////////////////

  //OptionForm.StringGrid1.RowCount := OptionForm.StringGrid1.RowCount + 1;
  for i := 0 to OptionForm.ListBox1.Count - 1 do
    begin
      if OptionForm.ListBox1.Selected[i] then
        begin
          ProID := TStringList(OptionForm.ListBox1.Items.Objects[i]).Strings[0];
          ProName := TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).Name;
          if not ExistsKeyGrid(ProName) then
            begin
              TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServOutLst.Clear;

              OptionForm.StringGrid1.Cells[0,0] := 'Профессия';
              OptionForm.StringGrid1.Cells[1,0] := 'Всего человек';
              OptionForm.StringGrid1.Cells[2,0] := 'Мужчин';
              OptionForm.StringGrid1.Cells[3,0] := 'Женщин';

          //OptionForm.StringGrid1.RowCount := OptionForm.StringGrid1.RowCount + 1;
              if (OptionForm.StringGrid1.RowCount >= 2) and (OptionForm.StringGrid1.Cells[0,1] <> '') then
                begin
                  OptionForm.StringGrid1.RowCount := OptionForm.StringGrid1.RowCount + 1;
                end; 

              OptionForm.StringGrid1.Cells[0, OptionForm.StringGrid1.RowCount-1] := ProName;
              OptionForm.StringGrid1.Cells[1, OptionForm.StringGrid1.RowCount-1] := '0';
              OptionForm.StringGrid1.Cells[2, OptionForm.StringGrid1.RowCount-1] := '0';
              OptionForm.StringGrid1.Cells[3, OptionForm.StringGrid1.RowCount-1] := '0';
              OptionForm.StringGrid1.Objects[0, OptionForm.StringGrid1.RowCount-1] := Pointer(ProID);

              for k := 0 to TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServLst.Count - 1 do
                begin
                  TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServOutLst.Add(TNykProfession(dDM.GetPRbyID(StrToInt(ProID))).MedServLst.Items[k]);
                end;

         // if (OptionForm.ValueListEditor1.Cells[1,1] <> '') and (OptionForm.ValueListEditor1.Cells[0,1] = '')then
        //   OptionForm.ValueListEditor1.DeleteRow(1);
            end

            else MessageDlg('Профессия уже добавлена!',mtInformation,[mbOk], 0);
      end;
    end;
    //OptionForm.StringGrid1.RowCount := OptionForm.StringGrid1.RowCount - 1;
   // OptionForm.ValueListEditor1.RestoreCurrentRow;
    DoListBox;
    ButonCorrect;
end;



procedure TOptionForm.SpeedButton3Click(Sender: TObject);
var Flag: Boolean;
       i: Integer;
       PIndex: Integer;
       ts: TStringList;
begin
  if ProfField.Count > 0 then
    begin
     // if TNykProfession(dDM.GetPRbyID(StrToInt(TStringList(OptionForm.ValueListEditor1.Strings.Objects[OptionForm.ValueListEditor1.Row-1]).Strings[0]))).GVredLst.Count > 0 then
     //   begin
          if OptionForm.MComboBox.ItemIndex <> -1 then
            begin
              Flag := False;

              for i := 0 to TNykProfession(dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,OptionForm.StringGrid1.Row])))).MedServOutLst.Count - 1 do
                begin
                  if TNykMedService(TNykProfession(dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,OptionForm.StringGrid1.Row])))).MedServOutLst.Items[i]).Id =
                  Integer(OptionForm.MComboBox.Items.Objects[OptionForm.MComboBox.ItemIndex])
                  then  Flag := True;
                end;

              if Flag = False then
                begin
                //fr_main.Caption := IntToStr(fr_main.MComboBox.ItemIndex);
                  TNykProfession(dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,OptionForm.StringGrid1.Row])))).
                  AddMedOut(dDM.GetMedSbyID(Integer(OptionForm.MComboBox.Items.Objects[OptionForm.MComboBox.ItemIndex])));
                  OptionForm.ListBox2.Clear;
                  PIndex := StrToInt(string(OptionForm.StringGrid1.Objects[0,OptionForm.StringGrid1.Row]));
                  for i := 0 to TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Count - 1 do
                    begin
                      ts := TStringList.Create;
                      ts.Add(IntToStr(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).Id));
                      OptionForm.ListBox2.Items.AddObject(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).Name, ts)
                    end;
                end
                else
                begin
                  MessageDlg('Мед. услуга уже включена в список!', mtInformation, [mbOk], 0);
                end;
            end
            else
            begin
              MessageDlg('Не выбрана мед. услуга!', mtInformation, [mbOk], 0);
            end;
    //    end
    //    else
    //    begin
    //      MessageDlg('Нет групп!', mtInformation, [mbOk], 0);
    //    end;
    end
    else
    begin
      MessageDlg('Нет профессий!', mtInformation, [mbOk], 0);
    end;
  OptionForm.MComboBox.ItemIndex := -1;
end;

procedure DoListBox;
var i, PIndex: Integer;
    PPIndex: string;
    ts: TStringList;
begin
  OptionForm.ListBox2.Clear;
  try
  if ( OptionForm.StringGrid1.RowCount > 1) and
  (OptionForm.StringGrid1.Cells[0, OptionForm.StringGrid1.Row] <> '') {and
  (OptionForm.StringGrid1.Cells[1, OptionForm.StringGrid1.Row] <> '')} then
    begin

  PPIndex := string(OptionForm.StringGrid1.Objects[0, OptionForm.StringGrid1.Row]);
  if PPIndex <> '' then Pindex := StrToInt(PPIndex) else Exit;
   for i := 0 to TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Count - 1 do
     begin
       ts := TStringList.Create;
       ts.Add(IntToStr(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).id));
       OptionForm.ListBox2.Items.AddObject(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).Name, ts);
     end;
   end;
   except

   end;
end;

procedure DoListBoxGrid;
var i, PIndex: Integer;
    PPIndex: string;
    ts: TStringList;
begin
  OptionForm.ListBox2.Clear;
  try
  if ( OptionForm.StringGrid1.RowCount > 1) and
  (OptionForm.StringGrid1.Cells[0, OptionForm.StringGrid1.Row] <> '') and
  (OptionForm.StringGrid1.Cells[0, OptionForm.StringGrid1.Row] <> '') then
    begin

  PPIndex := string(OptionForm.StringGrid1.Objects[0, OptionForm.StringGrid1.Row]);
  if PPIndex <> '' then Pindex := StrToInt(PPIndex) else Exit;
   for i := 0 to TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Count - 1 do
     begin
       ts := TStringList.Create;
       ts.Add(IntToStr(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).id));
       OptionForm.ListBox2.Items.AddObject(TNykMedService(TNykProfession(dDM.GetPRbyID(PIndex)).MedServOutLst.Items[i]).Name, ts);
     end;
   end;
   except

   end;
end;

procedure TOptionForm.ListBox2DblClick(Sender: TObject);
begin
      TNykProfession(dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,OptionForm.StringGrid1.Row]))))
      .DelOutMedServiceItem(StrToInt(TStringList(OptionForm.ListBox2.Items.Objects[OptionForm.ListBox2.ItemIndex]).Strings[0]));
   OptionForm.ListBox2.Items.Delete(OptionForm.ListBox2.ItemIndex);
end;

procedure TOptionForm.SpeedButton4Click(Sender: TObject);
var a, b: Integer;
begin
  for a := 0 to OptionForm.StringGrid1.RowCount-1 do
  for b := 0 to OptionForm.StringGrid1.ColCount-1 do
    begin
      OptionForm.StringGrid1.Cells[b,a] := '';
      OptionForm.StringGrid1.Objects[b,a] := nil;
    end;
  OptionForm.StringGrid1.RowCount := 2;
  OptionForm.ListBox2.Clear;
  ButonCorrect;
end;

procedure TOptionForm.ListBox1DblClick(Sender: TObject);
var ProID, ProName: string;
    ts: TStringList;
    k: Integer;
begin
  OptionForm.SpeedButton2.Click;
end;

procedure TOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OptionForm.SpeedButton4.Click;
  //OptionForm.Edit1.Clear;
  fr_main.Enabled := True;
end;

procedure ButonCorrect;
begin
 if (OptionForm.StringGrid1.RowCount > 1) then
    if (OptionForm.StringGrid1.Cells[0,1] <> '') {and (OptionForm.StringGrid1.Cells[1,1] <> '')} then
      begin
        OptionForm.SpeedButton4.Enabled := True;
      end
      else
        OptionForm.SpeedButton4.Enabled := False;
end;

procedure TOptionForm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 // DoListBoxGrid;
end;

procedure TOptionForm.StringGrid1Click(Sender: TObject);
begin
  DoListBoxGrid;
  Summ;
end;

procedure Summ;
var i: Integer;
begin
  for i := 1 to OptionForm.StringGrid1.RowCount - 1 do
    begin
      if ValidType(OptionForm.StringGrid1.Cells[2,i], 0) and ValidType(OptionForm.StringGrid1.Cells[3,i], 0) then
        begin
          OptionForm.StringGrid1.Cells[1,i] := IntToStr(StrToInt(OptionForm.StringGrid1.Cells[2,i]) + StrToInt(OptionForm.StringGrid1.Cells[3,i]));
        end
        else
        begin
          OptionForm.StringGrid1.Cells[2,i] := '0';
          OptionForm.StringGrid1.Cells[3,i] := '0';
        end;
    end;
end;

procedure TOptionForm.StringGrid1DblClick(Sender: TObject);
begin
 // Summ;
 DeleteRowFromGird(Sender);
 ButonCorrect;
end;

procedure DeleteRowFromGird(Sender: TObject);
var i, StartPart, FinalPart: Integer;
begin
  StartPart := TStringGrid(Sender).Row;
  FinalPart := TStringGrid(Sender).RowCount - 1;
  if FinalPart+1 > 2 then
    begin
      for i := StartPart to FinalPart do
        begin
          TStringGrid(Sender).Cells[0, i] := TStringGrid(Sender).Cells[0, i+1];
          TStringGrid(Sender).Cells[1, i] := TStringGrid(Sender).Cells[1, i+1];
          TStringGrid(Sender).Cells[2, i] := TStringGrid(Sender).Cells[2, i+1];
          TStringGrid(Sender).Cells[3, i] := TStringGrid(Sender).Cells[3, i+1];
          TStringGrid(Sender).Objects[0, i] := TStringGrid(Sender).Objects[0, i+1];
        end;
      TStringGrid(Sender).RowCount := TStringGrid(Sender).RowCount-1;
    end
    else
    if FinalPart+1 = 2 then
    begin
      TStringGrid(Sender).Cells[0, 1] := '';
      TStringGrid(Sender).Cells[1, 1] := '';
      TStringGrid(Sender).Cells[2, 1] := '';
      TStringGrid(Sender).Cells[3, 1] := '';
      TStringGrid(Sender).Objects[0, i] := nil;
    end;
end;

procedure TOptionForm.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Summ;
end;

procedure TOptionForm.SpeedButton5Click(Sender: TObject);
var i: Integer;
    Flag: Boolean;
begin
  Routine := 1;
  if OptionForm.StringGrid1.Cells[0,1] <> '' then
  begin
    Flag := True;
      for i := 1 to OptionForm.StringGrid1.RowCount - 1 do
        begin
          if not ValidType(OptionForm.StringGrid1.Cells[1, i], 0) then Flag := False;
          if not ValidType(OptionForm.StringGrid1.Cells[2, i], 0) then Flag := False;
          if not ValidType(OptionForm.StringGrid1.Cells[3, i], 0) then Flag := False;
        end;
    if Flag then ShowPreview;
  end
  else
  begin
    MessageDlg('Не выбраны профессии.', mtInformation, [mbOk], 0);
  end;
end;

end.



