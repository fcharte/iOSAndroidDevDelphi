unit Location;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  System.Sensors.Components, FMX.TabControl, FMX.StdCtrls, FMX.Layouts,
  FMX.ListBox, FMX.WebBrowser, FMX.Memo;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    Layout1: TLayout;
    Switch1: TSwitch;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    LocationSensor1: TLocationSensor;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    AniIndicator1: TAniIndicator;
    WebBrowser1: TWebBrowser;
    Memo1: TMemo;
    TabItem3: TTabItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    procedure Switch1Switch(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    NewLocation: TLocationCoord2D;
    Geocoder1: TGeocoder;
    procedure GeocodeReverseDone(const Address: TCivicAddress);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses TypInfo;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  NewLocation := TLocationCoord2D.Create(38.158176,-2.738167);
end;

procedure TForm1.GeocodeReverseDone(const Address: TCivicAddress);
type
  StringArray = array of String;
var
  titles, values: StringArray;
  newData: String;
  idx: Integer;
begin
  with Address do
    Memo1.Text :=
      'AdminArea: '       + AdminArea       + #13#10 +
      'CountryCode: '     + CountryCode     + #13#10 +
      'CountryName: '     + CountryName     + #13#10 +
      'FeatureName: '     + FeatureName     + #13#10 +
      'Locality: '        + Locality        + #13#10 +
      'PostalCode: '      + PostalCode      + #13#10 +
      'SubAdminArea: '    + SubAdminArea    + #13#10 +
      'SubLocality: '     + SubLocality     + #13#10 +
      'SubThoroughfare: ' + SubThoroughfare + #13#10 +
      'Thoroughfare: '    + Thoroughfare;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
 aURL: String;

begin
  Self.NewLocation := NewLocation;

  ListBoxItem1.ItemData.Detail := Format('%5.4f', [NewLocation.Latitude]);
  ListBoxItem2.ItemData.Detail := Format('%5.4f', [NewLocation.Longitude]);

  if Assigned(LocationSensor1.Sensor) then
   with LocationSensor1.Sensor do
    begin
      ListBoxItem3.ItemData.Detail := Format('%5.4f', [Altitude]);
      ListBoxItem4.ItemData.Detail := Format('%5.4f', [TrueHeading]);
      ListBoxItem5.ItemData.Detail := Format('%5.4f', [Speed]);
    end;

  aURL := 'http://bing.com/maps/default.aspx?cp=' +
    ListBoxItem1.ItemData.Detail + '~' +
    ListBoxItem2.ItemData.Detail + '&lvl=15';
  WebBrowser1.Navigate(aURL);

  AniIndicator1.Visible := False;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  LocationSensor1.Active := Switch1.IsChecked;
  AniIndicator1.Enabled := Switch1.IsChecked;
end;

procedure TForm1.TabControl1Change(Sender: TObject);
  function GeocoderAvailable: Boolean;
  begin
    if not Assigned(Geocoder1) then
    begin
      if Assigned(TGeocoder.Current) then
        Geocoder1 := TGeocoder.Current.Create;

      if Assigned(Geocoder1) then
        Geocoder1.OnGeocodeReverse := GeocodeReverseDone;
    end;
    Result := Assigned(Geocoder1);
  end;

begin
  if TabControl1.ActiveTab = TabItem3 then
    if GeocoderAvailable  and not Geocoder1.Geocoding then
      Geocoder1.GeocodeReverse(NewLocation);
end;


end.
