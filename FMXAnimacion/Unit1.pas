unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Objects,
  FMX.Layouts, FMX.Filter.Effects, FMX.Effects, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Segundero: TLine;
    FloatAnimation1: TFloatAnimation;
    Esfera: TCircle;
    Minutero: TLine;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    Button1: TButton;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    TrackBar1: TTrackBar;
    Escena: TLayout;
    TrackBar2: TTrackBar;
    Switch1: TSwitch;
    PixelateEffect1: TPixelateEffect;
    FloatAnimation6: TFloatAnimation;
    BevelEffect1: TBevelEffect;
    procedure TrackBar1Change(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;
{$R *.fmx}

procedure TForm1.Switch1Click(Sender: TObject);
begin
  with Switch1 do
    Escena.RotationAngle := IfThen(IsChecked, 180, 0);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Escena.Scale.X := TrackBar1.Value / 100;
  Escena.Scale.Y := TrackBar2.Value / 100;
end;

end.
