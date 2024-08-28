unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DBCtrls, DBExtCtrls, uDataModule, DB, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Title: TLabel;
    Title1: TLabel;
    Title2: TLabel;
    Title3: TLabel;
    Title4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OnOpenUrl(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses lclintf;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  PostDataModule.CreateDatabase;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  PostDataModule.SQLQuery1.Open;
end;

procedure TForm1.OnOpenUrl(Sender: TObject);
var
  LURI: string;
begin
  LURI := DBGrid1.DataSource.DataSet.FieldByName('URI').AsString;
  OpenURL(LURI);
end;


procedure TForm1.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  LDS: TDataSet;
begin
  LDS := (Sender as TDBGrid).DataSource.DataSet;
  if (LDS.FieldByName('Created_Time').AsDateTime < (Now-7)) then
  begin
    (Sender as TDBGrid).Canvas.Font.Color:=clRed;
    (Sender as TDBGrid).Canvas.Font.Style:=
      (Sender as TDBGrid).Canvas.Font.Style + [fsItalic];
  end;
end;


end.

