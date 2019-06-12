unit AOknoGl_frm;

interface

uses
  Winapi.Windows
  ,Winapi.Messages
  ,System.SysUtils
  ,System.Variants
  ,System.Classes
  ,Vcl.ComCtrls
  ,Vcl.Controls
  ,Vcl.Dialogs
  ,Vcl.FileCtrl
  ,Vcl.Forms
  ,Vcl.Graphics
  ,Vcl.Menus
  ,Vcl.StdCtrls;

type
  TAOknoGl = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Zamknij1: TMenuItem;
    PageScroller1: TPageScroller;
    ZakladkiFunkcji: TPageControl;
    TabCzyszczenieHistorii: TTabSheet;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    btn_szukaj: TButton;
    lbox_smieci: TListBox;
    btn_czysc: TButton;
    ProgressBar1: TProgressBar;
    Pomoc1: TMenuItem;
    Informacjao1: TMenuItem;
    chck_history: TCheckBox;
    chck_recovery: TCheckBox;
    chck_dcu: TCheckBox;
    TabFormatowanieUSES: TTabSheet;
    DriveComboBox2: TDriveComboBox;
    DirectoryListBox2: TDirectoryListBox;
    btn_skanuj_pas: TButton;
    lbox_pliki_pas: TListBox;
    ProgressFormatowanie: TProgressBar;
    btn_formatuj_pas: TButton;

    procedure FormatujPlikPAS(nazwa_pliku: string);

    procedure FormCreate(Sender: TObject);
    procedure Zamknij1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure btn_szukajClick(Sender: TObject);
    procedure FindDocs(const Root: string);
    procedure FindPas(const Root: string);
    procedure DeleteDirectory(const Name: string);
    procedure btn_czyscClick(Sender: TObject);
    procedure Informacjao1Click(Sender: TObject);
    procedure DriveComboBox2Change(Sender: TObject);
    procedure btn_skanuj_pasClick(Sender: TObject);
    procedure btn_formatuj_pasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
 wersja = '1.0.6';

var
  AOknoGl: TAOknoGl;

implementation

{$R *.dfm}

procedure TAOknoGl.FormatujPlikPAS(nazwa_pliku: string);
Var
  plik : TStringList;
  i: Integer;
  global_uses: Boolean;
  local_uses: Boolean;
  linia: string;
  tab_global: array[1..10000] of Integer;
  tab_local: array[1..10000] of Integer;
  global_pos: Integer;
  local_pos: Integer;
  global_uses_list : TStringList;
  local_uses_list : TStringList;
  czy_gbylo_global_uses : Boolean;
  czy_gbylo_local_uses : Boolean;
  lista_pom : TStringList;
  unit_name: string;
  poz: Integer;
  wpis_windows: string;
  czy_byl_wpis_windows: Boolean;
Begin
 global_uses := False;
 local_uses := False;
 czy_gbylo_global_uses := False;
 czy_gbylo_local_uses := False;

 global_uses_list := TSTringList.Create;
 local_uses_list := TSTringList.Create;
 lista_pom := TStringList.Create;

 for i := 1 to 10000 do
  Begin
   tab_global[i] := 0;
   tab_local[i] := 0;
  End;

 global_pos := 1;
 local_pos := 1;

 plik := TStringList.Create;
 plik.LoadFromFile(nazwa_pliku);
  for i := 0 to plik.Count-1 do
   Begin
    linia:=Trim(plik.Strings[i]);

    // -------------------------->> Czêœæ dla Global <<----------------------------------------------------

    if (AnsiLowerCase(linia)='uses') or (Pos('uses ', AnsiLowerCase(linia))=1) then
     Begin
      if czy_gbylo_global_uses=False then
       Begin
        czy_gbylo_global_uses:=True;
        global_uses:=True;
        tab_global[global_pos]:=i;
        Inc(global_pos);
        linia:=StringReplace(linia,'uses','',[rfReplaceAll, rfIgnoreCase]);
       End;
     End;

    if (global_uses=True) then
     Begin
      tab_global[global_pos]:=i;
      Inc(global_pos);
      global_uses_list.Add(linia);
     End;

    if (global_uses=True) and (Pos(';',linia)>0) then
     Begin
      global_uses:=False;
     End;

   // -------------------------->> Czêœæ dla Local <<----------------------------------------------------

    if (czy_gbylo_global_uses) and ((AnsiLowerCase(linia)='uses') or (Pos('uses ', AnsiLowerCase(linia))=1)) then
     Begin
      if czy_gbylo_local_uses=False then
       Begin
        local_uses:=True;
        czy_gbylo_local_uses:=True;
        tab_local[local_pos]:=i;
        Inc(local_pos);
        linia:=StringReplace(linia,'uses','',[rfReplaceAll, rfIgnoreCase]);
       End;
     End;

    if (local_uses=True) then
     Begin
      tab_local[local_pos]:=i;
      Inc(local_pos);
      local_uses_list.Add(linia);
     End;

    if (local_uses=True) and (Pos(';',linia)>0) then
     Begin
      local_uses:=False;
     End;

   End;

 if czy_gbylo_local_uses then
  Begin
 //===========================================================================================
 //Kasuje Local USES
 lista_pom.Clear;
 for i := 10000 downto 1 do
  Begin
   if tab_local[i]>0 then plik.Delete(tab_local[i]);
  End;
 //===========================================================================================
 //Przygotowujê listê unitów
 for i := 0 to local_uses_list.Count-1 do
  Begin
   linia:=local_uses_list.Strings[i];
   linia:=Trim(StringReplace(linia,';','',[rfReplaceAll]));
   if linia<>'' then
    Begin
     if Pos(',',linia)>0 then
      Begin
       Repeat
        poz:=Pos(',',linia); unit_name := Trim(Copy(linia,1,poz-1)); Delete(linia,1,poz);
        lista_pom.Add(unit_name);
       Until Pos(',',linia)=0;
       lista_pom.Add(Trim(linia));
      End
     else lista_pom.Add(Trim(linia));
    End;
  End;
 //===========================================================================================
 //Czyszczê œmieci - by by³a czytelniejsza
 for i := lista_pom.Count-1 downto 0 do
  Begin
   if Trim(lista_pom.Strings[i])='' then lista_pom.Delete(i);
  End;

 czy_byl_wpis_windows := False;
 for i := lista_pom.Count-1 downto 0 do
  Begin
   if Pos('windows',AnsiLowerCase(lista_pom.Strings[i]))>0 then
    Begin
     czy_byl_wpis_windows:=True;
     wpis_windows:=lista_pom.Strings[i];
     lista_pom.Delete(i);
    End;
  End;

 if czy_byl_wpis_windows then lista_pom.Insert(0,wpis_windows);
 //===========================================================================================
 //Formatujê listê unitów
 for i:= 1 to lista_pom.Count-1 do
  if Pos('{',lista_pom.Strings[i])=0 then lista_pom.Strings[i]:='  ,'+lista_pom.Strings[i]
  else lista_pom.Strings[i]:=lista_pom.Strings[i];
  lista_pom.Strings[0]:='  '+lista_pom.Strings[0];
  lista_pom.Insert(0,'uses');
  lista_pom.Strings[lista_pom.Count-1]:=lista_pom.Strings[lista_pom.Count-1]+';';
 //===========================================================================================
 //Wstawiam gotow¹ listê do pliku.
 plik.Insert(tab_local[1],lista_pom.Text);
 //===========================================================================================
 end;

 if czy_gbylo_global_uses then
  Begin
 //===========================================================================================
 //Kasuje Global USES
 lista_pom.Clear;
 for i := 10000 downto 1 do
  Begin
   if tab_global[i]>0 then plik.Delete(tab_global[i]);
  End;
 //===========================================================================================
 //Przygotowujê listê unitów
 for i := 0 to global_uses_list.Count-1 do
  Begin
   linia:=global_uses_list.Strings[i];
   linia:=Trim(StringReplace(linia,';','',[rfReplaceAll]));
   if linia<>'' then
    Begin
     if Pos(',',linia)>0 then
      Begin
       Repeat
        poz:=Pos(',',linia); unit_name := Trim(Copy(linia,1,poz-1)); Delete(linia,1,poz);
        lista_pom.Add(unit_name);
       Until Pos(',',linia)=0;
       lista_pom.Add(Trim(linia));
      End
     else lista_pom.Add(Trim(linia));
    End;
  End;
 //===========================================================================================
 //Czyszczê œmieci - by by³a czytelniejsza
 for i := lista_pom.Count-1 downto 0 do
  Begin
   if Trim(lista_pom.Strings[i])='' then lista_pom.Delete(i);
  End;

 czy_byl_wpis_windows := False;
 for i := lista_pom.Count-1 downto 0 do
  Begin
   if Pos('windows',AnsiLowerCase(lista_pom.Strings[i]))>0 then
    Begin
     czy_byl_wpis_windows:=True;
     wpis_windows:=lista_pom.Strings[i];
     lista_pom.Delete(i);
    End;
  End;

 if czy_byl_wpis_windows then lista_pom.Insert(0,wpis_windows);
 //===========================================================================================
 //Formatujê listê unitów
 for i:= 1 to lista_pom.Count-1 do
 if Pos('{',lista_pom.Strings[i])=0 then lista_pom.Strings[i]:='  ,'+lista_pom.Strings[i]
  else lista_pom.Strings[i]:=lista_pom.Strings[i];
  lista_pom.Strings[0]:='  '+lista_pom.Strings[0];
  lista_pom.Insert(0,'uses');
  lista_pom.Strings[lista_pom.Count-1]:=lista_pom.Strings[lista_pom.Count-1]+';';
 //===========================================================================================
 //Wstawiam gotow¹ listê do pliku.
 plik.Insert(tab_global[1],lista_pom.Text);
 //===========================================================================================
 end;

 plik.SaveToFile(nazwa_pliku);
 plik.Free;
 global_uses_list.Free;
 local_uses_list.Free;
 lista_pom.Free;
End;

procedure TAOknoGl.btn_formatuj_pasClick(Sender: TObject);
var
  wyb: Integer;
  i: Integer;
begin
 if lbox_pliki_pas.Items.Count>0 then
  Begin
   wyb := MessageBox(Handle,
    PWideChar('Czy na pewno sformatowaæ sekcje USES w projektach Delphi?'+#13
    +'Zmiany bêd¹ nieodwracalne!'),
    'Formatowanie USES projektów Delphi', MB_YESNO + MB_ICONQUESTION);
    if wyb = mrYes then
     Begin
      btn_formatuj_pas.Enabled:=False;
      Application.ProcessMessages;
      ProgressFormatowanie.Position:=0;
      ProgressFormatowanie.Max:=lbox_pliki_pas.Items.Count;
      for i := 0 to lbox_pliki_pas.Items.Count-1 do
       Begin
        if FileExists(lbox_pliki_pas.Items.Strings[i]) then FormatujPlikPAS(lbox_pliki_pas.Items.Strings[i]);
        lbox_pliki_pas.Items.Strings[i]:='FORMATOWANY!! - '+lbox_pliki_pas.Items.Strings[i];
        ProgressFormatowanie.Position:=i;
        Application.ProcessMessages;
       End;
       ProgressFormatowanie.Position:=ProgressFormatowanie.Max;
       StatusBar1.Panels[2].Text:='Sformatowano: '+IntToStr(lbox_pliki_pas.Items.Count);
     End;
  End
 else ShowMessage('Brak plików kodu Delphi do formatowania!');
end;

procedure TAOknoGl.btn_skanuj_pasClick(Sender: TObject);
begin
 lbox_pliki_pas.Clear;
 FindPas(DirectoryListBox2.Directory);
 ProgressBar1.Position:=0;
 if lbox_pliki_pas.Items.Count>0 then
  Begin
   btn_formatuj_pas.Enabled:=True;
   StatusBar1.Panels[2].Text:='Do formatowania: '+IntToStr(lbox_pliki_pas.Items.Count);
  End
 else
  Begin
   btn_formatuj_pas.Enabled:=False;
   StatusBar1.Panels[2].Text:='';;
  End;
end;

procedure TAOknoGl.btn_szukajClick(Sender: TObject);
begin
 lbox_smieci.Clear;
 FindDocs(DirectoryListBox1.Directory);
 ProgressBar1.Position:=0;
 if lbox_smieci.Items.Count>0 then
  Begin
   btn_czysc.Enabled:=True;
   StatusBar1.Panels[1].Text:='Do usuniêcia: '+IntToStr(lbox_smieci.Items.Count);
  End
 else
  Begin
   btn_czysc.Enabled:=False;
   StatusBar1.Panels[1].Text:='';
  End;
end;

procedure TAOknoGl.DriveComboBox1Change(Sender: TObject);
begin
 DirectoryListBox1.Drive:=DriveComboBox1.Drive;
end;

procedure TAOknoGl.DriveComboBox2Change(Sender: TObject);
begin
 DirectoryListBox2.Drive:=DriveComboBox2.Drive;
end;

procedure TAOknoGl.FormCreate(Sender: TObject);
begin
 Caption:='Delphi Programming Tools FX - Wersja: '+wersja;
 btn_czysc.Enabled:=False;
end;

procedure TAOknoGl.FormShow(Sender: TObject);
begin
 ZakladkiFunkcji.ActivePage := TabCzyszczenieHistorii;
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
          and (SearchRec.Name='__history') then
           Begin
            if chck_history.Checked then lbox_smieci.Items.Add(Folder + SearchRec.Name);
            Application.ProcessMessages;
           End;
          if ((SearchRec.Attr and faDirectory) = faDirectory)
          and (SearchRec.Name='__recovery') then
           Begin
            if chck_recovery.Checked then lbox_smieci.Items.Add(Folder + SearchRec.Name);
            Application.ProcessMessages;
           End;
          if ExtractFileExt(SearchRec.Name)='.dcu' then
           Begin
            if chck_dcu.Checked then lbox_smieci.Items.Add(Folder + SearchRec.Name);
            Application.ProcessMessages;
           End;
        end;
      until (FindNext(SearchRec) <> 0);
      FindClose(SearchRec);
    end;
  end;
end;

procedure TAOknoGl.FindPas(const Root: string);
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
          if ExtractFileExt(SearchRec.Name)='.pas' then
           Begin
            lbox_pliki_pas.Items.Add(Folder + SearchRec.Name);
            Application.ProcessMessages;
           End;
        end;
      until (FindNext(SearchRec) <> 0);
      FindClose(SearchRec);
    end;
  end;
end;

procedure TAOknoGl.btn_czyscClick(Sender: TObject);
var
  wyb: Integer;
  i: Integer;
begin
 if lbox_smieci.Items.Count>0 then
  Begin
   wyb := MessageBox(Handle,
    PWideChar('Czy na pewno chcesz usun¹æ foldery zmian w projektach Delphi?'+#13
    +'Zmiany bêd¹ nieodwracalne!'),
    'Usuwanie historii projektów Delphi', MB_YESNO + MB_ICONQUESTION);
    if wyb = mrYes then
     Begin
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=lbox_smieci.Items.Count;
      for i := 0 to lbox_smieci.Items.Count-1 do
       Begin
        if FileExists(lbox_smieci.Items.Strings[i]) then DeleteFile(lbox_smieci.Items.Strings[i]);
        if DirectoryExists(lbox_smieci.Items.Strings[i]) then DeleteDirectory(lbox_smieci.Items.Strings[i]);
        lbox_smieci.Items.Strings[i]:='USUNIÊTY!! - '+lbox_smieci.Items.Strings[i];
        ProgressBar1.Position:=i;
        Application.ProcessMessages;
       End;
       ProgressBar1.Position:=ProgressBar1.Max;
       btn_czysc.Enabled:=False;
       StatusBar1.Panels[1].Text:='Usuniêto: '+IntToStr(lbox_smieci.Items.Count);
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
