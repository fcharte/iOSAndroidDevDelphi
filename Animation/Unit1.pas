unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Effects, FMX.Filter.Effects;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Switch1: TSwitch;
    Circle1: TCircle;
    Line1: TLine;
    Line2: TLine;
    Button1: TButton;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    StyleBook1: TStyleBook;
    PixelateEffect1: TPixelateEffect;
    FloatAnimation5: TFloatAnimation;
    procedure TrackBar1Change(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Math;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
with Switch1 do
    Layout1.RotationAngle := IfThen(IsChecked, 180, 0);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Layout1.Scale.X := TrackBar1.Value / 100;
  Layout1.Scale.Y := TrackBar2.Value / 100;
end;

end.
