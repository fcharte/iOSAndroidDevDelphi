unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Notification, FMX.StdCtrls, FMX.Edit, FMX.Advertising;

type
  TForm1 = class(TForm)
    NotificationCenter1: TNotificationCenter;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    BannerAd1: TBannerAd;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  aNotification: TNotification;
begin
  aNotification := TNotification.Create;
  aNotification.Name := 'aNotification';
  aNotification.AlertBody := Edit1.Text;
  aNotification.Number := 6;
  NotificationCenter1.PresentNotification(aNotification);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  aNotification: TNotification;
begin
  NotificationCenter1.CancelAll;
  aNotification := TNotification.Create;
  with aNotification do begin
    Name := 'DelphiXE6Remainder';
    AlertBody := 'Remember to learn Delphi XE6';
    FireDate := Now + EncodeTime(0, 1, 0, 0);
  end;
  NotificationCenter1.ScheduleNotification(aNotification);

  if BannerAd1.AdUnitID = '' then
  begin
    BannerAd1.AdUnitID := 'ca-app-pub-3950907423992359/5137970220';
    BannerAd1.LoadAd;
  end;
end;

end.
