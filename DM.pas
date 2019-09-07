unit DM;

interface

uses
  SysUtils, Classes, Formula, IniFiles, Variants;

type

  TNykMedService = class(TObject)
  private
    FID : integer;
    FNAME : string;
    FTYPE : integer;   // 0 - процедура; 1 - приём врача
    FRECIP: Integer;  //0 - женщина; 1 - мужчина
    FPRICE : real;
    FSTATE : integer;  // 2 - read, 1 - inserted, 3 - edited, 4 - deleted, 0 - destroed
    { Private declarations }
  public
    constructor Create(idd,tp, recip :integer;nam : string; pr : real);
    destructor Destroy; override;
    property Id : integer read FID;
    property TypeItem : integer read FTYPE;
    property MaleRecip: Integer read FRECIP;
    property Name : string read FNAME;
    property State : integer read FSTATE;
    property price : real read FPRICE;
    procedure ReName(newnam : string);
    Procedure ReState(newstate : integer);
    procedure RePrice(newprice : real);
    procedure ReType(NewType: Integer);
    procedure ReMaleRecip(NewMaleRecip: Integer);
    procedure Delete;
    { Public declarations }
  end;

  TNykGVred = class(TObject)
  private
    FID : integer;
    FNAME : string; 
    FCODE : string;
    FMedServLst : TList;
    FSTATE : integer;  // 2 - read, 1 - inserted, 3 - edited, 4 - deleted, 0 - destroed
    { Private declarations }
  public
    constructor Create(idd : integer; cod,nam : string);
    destructor Destroy; override;
    property Id : integer read FID;
    property Code : string read FCODE;
    property Name : string read FNAME;
    property MedServLst : TList read FMedServLst;
    property State : integer read FSTATE;
    procedure ReName(newnam : string);
    Procedure ReState(newstate : integer);
    procedure ReCode(newcod : string);
    procedure AddMedServiceItem(itm : pointer);
    procedure DelMedServiceItem(idd : integer);
    function CheckMedSrvInLst(idd : integer) : boolean;
    procedure Delete;
    { Public declarations }
  end;

  TNykProfession = class(TObject)
  private
    FID : integer;
    FNAME : string;
    FCOUNT: Integer;
    FMedServLst : TList;
    FMedServOutLst: TList;
    FGVredLst : TList;
    FSTATE : integer; // 2 - read, 1 - inserted, 3 - edited, 4 - deleted, 0 - destroed
    { Private declarations }
  public
    constructor Create(idd : integer; nam : string; HumanCount: Integer);
    destructor Destroy; override;
    property Id : integer read FID;
    property Name : string read FNAME;
    property MedServLst : TList read FMedServLst;
    property MedServOutLst: TList read FMedServOutLst;
    property GVredLst : TList read FGVredLst;
    property State : integer read FSTATE;
    property HumanCount: Integer read FCOUNT;
    procedure ReName(newnam : string);
    procedure ReCount(HumanCount: Integer);
    Procedure ReState(newstate : integer);
    procedure AddMedServiceItem(itm : pointer);
    procedure AddMedOut(itm : pointer);
    procedure AddGVredItem(itm : pointer);
    procedure DelMedServiceItem(idd : integer);
    procedure DelGVredItem(idd : integer);
    function CheckMedSrvInLst(idd : integer) : boolean;
    function CheckCountMedSrvInGVList(idd : integer) : integer;
    procedure Delete;
    procedure DelOutMedServiceItem(idd : integer);
    { Public declarations }
  end;

  TdDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    prof_gen_id : integer;
    // процедуры работы с БД
    Function GetIdentLst(section : string) : variant;
    Function GetIdentCount(section : string) : integer;
    Procedure DelIdent(section,ident : string);
    Procedure DelSection(section : string);
    Procedure WriteIdent(section,ident,vl : string);
    Function ReadParamFromINI(section,ident,def : string) : string;
    Function GenNewID(gen : string) : integer;
    function ReadValArrayFromINI(section,ident : string):variant;
    procedure WriteValArrayToINI(section,ident : string; pars :variant);
    // процедуры работы с группами объектов
    procedure LoadMedServises;
    procedure LoadGVred;
    function GetMedSbyID(idd : integer) : pointer;
    Procedure LoadMSforGV(gva : pointer);
    function GetGVbyID(idd : integer) : pointer;
    function GetPRbyID(idd : integer) : pointer;
    procedure DeleteMSfromINI(ida : pointer);
    procedure DeleteGVfromINI(ida : pointer);
    procedure SaveMStoINI(ida : pointer);
    procedure SaveGVtoINI(ida : pointer);
    procedure SaveAlltoINI;
    procedure FreeAll;
    procedure NewMS(tp, recip :integer; nam : string; pr : real);
    procedure NewGV(cod,nam : string);
    procedure NewPrf(nam : string; HumanCount: Integer);
    procedure LoadProfession;
    procedure LoadGVforPR(gva : pointer);
    procedure SaveProftoINI(ida: Pointer);
    procedure DeleteProffromINI(ida: Pointer);
    { Public declarations }
  end;

var
  dDM: TdDM;
  exe_path : string;
  workini : string;
  ProfField, GVField, MedSField : TList;
  needsave : boolean;

implementation
uses Main;
{$R *.dfm}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykMedService  begin declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

constructor TNykMedService.Create(idd,tp, recip :integer;nam : string; pr : real);
Begin
  inherited Create;
  FID:=idd;
  FTYPE:=tp;
  FRECIP := recip;
  FNAME:=nam;
  FPRICE:=pr;
  FSTATE:=2;
end;

destructor TNykMedService.Destroy;
Begin
  inherited Destroy;
end;

procedure TNykMedService.ReName(newnam : string);
Begin
  FNAME:=newnam;
  If FSTATE>1 Then FSTATE:=3;
end;

Procedure TNykMedService.ReState(newstate : integer);
Begin
  FSTATE:=newstate;
end;

procedure TNykMedService.RePrice(newprice : real);
Begin
  FPRICE:=newprice;
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykMedService.Delete;
Begin
  If FSTATE>1 Then FSTATE:=4 Else FSTATE:=0;
end;

procedure TNykMedService.ReType(NewType: Integer);
begin
 FTYPE := NewType;
 if FSTATE > 1 then FSTATE := 3;
end;

procedure TNykMedService.ReMaleRecip(NewMaleRecip: Integer);
begin
  FRECIP := NewMaleRecip;
  if FSTATE > 1 then FSTATE := 3;
end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykGVred  begin declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

constructor TNykGVred.Create(idd : integer; cod,nam : string);
Begin
  inherited Create;
  FID:=idd;
  FNAME:=nam;
  FCODE:=cod;
  FSTATE:=2;
  FMedServLst:=TList.create;
end;

destructor TNykGVred.Destroy;
Begin
  FMedServLst.Free;
  inherited Destroy;
end;

procedure TNykGVred.ReCode(newcod : string);
Begin
  FCODE:=newcod;
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykGVred.ReName(newnam : string);
Begin
  FNAME:=newnam;
  If FSTATE>1 Then FSTATE:=3;
end;

Procedure TNykGVred.ReState(newstate : integer);
Begin
  FSTATE:=newstate;
end;

procedure TNykGVred.AddMedServiceItem(itm : pointer);
Begin
  FMedServLst.Add(itm);
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykGVred.DelMedServiceItem(idd : integer);
var
  mc : TNykMedService;
  kvo : integer;
Begin
  kvo:=MedServLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    mc:=MedServLst.Items[kvo];
    if mc.Id=idd Then Begin
       MedServLst.Delete(kvo);
       If FSTATE>1 Then FSTATE:=3;
    end;
  end;
end;

function TNykGVred.CheckMedSrvInLst(idd : integer) : boolean;
var
  mc : TNykMedService;
  kvo : integer;
  res : boolean;
Begin
  res:=false;
  kvo:=MedServLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    mc:=MedServLst.Items[kvo];
    if mc.Id=idd Then res:=true;
  end;
  Result:=res;
end;

procedure TNykGVred.Delete;
Begin
  If FSTATE>1 Then FSTATE:=4 Else FSTATE:=0;
end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykProfession  begin declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

constructor TNykProfession.Create(idd : integer; nam : string; HumanCount: Integer);
Begin
  inherited Create;
  FID:=idd;
  FNAME:=nam;
  FCOUNT := HumanCount;
  FSTATE:=2;
  FMedServLst:=TList.create;
  FMedServOutLst := TList.Create;
  FGVredLst:=TList.create;
end;

destructor TNykProfession.Destroy;
Begin
  FMedServLst.Free;
  FMedServOutLst.Free;
  FGVredLst.Free;
  inherited Destroy;
end;

procedure TNykProfession.ReName(newnam : string);
Begin
  FNAME:=newnam;
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykProfession.ReCount(HumanCount: Integer);
Begin
  FCOUNT := HumanCount;
  If FSTATE>1 Then FSTATE:=3;
end;

Procedure TNykProfession.ReState(newstate : integer);
Begin
  FSTATE:=newstate;
end;

procedure TNykProfession.AddMedServiceItem(itm : pointer);
Begin
  if itm=nil Then Exit;
  FMedServLst.Add(itm);
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykProfession.AddMedOut(itm : pointer);
Begin
  if itm=nil Then Exit;
  FMedServOutLst.Add(itm);
end;

function TNykProfession.CheckMedSrvInLst(idd : integer) : boolean;
var
  mc : TNykMedService;
  kvo : integer;
  res : boolean;
Begin
  res:=false;
  kvo:=MedServLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    mc:=MedServLst.Items[kvo];
    if mc.Id=idd Then res:=true;
  end;
  Result:=res;
end;

procedure TNykProfession.AddGVredItem(itm : pointer);
Var
 gv : TNykGVred;
 mc : TNykMedService;
 kvo : integer;
Begin
  if itm=nil Then Exit;
  FGVredLst.Add(itm);
  gv:=itm;
  kvo:=gv.MedServLst.Count;
  While kvo>0 Do Begin
     mc:=gv.MedServLst.Items[kvo-1];
     If mc<>nil Then
        If not CheckMedSrvInLst(mc.Id) Then AddMedServiceItem(mc);
     Dec(kvo);
  end;  
  If FSTATE>1 Then FSTATE:=3;
end;

procedure TNykProfession.DelMedServiceItem(idd : integer);
var
  mc : TNykMedService;
  kvo : integer;
Begin
  kvo:=MedServLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    mc:=MedServLst.Items[kvo];
    if mc.Id=idd Then Begin
       FMedServLst.Delete(kvo);
       If FSTATE>1 Then FSTATE:=3;
       Exit;
    end;
  end;
end;

procedure TNykProfession.DelOutMedServiceItem(idd : integer);
var
  mc : TNykMedService;
  kvo : integer;
Begin
  kvo:=MedServOutLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    mc:=MedServOutLst.Items[kvo];
    if mc.Id=idd Then Begin
       FMedServOutLst.Delete(kvo);
       Exit;
    end;
  end;
end;

function TNykProfession.CheckCountMedSrvInGVList(idd : integer) : integer;
var
  gv : TNykGVred;
  kvo, res : integer;
Begin
  kvo:=GVredLst.Count;
  res:=0;
  While kvo>0 Do Begin
    Dec(kvo);
    gv:=GVredLst.Items[kvo];
    If gv.CheckMedSrvInLst(idd) Then Inc(res);
  end;
  Result:=res;
end;

procedure TNykProfession.DelGVredItem(idd : integer);
var
  gv : TNykGVred;
  mc : TNykMedService;
  kvo,kkvo : integer;
Begin
  kvo:=GVredLst.Count;
  While kvo>0 Do Begin
    Dec(kvo);
    gv:=GVredLst.Items[kvo];
    kkvo:=0;
    if gv.id=idd Then Begin
       kkvo:=gv.MedServLst.Count;
       While kkvo>0 Do Begin
          Dec(kkvo);
          mc:=gv.MedServLst.Items[kkvo];
          If CheckCountMedSrvInGVList(mc.Id)=1 Then Begin
             DelMedServiceItem(mc.Id);
          end;
       end;
       FGVredLst.Delete(kvo);
       If FSTATE>1 Then FSTATE:=3;
       Exit;
    end;
  end;
end;

procedure TNykProfession.Delete;
begin
  If FSTATE>1 Then FSTATE:=4 Else FSTATE:=0;
end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++ Module methods +++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++ INI-file methods ++++++++++++++++++++++++

Function TdDM.ReadParamFromINI(section,ident,def : string) : string;
var
  ini : TInifile;
Begin
  ini:=TIniFile.Create(exe_path+workini);
  Result:=ini.ReadString(section,ident,def);
  ini.free;
end;

Procedure TdDM.WriteIdent(section,ident,vl : string);
var
  ini : TInifile;
Begin
  ini:=TIniFile.Create(exe_path+workini);
  ini.WriteString(section,ident,vl);
  ini.free;
end;

Procedure TdDM.DelIdent(section,ident : string);
var
  ini : TInifile;
Begin
  ini:=TIniFile.Create(exe_path+workini);
  ini.DeleteKey(section,ident);
  ini.free;
end;

Function TdDM.GetIdentCount(section : string) : integer;
var
  ts : TStringList;
Begin
  Result:=0;
  ts:=TStringList.Create;
  ts.text:=GetIdentLst(section);
  Result:=ts.Count;
  ts.free;
end;

Function TdDM.GetIdentLst(section : string) : variant;
var
  ini : TInifile;
  ts : TStringList;
Begin
  ts:=TStringList.Create;
  ini:=TIniFile.Create(exe_path+workini);
  ini.ReadSection(section,ts);
  Result:=ts.Text;
  ini.free;
  ts.free;
end;

Function TdDM.GenNewID(gen : string) : integer;
Begin
  Result:=StrToInt(ReadParamFromINI('ID',gen,'1'));
  WriteIdent('ID',gen,IntToStr(Result+1));
end;

function TdDM.ReadValArrayFromINI(section,ident : string):variant;
var
  pstr : string;
  pars : variant;
Begin
  Result:=null;
  pstr:=ReadParamFromINI(section,ident,'');
  If pstr<>'' Then Begin
     pars:=AnalizeStr(pstr,'|',false);
     If not VarIsNull(pars) Then Result:=pars
  end;
end;

procedure TdDM.WriteValArrayToINI(section,ident : string; pars :variant);
var
  pstr : string;
  kvopar,ii : integer;
Begin
  pstr:='';
  If not VarIsNull(pars) Then Begin
     kvopar:=VarArrayHighBound(pars,1);
     for ii:=0 to kvopar-1 Do pstr:=pstr+String(pars[ii])+'|';
     pstr:=pstr+String(pars[kvopar]);
     WriteIdent(section,ident,pstr);
  end;
end;

Procedure TdDM.DelSection(section : string);
var
  ini : TInifile;
Begin
  ini:=TIniFile.Create(exe_path+workini);
  ini.EraseSection(section);
  ini.free;
end;

//+++++++++++++++++++ Ather functions & methods ++++++++++++++++++++

procedure TdDM.DataModuleCreate(Sender: TObject);
begin
  needsave:= False;
  DecimalSeparator:='.';
  workini:='database.ini';
  ProfField:=TList.Create;
  GVField:=TList.Create;
  MedSField:=TList.Create;
  prof_gen_id:=0; // Генератор для профессий
  LoadMedServises;
  LoadGVred;
  LoadProfession;
  LoadProfGrid(ProfField);
end;

procedure TdDM.LoadMedServises;
var
  ts : TStringList;
  ms : TNykMedService;
  idd,tp,ii, recip : integer;
  nam, ss : string;
  pr : real;
  pp : variant;
Begin
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('MEDSERVICE');
  MedSField.Clear;
  If ts.Count>0 Then
  For ii:=0 to ts.count-1 Do Begin
      ss:=ts.Strings[ii];
      idd:=StrToInt(ss);
      pp:=ReadValArrayFromINI('MEDSERVICE',ss);
      If not VarIsNull(pp) Then Begin
        try
          nam:=String(pp[0]);
          tp:=StrToInt(String(pp[1]));
          pr:=StrToFloat(String(pp[2]));
          recip := StrToInt(String(pp[3]));
          ms:=TNykMedService.Create(idd,tp,recip,nam,pr);
          MedSField.Add(ms);
        except
          // добавить обработку ошибки
        end
      end;
  end;
  ts.Free;
end;

function TdDM.GetMedSbyID(idd : integer) : pointer;
var
  ms : TNykMedService;
  ii : integer;
Begin
  Result:=nil;
  If MedSField.Count>0 Then
  For ii:=0 to MedSField.Count-1 Do Begin
      ms:=MedSField.Items[ii];
      If ms.Id=idd Then Begin
         Result:=ms;
         Exit;
      end;
  end;
end;

function TdDM.GetGVbyID(idd : integer) : pointer;
var
  gv : TNykGVred;
  ii : integer;
Begin
  Result:=nil;
  If GVField.Count>0 Then
  For ii:=0 to GVField.Count-1 Do Begin
      gv:=GVField.Items[ii];
      If gv.Id=idd Then Begin
         Result:=gv;
         Exit;
      end;
  end;
end;

function TdDM.GetPRbyID(idd : integer) : pointer;
var
  pr : TNykProfession;
  ii : integer;
Begin
  Result:=nil;
  If ProfField.Count>0 Then
  For ii:=0 to ProfField.Count-1 Do Begin
      pr:=ProfField.Items[ii];
      If pr.Id=idd Then Begin
         Result:=pr;
         Exit;
      end;
  end;
end;

Procedure TdDM.LoadMSforGV(gva : pointer);
var
  ts : TStringList;
  gv : TNykGVred;
  ii,idd,iid : integer;
  pp : pointer;
Begin
  if gva=nil Then Exit;
  gv:=gva;
  idd:=gv.Id;
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('G'+IntToStr(idd));
  For ii:=0 To ts.Count-1 Do
  Begin
      iid:=StrToInt(ts.Strings[ii]);
      If iid>0 Then
      Begin
         pp:=GetMedSbyID(iid);
         If pp<>nil Then gv.AddMedServiceItem(pp);
      end;

  end;
         { if gv.Id = 22 then
           begin
      gv.AddMedServiceItem(MedSField.Items[0]);
      gv.AddMedServiceItem(MedSField.Items[1]);
          end; }


  ts.Free;
 // fr_main.Caption := TNykGVred().
end;

procedure TdDM.LoadGVforPR(gva : pointer);
var
  ts : TStringList;
  gv : TNykProfession;
  ii,idd,iid : integer;
  pp : pointer;
begin
  if gva=nil Then Exit;
  gv:=gva;
  idd:=gv.Id;
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('P'+IntToStr(idd));
  For ii:=0 To ts.Count-1 Do
  Begin
      iid:=StrToInt(ts.Strings[ii]);
      If iid>0 Then
      Begin
         pp:=GetGVbyID(iid);
         If pp<>nil Then gv.AddGVredItem(pp);
      end;

  end;
end;

procedure TdDM.LoadGVred;
var
  ts : TStringList;
  gv : TNykGVred;
  idd,ii : integer;
  nam, cod, ss : string;
  pp : variant;
Begin
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('GVRED');
  GVField.Clear;
  If ts.Count>0 Then
  For ii:=0 to ts.count-1 Do Begin
      ss:=ts.Strings[ii];
      idd:=StrToInt(ss);
      pp:=ReadValArrayFromINI('GVRED',ss);
      If not VarIsNull(pp) Then Begin
        try
          nam:=String(pp[0]);
          cod:=String(pp[1]);
          gv:=TNykGVred.Create(idd,cod,nam);
          GVField.Add(gv);
          LoadMSforGV(gv);
        except
          // добавить обработку ошибки
        end
      end;
  end;
  ts.Free;
end;

procedure TdDM.LoadProfession;
var
  ts : TStringList;
  pr : TNykProfession;
  idd,ii, humco : integer;
  nam, cod, ss : string;
  pp : variant;
Begin
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('PROFESSIONS');
  ProfField.Clear;
  If ts.Count>0 Then
  For ii:=0 to ts.count-1 Do Begin
      ss:=ts.Strings[ii];
      idd:=StrToInt(ss);
      pp:=ReadValArrayFromINI('PROFESSIONS',ss);
      If not VarIsNull(pp) Then Begin
        try
          nam:=String(pp[0]);
          humco:=Integer(pp[1]);
          pr:=TNykProfession.Create(idd,nam, humco);
          ProfField.Add(pr);
          LoadGVforPR(pr);
        except
          // добавить обработку ошибки
        end
      end;
  end;
  ts.Free;
end;

procedure TdDM.DeleteMSfromINI(ida : pointer);
var
  ms : TNykMedService;
  idd,ii : integer;
//  ss : string;
  ts : TStringList;
Begin
  if ida=nil Then Exit;
  ms:=ida;
  idd:=ms.Id;
  DelIdent('MEDSERVICE',IntToStr(idd));
  ts:=TStringList.Create;
  ts.Text:=GetIdentLst('GVRED');
  For ii:=0 to ts.count-1 Do DelIdent('G'+ts.Strings[ii],IntToStr(idd));
  ts.Free;
end;

procedure TdDM.DeleteGVfromINI(ida : pointer);
var
  gv : TNykGVred;
  idd : integer;
Begin
  gv:=ida;
  idd:=gv.Id;
  DelIdent('GVRED',IntToStr(idd));
  DelSection('G'+IntToStr(idd));
end;

procedure TdDM.DeleteProffromINI(ida: Pointer);
var
  pr: TNykProfession;
  idd: Integer;
Begin
  pr := ida;
  idd := pr.Id;
  DelIdent('PROFESSIONS', IntToStr(idd));
  DelSection('P' + IntToStr(idd));
end;

procedure TdDM.SaveMStoINI(ida : pointer);
var
  ms : TNykMedService;
  ss : string;
Begin
  if ida=nil Then Exit;
  ms:=ida;
  Case ms.State of
     1,3 : Begin
             ss:=ms.Name+'|'+IntToStr(ms.TypeItem)+'|'+FloatToStr(ms.price)+'|'+IntToStr(ms.FRECIP);
             WriteIdent('MEDSERVICE',IntToStr(ms.Id),ss);
             ms.ReState(2);
           end;
     4   : Begin
             DeleteMSfromINI(ida);
             ms.ReState(0);
           end;
  end;
end;

procedure TdDM.SaveGVtoINI(ida : pointer);
var
  gv : TNykGVred;
  ms : TNykMedService;
  ss : string;
  ii : integer;
Begin
  if ida=nil Then Exit;
  gv:=ida;

  Case gv.State of
     1,3 : Begin
             ss:=gv.Name+'|'+gv.Code;
             WriteIdent('GVRED',IntToStr(gv.Id),ss);
             DelSection('G'+IntToStr(gv.Id));
             For ii:=0 To gv.MedServLst.Count-1 Do Begin
                 ms:=gv.MedServLst.Items[ii];
                 If (ms.State<>2)and(ms.State<>0) Then SaveMStoINI(ms);
                 If ms.State=2 Then WriteIdent('G'+IntToStr(gv.Id),IntToStr(ms.Id),'0');
             end;
             gv.ReState(2);
           end;
     4   : Begin
             DeleteGVfromINI(ida);
             gv.ReState(0);
           end;
  end;
end;

procedure TdDM.SaveProftoINI(ida: Pointer);
var
  pr: TNykProfession;
  gv: TNykGVred;
  ms: TNykMedService;
  ss: string;
  ii: Integer;
Begin
  if ida = nil then Exit;
  pr := ida;

  case pr.State of
     1,3: begin
             ss := pr.Name + '|' + IntToStr(pr.HumanCount);
             WriteIdent('PROFESSIONS', IntToStr(pr.Id), ss);
             DelSection('P' + IntToStr(pr.Id));
             for ii := 0 To pr.GVredLst.Count - 1 do
               begin
                 gv := pr.GVredLst.Items[ii];
                 If (gv.State <> 2) and (gv.State <> 0) then SaveGVtoINI(gv);
                 If gv.State = 2 then WriteIdent('P' + IntToStr(pr.Id), IntToStr(gv.Id), '0');
               end;
             pr.ReState(2);
          end;
     4  : begin
            DeleteProffromINI(ida);
            pr.ReState(0);
          end;
  end;
end;

procedure TdDM.SaveAlltoINI;
var
  ii : integer;
Begin
  For ii:=0 To MedSField.Count-1 Do SaveMStoINI(MedSField.Items[ii]);
  For ii:=0 To GVField.Count-1 Do SaveGVtoINI(GVField.Items[ii]);
  For ii:=0 To ProfField.Count-1 Do SaveProftoINI(ProfField.Items[ii]);
end;

procedure TdDM.FreeAll;
var
  ii : integer;
  gv : TNykGVred;
  ms : TNykMedService;
  prf : TNykProfession;
Begin
  For ii:=0 To ProfField.Count-1 Do Begin
      prf:=ProfField.Items[ii];
      prf.Free;
      ProfField.Items[ii]:=nil;
  end;
  ProfField.Clear;
  For ii:=0 To GVField.Count-1 Do Begin
      gv:=GVField.Items[ii];
      gv.Free;
      GVField.Items[ii]:=nil;
  end;
  GVField.Clear;
  For ii:=0 To MedSField.Count-1 Do Begin
      ms:=MedSField.Items[ii];
      ms.Free;
      MedSField.Items[ii]:=nil;
  end;
  MedSField.Clear;
end;

procedure TdDM.NewMS(tp, recip :integer; nam : string; pr : real);
var
  ms : TNykMedService;
  idd : integer;
Begin
  idd:=GenNewID('medserv');
  ms:=TNykMedService.Create(idd,tp, recip,nam,pr);
  MedSField.Add(ms);
  ms.ReState(1);
end;

procedure TdDM.NewGV(cod,nam : string);
var
  idd : integer;
  gv : TNykGVred;
Begin
  idd:=GenNewID('gvred');
  gv:=TNykGVred.Create(idd,cod,nam);
  gv.ReState(1);
  GVField.Add(gv);
end;

procedure TdDM.NewPrf(nam : string; HumanCount: Integer);
var idd: Integer;
    prf: TNykProfession;
Begin
  idd := GenNewID('profs');
  prf:=TNykProfession.Create(idd, nam, HumanCount);
  prf.ReState(1);
  ProfField.Add(prf);
end;

procedure TdDM.DataModuleDestroy(Sender: TObject);
begin
  If needsave Then SaveAlltoINI;
  FreeAll;
  ProfField.Free;
  GVField.Free;
  MedSField.Free;
end;

end.
