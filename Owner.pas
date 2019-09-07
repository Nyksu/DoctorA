unit Owner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TOwnerForm = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OwnerForm: TOwnerForm;

implementation
uses DM, Main;
{$R *.dfm}

procedure TOwnerForm.FormShow(Sender: TObject);
begin
 OwnerForm.Edit1.Text := dDM.ReadParamFromINI('COMPANY', 'NAME', '');
 OwnerForm.Edit2.Text := dDM.ReadParamFromINI('COMPANY', 'ADDRESS', '');
 OwnerForm.Edit3.Text := dDM.ReadParamFromINI('COMPANY', 'PHONE', '');
 OwnerForm.Edit4.Text := dDM.ReadParamFromINI('COMPANY', 'SPECPHONE', '');
end;

procedure TOwnerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 fr_main.Enabled := True;
end;

procedure TOwnerForm.SpeedButton1Click(Sender: TObject);
begin
 dDM.WriteIdent('COMPANY', 'NAME', OwnerForm.Edit1.Text);
 dDM.WriteIdent('COMPANY', 'ADDRESS', OwnerForm.Edit2.Text);
 dDM.WriteIdent('COMPANY', 'PHONE', OwnerForm.Edit3.Text);
 dDM.WriteIdent('COMPANY', 'SPECPHONE', OwnerForm.Edit4.Text);
 OwnerForm.Close;
end;

end.
