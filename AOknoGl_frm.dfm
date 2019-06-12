object AOknoGl: TAOknoGl
  Left = 0
  Top = 0
  Caption = 'Delphi Programming Tools FX'
  ClientHeight = 567
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 548
    Width = 758
    Height = 19
    Panels = <
      item
        Width = 10
      end
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object PageScroller1: TPageScroller
    Left = 0
    Top = 0
    Width = 758
    Height = 548
    Align = alClient
    Control = ZakladkiFunkcji
    TabOrder = 1
    object ZakladkiFunkcji: TPageControl
      Left = 0
      Top = 0
      Width = 758
      Height = 548
      ActivePage = TabFormatowanieUSES
      Style = tsFlatButtons
      TabOrder = 0
      object TabCzyszczenieHistorii: TTabSheet
        Caption = 'Czyszczenie projekt'#243'w z folder'#243'w historii'
        DesignSize = (
          750
          517)
        object DriveComboBox1: TDriveComboBox
          Left = 3
          Top = 3
          Width = 246
          Height = 19
          TabOrder = 0
          OnChange = DriveComboBox1Change
        end
        object DirectoryListBox1: TDirectoryListBox
          Left = 3
          Top = 28
          Width = 246
          Height = 486
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
        end
        object btn_szukaj: TButton
          Left = 255
          Top = 3
          Width = 492
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'przeszukaj projekty w celu wykrycia plik'#243'w i folder'#243'w do usuni'#281'c' +
            'ia'
          TabOrder = 2
          OnClick = btn_szukajClick
        end
        object lbox_smieci: TListBox
          Left = 255
          Top = 76
          Width = 492
          Height = 385
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 3
        end
        object btn_czysc: TButton
          Left = 255
          Top = 489
          Width = 492
          Height = 25
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'czy'#347#263' projekty Delphi'
          TabOrder = 4
          OnClick = btn_czyscClick
        end
        object ProgressBar1: TProgressBar
          Left = 255
          Top = 466
          Width = 492
          Height = 17
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 5
        end
        object chck_history: TCheckBox
          Left = 255
          Top = 30
          Width = 194
          Height = 17
          Caption = 'foldery __history'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object chck_recovery: TCheckBox
          Left = 407
          Top = 30
          Width = 194
          Height = 17
          Caption = 'foldery __recovery'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object chck_dcu: TCheckBox
          Left = 255
          Top = 53
          Width = 194
          Height = 17
          Caption = 'pliki .dcu'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
      end
      object TabFormatowanieUSES: TTabSheet
        Caption = 'Formatowanie USES pod GIT'
        ImageIndex = 1
        DesignSize = (
          750
          517)
        object DriveComboBox2: TDriveComboBox
          Left = 3
          Top = 3
          Width = 246
          Height = 19
          TabOrder = 0
          OnChange = DriveComboBox2Change
        end
        object DirectoryListBox2: TDirectoryListBox
          Left = 3
          Top = 28
          Width = 246
          Height = 486
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
        end
        object btn_skanuj_pas: TButton
          Left = 255
          Top = 3
          Width = 492
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Caption = 'skanuj foldery w poszukiwaniu plik'#243'w .pas'
          TabOrder = 2
          OnClick = btn_skanuj_pasClick
        end
        object lbox_pliki_pas: TListBox
          Left = 255
          Top = 28
          Width = 492
          Height = 432
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 3
        end
        object ProgressFormatowanie: TProgressBar
          Left = 255
          Top = 466
          Width = 492
          Height = 17
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 4
        end
        object btn_formatuj_pas: TButton
          Left = 255
          Top = 489
          Width = 492
          Height = 25
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'formatuj sekcje USES plik'#243'w .pas'
          TabOrder = 5
          OnClick = btn_formatuj_pasClick
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 328
    Top = 280
    object Plik1: TMenuItem
      Caption = 'Plik'
      object Zamknij1: TMenuItem
        Caption = 'Zamknij'
        OnClick = Zamknij1Click
      end
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
      object Informacjao1: TMenuItem
        Caption = 'Informacja o...'
        OnClick = Informacjao1Click
      end
    end
  end
end
