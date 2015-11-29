unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.Media, FMX.StdCtrls,
  FMX.Objects, FMX.TabControl, FMX.Layouts, FMX.Effects, FMX.Filter.Effects;

type
  TForm1 = class(TForm)
    CameraComponent1: TCameraComponent;
    GridPanelLayout1: TGridPanelLayout;
    Image1: TImage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    FlowLayout1: TFlowLayout;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Image2: TImage;
    FlowLayout2: TFlowLayout;
    Label1: TLabel;
    Switch1: TSwitch;
    Label2: TLabel;
    Switch2: TSwitch;
    TabItem3: TTabItem;
    PaperSketchEffect1: TPaperSketchEffect;
    PaperSketchEffect2: TPaperSketchEffect;
    GridPanelLayout2: TGridPanelLayout;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: Int64);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private declarations }
    video: TVideoCaptureDevice;
    procedure ShowImage;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math, System.IOUtils;

{$R *.fmx}

procedure TForm1.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: Int64);
begin
  TThread.Synchronize(TThread.CurrentThread, ShowImage);
end;

procedure TForm1.ShowImage;
begin
  if CameraComponent1.Kind = TCameraKind.BackCamera then
    CameraComponent1.SampleBufferToBitmap(Image1.Bitmap, True)
  else
    CameraComponent1.SampleBufferToBitmap(Image2.Bitmap, True);
end;


procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  with PaperSketchEffect1 do begin
    brushSize := TrackBar1.Value;
    Enabled := Boolean(IfThen(TrackBar1.Value < 0.6, Integer(false), Integer(true)));
  end;
  with PaperSketchEffect2 do begin
    brushSize := TrackBar2.Value;
    Enabled := Boolean(IfThen(TrackBar2.Value < 0.6, Integer(false), Integer(true)));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if TCaptureDeviceManager.Current.DefaultVideoCaptureDevice = nil then
  begin
    ShowMessage('Camera not available');
    Application.Terminate;
  end
  else with CameraComponent1 do begin
    Kind := TCameraKind.BackCamera;
    FocusMode := TFocusMode.AutoFocus;
    if HasFlash then FlashMode := TFlashMode.FlashOff;
    if HasTorch then TorchMode := TTorchMode.ModeOff;
    Active := True;
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  with CameraComponent1 do begin
    Active := False;
    Kind := TCameraKind.BackCamera;
    Active := True;
  end;

end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  with CameraComponent1 do begin
    Active := False;
    Kind := TCameraKind.FrontCamera;
    Active := True;
  end;

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  with CameraComponent1 do begin
    Active := False;

    if RadioButton1.IsChecked then
      FocusMode := TFocusMode.Locked
    else if RadioButton2.IsChecked then
      FocusMode := TFocusMode.AutoFocus
    else
      FocusMode := TFocusMode.ContinuousAutoFocus;

    if HasFlash then
      if Switch1.IsChecked then
        FlashMode := TFlashMode.FlashOn
      else FlashMode := TFlashMode.FlashOff;

    if HasTorch then
      if Switch2.IsChecked then
        TorchMode := TTorchMode.ModeOn
      else TorchMode := TTorchMode.ModeOff;

    Active := True;
  end;

end;

end.
