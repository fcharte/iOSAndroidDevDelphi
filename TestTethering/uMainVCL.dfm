object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 451
  ClientWidth = 385
  Color = clInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblID: TLabel
    Left = 16
    Top = 8
    Width = 12
    Height = 13
    Caption = '...'
  end
  object mmLog: TMemo
    Left = 0
    Top = 160
    Width = 385
    Height = 291
    Align = alBottom
    TabOrder = 0
  end
  object edtTime: TEdit
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtSend: TEdit
    Left = 8
    Top = 83
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Hola mundo'
  end
  object Button1: TButton
    Left = 135
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Enviar =>'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 129
    Width = 137
    Height = 25
    Caption = 'Cerrar remoto 1'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 151
    Top = 129
    Width = 162
    Height = 25
    Action = ActionCerrar
    TabOrder = 5
  end
  object ttaProfile: TTetheringAppProfile
    Manager = ttManager
    Text = 'Profile VCL'
    Group = 'Neftal'#237
    Actions = <
      item
        Name = 'ActionCerrar'
        IsPublic = True
        Kind = Mirror
        Action = ActionCerrar
        NotifyUpdates = False
      end>
    Resources = <
      item
        Name = 'SharedRes1'
        IsPublic = True
      end>
    Left = 208
    Top = 16
  end
  object ttManager: TTetheringManager
    OnPairedFromLocal = ttManagerPairedFromLocal
    OnPairedToRemote = ttManagerPairedToRemote
    Text = 'Manager VCL'
    Left = 264
    Top = 16
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 320
    Top = 16
  end
  object ActionList1: TActionList
    Left = 328
    Top = 72
    object ActionCerrar: TAction
      Caption = 'ActionCerrar'
      OnExecute = ActionCerrarExecute
    end
  end
end
