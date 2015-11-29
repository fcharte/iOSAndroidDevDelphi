unit MobileForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  IPPeerClient, IPPeerServer, System.Tether.Manager, System.Tether.AppProfile,
  FMX.ListBox, FMX.StdCtrls, FMX.Layouts, FMX.Edit, System.Actions, FMX.ActnList;

type
  TForm1 = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    Label1: TLabel;
    Layout1: TLayout;
    ListBox1: TListBox;
    Layout2: TLayout;
    Edit1: TEdit;
    Label2: TLabel;
    Layout3: TLayout;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Button2: TButton;
    ActionList1: TActionList;
    SendID: TAction;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const RemoteManagers: TTetheringManagerInfoList);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TetheringManager1PairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Edit1Change(Sender: TObject);
    procedure TetheringAppProfile1AcceptResource(const Sender: TObject;
      const AProfileId: string; const AResource: TCustomRemoteItem;
      var AcceptResource: Boolean);
    procedure TetheringAppProfile1ActionUpdated(const Sender: TObject;
      const AResource: TRemoteAction);
    procedure TetheringAppProfile1RemoteProfileUpdate(const Sender: TObject;
      const AProfileId: string);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure TetheringAppProfile1ResourceUpdated(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.Generics.Collections;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ComboBox1.Clear;
  TetheringManager1.DiscoverManagers;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 with TetheringManager1, TetheringAppProfile1 do
  if RemoteProfiles.Count > 0 then begin
    Connect(RemoteProfiles[0]);
    SubscribeToRemoteItem(RemoteProfiles[0],'NewDish');
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  action: TRemoteAction;
begin
  with TetheringManager1 do
  if RemoteProfiles.Count > 0 then begin
    TetheringAppProfile1.Connect(RemoteProfiles[0]);

    for action in TetheringAppProfile1.GetRemoteProfileActions(RemoteProfiles[0]) do
      if action.Name = 'SendID' then
        TetheringAppProfile1.RunRemoteAction(action);
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  TetheringManager1.PairManager(
    TetheringManager1.RemoteManagers[Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex])]);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  TetheringManager1.Text := Edit1.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label1.Text := TetheringManager1.Identifier;
  TetheringManager1.DiscoverManagers;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  SendID.Execute;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
  newDish: TRemoteResource;
//  resources: TList<TRemoteResource>;
//  profiles: TList<TTetheringProfileInfo>;
begin
 with TetheringManager1 do
  if RemoteProfiles.Count > 0 then begin
    TetheringAppProfile1.Connect(RemoteProfiles[0]);
  //  profiles := TetheringAppProfile1.ConnectedProfiles;
  //  resources:=TetheringAppProfile1.GetRemoteProfileResources(RemoteProfiles[0]);
    newDish := TetheringAppProfile1.GetRemoteResourceValue(RemoteProfiles[0], 'NewDish');
    if Assigned(newDish) then
      ListBox1.Items.Add(newDish.Value.AsString + ' is available');
  end;
end;

procedure TForm1.TetheringAppProfile1AcceptResource(const Sender: TObject;
  const AProfileId: string; const AResource: TCustomRemoteItem;
  var AcceptResource: Boolean);
begin
  ListBox1.Items.Add('OnAcceptResource');
end;

procedure TForm1.TetheringAppProfile1ActionUpdated(const Sender: TObject;
  const AResource: TRemoteAction);
begin
  ListBox1.Items.Add('OnActionUpdated');
end;

procedure TForm1.TetheringAppProfile1RemoteProfileUpdate(const Sender: TObject;
  const AProfileId: string);
begin
    ListBox1.Items.Add('OnRemoteProfileUpdate');
end;

procedure TForm1.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
    ListBox1.Items.Add('OnResourceReceived');
end;

procedure TForm1.TetheringAppProfile1ResourceUpdated(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  ListBox1.Items.Add(AResource.Value.AsString + ' is available');
end;

procedure TForm1.TetheringManager1EndManagersDiscovery(const Sender: TObject;
  const RemoteManagers: TTetheringManagerInfoList);
var
  idx: Integer;
begin
  for idx := 0 to RemoteManagers.count-1 do
    if RemoteManagers[idx].ManagerName = 'CookService' then
      ComboBox1.Items.AddObject(RemoteManagers[idx].ManagerText, TObject(idx));
end;

procedure TForm1.TetheringManager1PairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  ListBox1.Items.Add('Connected to ' + AManagerInfo.ManagerText);

end;

end.
