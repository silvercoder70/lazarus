unit uDataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LazHelpHTML, SQLite3Conn, SQLDB, DB;

type

  { TPostDataModule }

  TPostDataModule = class(TDataModule)
    DataSource1: TDataSource;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure SQLQuery1AfterInsert(DataSet: TDataSet);
    procedure SQLQuery1BeforeInsert(DataSet: TDataSet);
  private

  public
    procedure CreateDatabase;
  end;

var
  PostDataModule: TPostDataModule;

implementation

{$R *.lfm}

{ TPostDataModule }

procedure TPostDataModule.SQLQuery1BeforeInsert(DataSet: TDataSet);
begin
end;

procedure TPostDataModule.SQLQuery1AfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('Created_Time').AsDateTime := Date;
  DataSet.FieldByName('LastModified_Time').AsDateTime := Date;
end;

procedure TPostDataModule.CreateDatabase;
var
  newFile : Boolean;
begin
  SQLite3Connection1.Close; // Ensure the connection is closed when we start

  newFile := not FileExists(SQLite3Connection1.DatabaseName);

  if newFile then
  begin
    SQLite3Connection1.Open;
    SQLTransaction1.Active := true;
    SQLite3Connection1.ExecuteDirect('CREATE TABLE "DATA"('+
                ' "id" Integer NOT NULL PRIMARY KEY AUTOINCREMENT,'+
                ' "Created_Time" DateTime,'+
                ' "LastModified_Time" DateTime,'+
                ' "User_Name" Char(128),'+
                ' "Title" Char(256) NOT NULL,' +
                ' "URI" Char(512) NOT NULL);');

    SQLite3Connection1.ExecuteDirect('CREATE UNIQUE INDEX "Data_id_idx" ON "DATA"( "id" );');
    //SQLite3Connection1.ExecuteDirect('CREATE INDEX "Data_Created_Time_idx" ON "DATA"( "Created_Time" );');
    //SQLite3Connection1.ExecuteDirect('CREATE INDEX "Data_LastModified_Time_idx" ON "DATA"( "LastModified_Time" );');

    SQLTransaction1.Commit;
  end;
end;

end.

