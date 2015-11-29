unit DesktopForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IPPeerClient, IPPeerServer, System.Tether.Manager, FMX.Layouts, FMX.ListBox,
  System.Tether.AppProfile, FMX.Edit, System.Actions, FMX.ActnList;

type
  TForm2 = class(TForm)
    CookService: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    Layout1: TLayout;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    ActionList1: TActionList;
    SendID: TAction;
    procedure Button1Click(Sender: TObject);
    procedure CookServicePairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure SendIDExecute(Sender: TObject);
  private
    { Private declarations }
    clientID: Integer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
uses Math;

procedure TForm2.SendIDExecute(Sender: TObject);
begin
with TetheringAppProfile1 do begin
   Connect(CookService.RemoteProfiles[0]);
   SendString(CookService.RemoteProfiles[0], 'Your client number', IntToStr(clientID));
end;
inc(clientID);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Button1.Enabled := False;
  Timer1.Enabled := True;
  CookService.Text := Edit1.Text;
  CookService.Enabled := True;
  clientID := 1;
end;

procedure TForm2.CookServicePairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  ListBox1.Items.Add('Connection from ' + AManagerInfo.ManagerText);
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
with TetheringAppProfile1 do begin
   Connect(CookService.RemoteProfiles[0]);
   SendString(CookService.RemoteProfiles[0], 'Your client number', IntToStr(clientID));
end;
inc(clientID);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  newDish: String;
begin
  newDish := Edit1.Text + ' ' + IntToStr(RandomRange(1,10));
  with TetheringAppProfile1.Resources do
    FindByName('NewDish').Value := newDish;
  ListBox1.Items.Add(newDish + ' offered');
end;

end.
