unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.StdActns, FMX.Gestures, FMX.Platform,
  FMX.Layouts, FMX.Memo, FMX.Objects, Unit2;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    ToolBar1: TToolBar;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    ChangeTabAction1: TChangeTabAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Action1: TAction;
    ControlAction1: TControlAction;
    ValueRangeAction1: TValueRangeAction;
    GestureManager1: TGestureManager;
    Memo1: TMemo;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure TabControl1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
  private
    iLastDistance: Integer;
    function OnApplicationEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.IOUtils;

{$R *.fmx}

type
  TMunchiesCategory = (Snacks, Crunchies, Smoothies);

procedure TForm1.Action1Execute(Sender: TObject);
var
  aNumberç: TAlignLayout;
  aString: String;
  pointToAÑ: ^Integer;
begin
  pointToAÑ := @aNumberç;
  pointToAÑ^ := 6;
  aString := #68#101#108#112#104#105;

  TabControl1.TabIndex := Random(TabControl1.TabCount);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  AES: IFMXApplicationEventService;
begin
 { TODO: Restoring application state to be implemented }
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AES)) then
    AES.SetApplicationEventHandler(OnApplicationEvent);

  {$IFDEF ANDROID}
  SpeedButton1.Visible := False;
  {$ENDIF}

 // Image1.Bitmap.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'Logo.jpg'));

  ShowMessage(IntToStr(Unit2.manufactured));

end;

procedure TForm1.FormResize(Sender: TObject);
var
  SC: IFMXScreenService;
begin
  SC := TPlatformServices.Current.GetPlatformService(IFMXScreenService) as IFMXScreenService;
  case SC.GetScreenOrientation of
    TSCreenOrientation.Portrait:
     begin
      Label1.RotationAngle := 0;
      Memo1.RotationAngle := 0;
     end;

    TScreenOrientation.Landscape:
     begin
      Label1.RotationAngle := 90;
      Memo1.RotationAngle := 90;
     end;

  end;
end;

function TForm1.OnApplicationEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
var
  DataFile: String;
begin
  DataFile := TPath.Combine(TPath.GetDocumentsPath, 'DelphiNavApp.dat');
  Memo1.Lines.Add(DataFile);

  case AAppEvent of
    TApplicationEvent.FinishedLaunching:
      Memo1.Lines.Add('Read settings');

    TApplicationEvent.BecameActive:
     begin
       try
        Memo1.Lines.LoadFromFile(DataFile);
       except
         Memo1.Lines.Add('Text file doesn''t exist');
       end;
       Memo1.Lines.Add('Application running');
     end;

    TApplicationEvent.EnteredBackground:
    begin
      Memo1.Lines.Add('Background mode');
      Memo1.Lines.SaveToFile(DataFile);
    end;

    TApplicationEvent.WillBecomeInactive:
      Memo1.Lines.Add('Save state');

    TApplicationEvent.WillBecomeForeground:
      Memo1.Lines.Add('Load state');

    TApplicationEvent.WillTerminate:
      Memo1.Lines.Add('Application ending');

    TApplicationEvent.LowMemory:
      Memo1.Lines.Add('Low memory');
  end;

  Result := True;
end;

procedure TForm1.TabControl1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = igiZoom then
  begin
    if iLastDistance > EventInfo.Distance then
      Label1.Font.Size := Label1.Font.Size - 1
    else
      Label1.Font.Size := Label1.Font.Size + 1;

    iLastDistance := EventInfo.Distance;
    Handled := True;
  end;

  if EventInfo.GestureID = igiPan then
  begin
    Label1.Text := FloatToStr(EventInfo.Location.X) +
      ',' + FloatToStr(EventInfo.Location.Y);
    Handled := True;
  end;
end;

end.
