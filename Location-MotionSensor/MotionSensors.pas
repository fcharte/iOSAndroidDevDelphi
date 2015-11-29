unit MotionSensors;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.TabControl, System.Sensors,
  System.Sensors.Components, FMX.Objects;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Layout1: TLayout;
    ComboBox1: TComboBox;
    Switch1: TSwitch;
    ListBox1: TListBox;
    MotionSensor1: TMotionSensor;
    OrientationSensor1: TOrientationSensor;
    Layout2: TLayout;
    ComboBox2: TComboBox;
    Switch2: TSwitch;
    Timer1: TTimer;
    ListBox2: TListBox;
    Timer2: TTimer;
    MotionSensor2: TMotionSensor;
    Layout3: TLayout;
    Circle1: TCircle;
    Line1: TLine;
    procedure FormCreate(Sender: TObject);
    procedure MotionSensor1SensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
    procedure OrientationSensor1SensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
    procedure Switch1Switch(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Switch2Switch(Sender: TObject);
    procedure MotionSensor2SensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
    procedure addItem(aListBox: TListBox; aProperty: String; aValue: Double);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses TypInfo, Math;

{$R *.fmx}

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Switch1.IsChecked := False;
  ListBox1.Clear;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  Switch2.IsChecked := False;
  ListBox2.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MotionSensor1.Active := True;
  OrientationSensor1.Active := True;
end;

procedure TForm1.MotionSensor2SensorChoosing(Sender: TObject;
  const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
var
  idx: Integer;
  sensorFound: Boolean;
begin
  sensorFound := False;

  for idx := Low(Sensors) to High(Sensors) do
    if (Sensors[idx] as TCustomMotionSensor).SensorType = TMotionSensorType.Gyrometer3D
    then
    begin
      sensorFound := True;
      break;
    end;

  if Not sensorFound then
    ShowMessage('Gyroscope not available')
  else
    ChoseSensorIndex := idx;
end;

procedure TForm1.MotionSensor1SensorChoosing(Sender: TObject;
  const Sensors: TSensorArray; var ChoseSensorIndex: Integer);

  procedure FillMotionSensorCombo;
  var
    aSensor: TCustomSensor;
  begin
    for aSensor in Sensors do
      ComboBox1.Items.Add(GetEnumName(TypeInfo(TMotionSensorType),
        Integer((aSensor As TCustomMotionSensor).SensorType)));
    ComboBox1.ItemIndex := 0;
    Switch1.IsChecked := True;
  end;

begin
  if ComboBox1.Items.Count = 0 then
    FillMotionSensorCombo;

  ChoseSensorIndex := ComboBox1.ItemIndex;
end;

procedure TForm1.OrientationSensor1SensorChoosing(Sender: TObject;
  const Sensors: TSensorArray; var ChoseSensorIndex: Integer);

  procedure FillOrientationSensorCombo;
  var
    aSensor: TCustomSensor;
  begin
    for aSensor in Sensors do
      ComboBox2.Items.Add(GetEnumName(TypeInfo(TOrientationSensorType),
        Integer((aSensor As TCustomOrientationSensor).SensorType)));
    ComboBox2.ItemIndex := 0;
    Switch2.IsChecked := True;
  end;

begin
  if ComboBox2.Items.Count = 0 then
    FillOrientationSensorCombo;

  ChoseSensorIndex := ComboBox2.ItemIndex;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  MotionSensor1.Active := Switch1.IsChecked;
  Timer1.Enabled := Switch1.IsChecked;
end;

procedure TForm1.Switch2Switch(Sender: TObject);
begin
  OrientationSensor1.Active := Switch2.IsChecked;
  Timer2.Enabled := Switch2.IsChecked;
end;

procedure TForm1.addItem(aListBox: TListBox; aProperty: String; aValue: Double);
var
  aItem: TListBoxItem;
begin
  aItem := TListBoxItem.Create(aListBox);
  aItem.Text := aProperty;
  aItem.ItemData.Detail := Format('%5.4f', [aValue]);
  aItem.StyleLookup := 'listboxitemrightdetail';
  aListBox.AddObject(aItem);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
type
  TReadingArray = array of Double;
var
  sensorReadings: TReadingArray;
  aIndex: TCustomMotionSensor.TProperty;
  aItem: TListBoxItem;
begin
  ListBox1.BeginUpdate;
  ListBox1.Items.Clear;
  if (Assigned(MotionSensor1.Sensor)) And
    (MotionSensor1.Sensor.State = TSensorState.Ready) then
    with MotionSensor1.Sensor do
    begin
      sensorReadings := TReadingArray.Create(AccelerationX, AccelerationY,
        AccelerationZ, AngleAccelX, AngleAccelY, AngleAccelZ, Motion, Speed);
      for aIndex in MotionSensor1.Sensor.AvailableProperties do
      begin
        addItem(ListBox1, GetEnumName(TypeInfo(TCustomMotionSensor.TProperty),
          Integer(aIndex)), sensorReadings[Integer(aIndex)]);
      end;
    end;
  ListBox1.EndUpdate;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
type
  TReadingArray = array of Double;
var
  sensorReadings: TReadingArray;
  aIndex: TCustomOrientationSensor.TProperty;
  aItem: TListBoxItem;
  phi: Double;
begin
  ListBox2.BeginUpdate;
  ListBox2.Items.Clear;
  if (Assigned(OrientationSensor1.Sensor)) And
    (OrientationSensor1.Sensor.State = TSensorState.Ready) then
    with OrientationSensor1.Sensor do
    begin
      sensorReadings := TReadingArray.Create(TiltX, TiltY, TiltZ, DistanceX,
        DistanceY, DistanceZ, HeadingX, HeadingY, HeadingZ, MagHeading,
        TrueHeading, CompMagHeading, CompTrueHeading);
      for aIndex in OrientationSensor1.Sensor.AvailableProperties do
      begin
        addItem(ListBox2,
          GetEnumName(TypeInfo(TCustomOrientationSensor.TProperty),
          Integer(aIndex)), sensorReadings[Integer(aIndex)]);
      end;
    end;
  ListBox2.EndUpdate;
  with OrientationSensor1.Sensor do
    if TCustomOrientationSensor.TProperty.TiltX in AvailableProperties then
    begin
      phi := RadToDeg(ArcTan2(TiltX, TiltY));
      if phi < 0 then
        phi := phi + 360;
      Line1.RotationAngle := phi;
    end;

end;

end.
