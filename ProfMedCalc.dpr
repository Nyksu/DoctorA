program ProfMedCalc;

uses
  Forms,
  Main in 'Main.pas' {fr_main},
  DM in 'DM.pas' {dDM: TDataModule},
  Formula in 'Formula.pas',
  StrUtils1 in 'StrUtils1.pas',
  Owner in 'Owner.pas' {OwnerForm},
  Report in 'Report.pas' {ReportForm},
  OptionUnit in 'OptionUnit.pas' {OptionForm};

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(Tfr_main, fr_main);
  Application.CreateForm(TdDM, dDM);
  Application.CreateForm(TOwnerForm, OwnerForm);
  Application.CreateForm(TOptionForm, OptionForm);
  Application.Run;
end.
