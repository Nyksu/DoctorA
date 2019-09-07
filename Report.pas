unit Report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, DBTables, Grids;

type
  TReportForm = class(TForm)
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    QRMemo1: TQRMemo;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    QRShape7: TQRShape;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRBand2: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape9: TQRShape;
    QRLabel9: TQRLabel;
    QRBand3: TQRBand;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QuickRep2: TQuickRep;
    TitleBand2: TQRBand;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRMemo2: TQRMemo;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRShape10: TQRShape;
    QRLabel22: TQRLabel;
    QRShape11: TQRShape;
    QRLabel23: TQRLabel;
    QRShape14: TQRShape;
    QRLabel24: TQRLabel;
    QRShape15: TQRShape;
    QRLabel25: TQRLabel;
    QRShape16: TQRShape;
    QRLabel26: TQRLabel;
    QRShape17: TQRShape;
    QRLabel27: TQRLabel;
    PageFooterBand1: TQRBand;
    QRLabel28: TQRLabel;
    QuickRep3: TQuickRep;
    ColumnHeaderBand2: TQRBand;
    QRShape18: TQRShape;
    QRLabel32: TQRLabel;
    QRShape20: TQRShape;
    QRLabel34: TQRLabel;
    DetailBand2: TQRBand;
    PageFooterBand2: TQRBand;
    TitleBand3: TQRBand;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRMemo3: TQRMemo;
    QRShape19: TQRShape;
    QRLabel33: TQRLabel;
    QRShape21: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel; 
    procedure QuickRep1StartPage(Sender: TCustomQuickRep);
    procedure QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep2StartPage(Sender: TCustomQuickRep);
    procedure QuickRep2BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep2NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRep3BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep3StartPage(Sender: TCustomQuickRep);
    procedure QuickRep3NeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportForm: TReportForm;
   CurrentItem, CurrentItem1, CurrentItem2: Integer;
   FinalGrid : TStringGrid;
   Summa: Integer;

procedure DoFinalGrid;
procedure DoFinalGrid2;

function StartReport(rtype : integer) : integer;

implementation

uses DM, Main, OptionUnit;

{$R *.dfm}

function StartReport(rtype : integer) : integer;
Begin
  Result:=0;
  try
    try
      ReportForm:=TReportForm.Create(Application);
      Case rtype of
         1 : Begin
             //  if fr_main.MListBox.Count > 0 then DoFinalGrid;
               DoFinalGrid2;
               ReportForm.QuickRep1.Preview;
             //  OptionForm.Edit1.Clear;
             //  OptionForm.Close;
             end;
         2 : ReportForm.QuickRep2.Preview;
         3 : ReportForm.QuickRep3.Preview;
      end;
    finally
      ReportForm.Free;
    end;
  except
    Result:=1;
  end;
end;

procedure TReportForm.QuickRep1StartPage(Sender: TCustomQuickRep);
begin
ReportForm.QRLabel1.Caption := dDM.ReadParamFromINI('COMPANY', 'NAME', '');
ReportForm.QRLabel2.Caption := dDM.ReadParamFromINI('COMPANY', 'ADDRESS', '');
ReportForm.QRLabel3.Caption := dDM.ReadParamFromINI('COMPANY', 'PHONE', '');
ReportForm.QRLabel4.Caption := OptionForm.Edit1.Text;
ReportForm.QRLabel37.Caption := dDM.ReadParamFromINI('COMPANY', 'SPECPHONE', '');
end;

procedure TReportForm.QuickRep1NeedData(Sender: TObject;
  var MoreData: Boolean);
var i: Integer;
    R: Real;
begin
	if CurrentItem < FinalGrid.RowCount then
  begin
	  ReportForm.QRLabel12.Caption := FinalGrid.Cells[0, CurrentItem];
    ReportForm.QRLabel15.Caption := FinalGrid.Cells[1, CurrentItem];
    ReportForm.QRLabel16.Caption := FinalGrid.Cells[2, CurrentItem];
    ReportForm.QRLabel17.Caption := FinalGrid.Cells[3, CurrentItem];
  end;
  
	Inc(CurrentItem);
	if CurrentItem <= FinalGrid.RowCount then MoreData := True
                                else
                                begin
                                  MoreData := False;
                                  R := 0;
                                  try
                                  for i := 0 to FinalGrid.RowCount - 1 do R := R + StrToFloat(FinalGrid.Cells[3, i]);
                                  ReportForm.QRLabel18.Caption := FloatToStr(R) + ' (руб.)';
                                  except
                                  ReportForm.QRLabel18.Caption := FloatToStr(R) + ' (руб.)';
                                  end;
end;                            end;

procedure TReportForm.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
 	CurrentItem := 0;

	if FinalGrid.RowCount > 0 then PrintReport := True
                     else PrintReport := False;
end;

procedure DoFinalGrid;
var i, k, g, GridItem, HumanCount: Integer;
begin
 FinalGrid.ColCount := 4;

 GridItem := 0;
 FinalGrid.RowCount := GridItem;
 HumanCount := 0;
 //Summa := 0;
 for k := 0 to MedSField.Count - 1 do
   begin
     if (TNykMedService(MedSField.Items[k]).State <> 0) and (TNykMedService(MedSField.Items[k]).State <> 4) then
       begin
         for i := 0 to ProfField.Count - 1 do
           begin
             for g := 0 to TNykProfession(ProfField.Items[i]).MedServLst.Count - 1 do
               begin
                 if TNykMedService(TNykProfession(ProfField.Items[i]).MedServLst.Items[g]).Id =
                    TNykMedService(MedSField.Items[k]).Id then HumanCount := HumanCount + TNykProfession(ProfField.Items[i]).HumanCount;
               end;
           end;
       end;
      if HumanCount > 0 then
        begin
          Inc(GridItem);
          FinalGrid.RowCount := GridItem;
          FinalGrid.Cells[0, GridItem - 1]:= TNykMedService(MedSField.Items[k]).Name;
          FinalGrid.Cells[1, GridItem - 1]:= FloatToStr(TNykMedService(MedSField.Items[k]).price);
          FinalGrid.Cells[2, GridItem - 1]:= IntToStr(HumanCount);
          FinalGrid.Cells[3, GridItem - 1]:= FloatToStr(HumanCount * TNykMedService(MedSField.Items[k]).price);
          HumanCount := 0;
        end;
   end;
end;

procedure DoFinalGrid2;
var i, k, g, GridItem, HumanCount: Integer;
    CurProf: Pointer;
    TypSum: Integer;
begin
 FinalGrid.ColCount := 4;

 GridItem := 0;
 FinalGrid.RowCount := GridItem;
 HumanCount := 0;
 Summa := 0;
 for k := 0 to MedSField.Count - 1 do
   begin
     if (TNykMedService(MedSField.Items[k]).State <> 0) and (TNykMedService(MedSField.Items[k]).State <> 4) then
       begin
         for i := 1 to OptionForm.StringGrid1.RowCount - 1 do
           begin
             CurProf := dDM.GetPRbyID(StrToInt(string(OptionForm.StringGrid1.Objects[0,i])));
             for g := 0 to TNykProfession(CurProf).MedServOutLst.Count - 1 do
               begin
                 if TNykMedService(TNykProfession(CurProf).MedServOutLst.Items[g]).Id =
                    TNykMedService(MedSField.Items[k]).Id then
                      begin
                        if TNykMedService(TNykProfession(CurProf).MedServOutLst.Items[g]).MaleRecip = 2 then
                          HumanCount := HumanCount + StrToInt(OptionForm.StringGrid1.Cells[1,i]);
                        if TNykMedService(TNykProfession(CurProf).MedServOutLst.Items[g]).MaleRecip = 0 then
                          HumanCount := HumanCount + StrToInt(OptionForm.StringGrid1.Cells[3,i]);
                      end;
               end;
           end;
       end;
      if HumanCount > 0 then
        begin
          Inc(GridItem);
          FinalGrid.RowCount := GridItem;
          FinalGrid.Cells[0, GridItem - 1]:= TNykMedService(MedSField.Items[k]).Name;
          FinalGrid.Cells[1, GridItem - 1]:= FloatToStr(TNykMedService(MedSField.Items[k]).price);
          FinalGrid.Cells[2, GridItem - 1]:= IntToStr(HumanCount);
          FinalGrid.Cells[3, GridItem - 1]:= FloatToStr(HumanCount * TNykMedService(MedSField.Items[k]).price);
          HumanCount := 0;
        end;
   end;
end;

procedure TReportForm.QuickRep2StartPage(Sender: TCustomQuickRep);
begin
ReportForm.QRLabel19.Caption := dDM.ReadParamFromINI('COMPANY', 'NAME', '');
ReportForm.QRLabel20.Caption := dDM.ReadParamFromINI('COMPANY', 'ADDRESS', '');
ReportForm.QRLabel21.Caption := dDM.ReadParamFromINI('COMPANY', 'PHONE', '');
end;

procedure TReportForm.QuickRep2BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
 	CurrentItem1 := 0;

	if MedSField.Count > 0 then PrintReport := True
                     else PrintReport := False;
end;

procedure TReportForm.QuickRep2NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
	if CurrentItem1 < MedSField.Count then
  begin
	  ReportForm.QRLabel25.Caption := TNykMedService(MedSField.Items[CurrentItem1]).Name;
    case TNykMedService(MedSField.Items[CurrentItem1]).TypeItem of
     0 : ReportForm.QRLabel26.Caption := 'Прием';
     1 : ReportForm.QRLabel26.Caption := 'Процедура';
    end;
    ReportForm.QRLabel27.Caption := FloatToStr(TNykMedService(MedSField.Items[CurrentItem1]).price);
  end;
  
	Inc(CurrentItem1);
	if CurrentItem1 <= MedSField.Count then MoreData := True
                                else
                                begin
                                  MoreData := False;
                                  ReportForm.QRLabel28.Caption := DateToStr(Now) +'  '+ TimeToStr(Now);
                                end;
end;

procedure TReportForm.QuickRep3BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
 	CurrentItem2 := 0;

	if GVField.Count > 0 then PrintReport := True
                     else PrintReport := False;
end;

procedure TReportForm.QuickRep3StartPage(Sender: TCustomQuickRep);
begin
ReportForm.QRLabel29.Caption := dDM.ReadParamFromINI('COMPANY', 'NAME', '');
ReportForm.QRLabel30.Caption := dDM.ReadParamFromINI('COMPANY', 'ADDRESS', '');
ReportForm.QRLabel31.Caption := dDM.ReadParamFromINI('COMPANY', 'PHONE', '');
end;

procedure TReportForm.QuickRep3NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
	if CurrentItem2 < GVField.Count then
  begin
	  ReportForm.QRLabel33.Caption := TNykGVred(GVField.Items[CurrentItem2]).Code;
    ReportForm.QRLabel35.Caption := TNykGVred(GVField.Items[CurrentItem2]).Name;
  end;
  
	Inc(CurrentItem2);
	if CurrentItem2 <= GVField.Count then MoreData := True
                                else
                                begin
                                  MoreData := False;
                                  ReportForm.QRLabel36.Caption := DateToStr(Now) +'  '+ TimeToStr(Now);
                                end;
end;   

end.
