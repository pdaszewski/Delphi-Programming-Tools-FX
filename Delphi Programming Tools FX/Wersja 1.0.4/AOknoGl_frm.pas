unit AOknoGl_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.FileCtrl;

type
  TAOknoGl = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Zamknij1: TMenuItem;
    PageScroller1: TPageScroller;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    Pomoc1: TMenuItem;
    Informacjao1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Zamknij1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FindDocs(const Root: string);
    procedure DeleteDirectory(const Name: string);
    procedure Button2Click(Sender: TObject);
    procedure Informacjao1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
 wersja = '1.0.4';

var
  AOknoGl: TAOknoGl;

implementation

{$R *.dfm}

procedure TAOknoGl.Button1Click(Sender: TObject);
begin
 ListBox1.Clear;
 FindDocs(DirectoryListBox1.Directory);
 ProgressBar1.Position:=0;
 if ListBox1.Items.Count>0 then Button2.Enabled:=True;
end;

procedure TAOknoGl.DriveComboBox1Change(Sender: TObject);
begin
 DirectoryListBox1.Drive:=DriveComboBox1.Drive;
end;

procedure TAOknoGl.FormCreate(Sender: TObject);
begin
 Caption:='Delphi Programming Tools FX - Wersja: '+wersja;
 Button2.Enabled:=False;
end;

procedure TAOknoGl.Informacjao1Click(Sender: TObject);
begin
 ShowMessage('Informacja o programie...'+#13+#13
 +'Delphi Programming Tools FX'+#13
 +'Wersja: '+wersja+#13
 +'Zestaw narzêdzi pomocniczych dla koderów Delphi!'+#13
 +'Przygotowany przez:'+#13
 +'FX Systems Piotr Daszewski'#13
 +'Wszystkie prawa zastrze¿one!');
end;

procedure TAOknoGl.Zamknij1Click(Sender: TObject);
begin
 Close;
end;

procedure TAOknoGl.FindDocs(const Root: string);
var
  SearchRec: TSearchRec;
  Folders: array of string;
  Folder: string;
  I: Integer;
  Last: Integer;
begin
  SetLength(Folders, 1);
  Folders[0] := Root;
  I := 0;
  while (I < Length(Folders)) do
  begin
    Folder := IncludeTrailingBackslash(Folders[I]);
    Inc(I);
    if (FindFirst(Folder + '*.*', faAnyFile, SearchRec) = 0) then
    begin
      repeat
        Application.ProcessMessages;
        if not ((SearchRec.Name = '.') or (SearchRec.Name = '..')) then
        begin
          Last := Length(Folders);
          SetLength(Folders, Succ(Last));
          Folders[Last] := Folder + SearchRec.Name;
          if ((SearchRec.Attr and faDirectory) = faDirectory)
          and ((SearchRec.Name='__history') OR (SearchRec.Name='__recovery')) then
           Begin
            ListBox1.Items.Add(Folder + SearchRec.Name);
            Application.ProcessMessages;
           End;
        end;
      until (FindNext(SearchRec) <> 0);
      FindClose(SearchRec);
    end;
  end;
end;

procedure TAOknoGl.Button2Click(Sender: TObject);
var
  wyb: Integer;
  i: Integer;
begin
 if ListBox1.Items.Count>0 then
  Begin
   wyb := MessageBox(Handle,
    PWideChar('Czy na pewno chcesz usun¹æ foldery zmian w projektach Delphi?'+#13
    +'Zmiany bêd¹ nieodwracalne!'),
    'Usuwanie historii projektów Delphi', MB_YESNO + MB_ICONQUESTION);
    if wyb = mrYes then
     Begin
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=ListBox1.Items.Count;
      for i := 0 to ListBox1.Items.Count-1 do
       Begin
        DeleteDirectory(ListBox1.Items.Strings[i]);
        ListBox1.Items.Strings[i]:='USUNIÊTY!! - '+ListBox1.Items.Strings[i];
        ProgressBar1.Position:=i;
        Application.ProcessMessages;
       End;
       ProgressBar1.Position:=ProgressBar1.Max;
       Button2.Enabled:=False;
     End;
  End
 else ShowMessage('Brak folderów zmian historycznych projektów Delphi do wyczyszczenia!');
end;

procedure TAOknoGl.DeleteDirectory(const Name: string);
var
  F: TSearchRec;
begin
  if FindFirst(Name + '\*', faAnyFile, F) = 0 then begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then begin
          if (F.Name <> '.') and (F.Name <> '..') then begin
            DeleteDirectory(Name + '\' + F.Name);
          end;
        end else begin
          DeleteFile(Name + '\' + F.Name);
        end;
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
    RemoveDir(Name);
  end;
end;

end.
