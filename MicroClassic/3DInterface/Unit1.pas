unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Types3D,
  FMX.MaterialSources, FMX.StdCtrls, FMX.Layers3D;

type
  TForm1 = class(TForm3D)
    ColorMaterialSource1: TColorMaterialSource;
    TextureMaterialSource1: TTextureMaterialSource;
    Sphere1: TSphere;
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    Light2: TLight;
    LightMaterialSource2: TLightMaterialSource;
    Sphere2: TSphere;
    Light3: TLight;
    Camera1: TCamera;
    Camera2: TCamera;
    Timer1: TTimer;
    Layer3D1: TLayer3D;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    procedure Form3DCreate(Sender: TObject);
    procedure Sphere2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    offsetAngulo: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses FMX.Materials;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Light1.Enabled := CheckBox1.IsChecked;
  Light2.Enabled := CheckBox2.IsChecked;
  Light3.Enabled := CheckBox3.IsChecked;
end;

procedure TForm1.Form3DCreate(Sender: TObject);
begin
//  0.0 -1.5 0.0  0.5 0.0 -0.5  0.5 0.0 0.5  0.0 1.5 0.0  -0.5 0.0 -0.5  -0.5 0.0 0.5
//with mesh1.Data do begin
//   Points := '0.0 -1.5 0.0  0.5 0.0 -0.5  0.5 0.0 0.5  0.0 1.5 0.0  -0.5 0.0 -0.5  -0.5 0.0 0.5';
//   TriangleIndices := '2 0 1   0 4 1   0 5 4   0 2 5   2 1 3   1 4 3   4 5 3   2 3 5'
//end;
    offsetAngulo := 1;
end;

procedure TForm1.Sphere2Click(Sender: TObject);
begin
 if Camera = Camera1 then
     Camera := Camera2
  else Camera := Camera1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with Camera1.Position do
    Z := Z - 0.1;

  with Camera1.RotationAngle do begin
    Y := Y + offsetAngulo;
    if Abs(Y) = 30 then offsetAngulo := offsetAngulo * -1;
  end;
end;

end.
