unit fMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls, windows, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Show1: TMenuItem;
    Open1: TMenuItem;
    Run1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  n: Integer = 0;
  srf: TSearchRec;
  st: String;

implementation

procedure LoadFile;
begin
  if n = 0 then
  begin
    if FindFirst('*.jpg', faAnyFile, srf) <> 0 then Exit;
    try
      Form1.Image1.Picture.LoadFromFile(srf.Name);
    except
      st := 'Неправильный формат ' + srf.Name;
      Application.MessageBox(PChar(st), 'Error', MB_OK);
      exit;
    end;
    n := 1;
    end else
    begin
      if FindNext(srf)=0 then
      try
        Form1.Image1.Picture.LoadFromFile(srf.Name);
      except
        st := 'Неправильный формат ' + srf.Name;
        Application.MessageBox(PChar(st), 'Error', MB_OK);
        exit;
      end
      else
      begin
        //FindClose(srf);
        n := 0;
      end;
    end;
end;


{$R *.lfm}

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Image1.Picture.LoadFromFile(OpenDialog1.FileName)
  else
  begin
    st := 'Неправильный формат ' + OpenDialog1.FileName;
    Application.MessageBox(PChar(st), 'Error', MB_OK);
    Exit;
  end;
  n := 0
end;

procedure TForm1.Run1Click(Sender: TObject);
begin
  if Timer1.Enabled = False then
  begin
    Run1.Caption := 'Стоп';
    Timer1.Enabled := True;
  end else
  begin
    Run1.Caption := 'Запуск';
    Timer1.Enabled := False;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  LoadFile;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LoadFile;
end;

end.

