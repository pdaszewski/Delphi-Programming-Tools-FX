object AOknoGl: TAOknoGl
  Left = 0
  Top = 0
  Caption = 'Delphi Programming Tools FX'
  ClientHeight = 431
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
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 412
    Width = 758
    Height = 19
    Panels = <>
  end
  object PageScroller1: TPageScroller
    Left = 0
    Top = 0
    Width = 758
    Height = 412
    Align = alClient
    Control = PageControl1
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 758
      Height = 412
      ActivePage = TabSheet1
      Style = tsFlatButtons
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Czyszczenie projekt'#243'w z folder'#243'w historii'
        DesignSize = (
          750
          381)
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
          Height = 350
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
        end
        object Button1: TButton
          Left = 255
          Top = 3
          Width = 492
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'przeszukaj projekty w celu wykrycia plik'#243'w i folder'#243'w do usuni'#281'c' +
            'ia'
          TabOrder = 2
          OnClick = Button1Click
        end
        object ListBox1: TListBox
          Left = 255
          Top = 30
          Width = 492
          Height = 295
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 3
        end
        object Button2: TButton
          Left = 255
          Top = 353
          Width = 492
          Height = 25
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'czy'#347#263' projekty Delphi'
          TabOrder = 4
          OnClick = Button2Click
        end
        object ProgressBar1: TProgressBar
          Left = 255
          Top = 330
          Width = 492
          Height = 17
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 5
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
