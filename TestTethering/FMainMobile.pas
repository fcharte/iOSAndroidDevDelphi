unit FMainMobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Layouts, FMX.Memo, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, FMX.Edit;

type
  TTabbedForm = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    GestureManager1: TGestureManager;
    mmLog: TMemo;
    ttaProfile: TTetheringAppProfile;
    ttManager: TTetheringManager;
    lblID: TLabel;
    Button1: TButton;
    Label1: TLabel;
    edtRes: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ttManagerPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure ttManagerPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure ttManagerUnPairManager(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Button1Click(Sender: TObject);
    procedure ttaProfileResourceUpdated(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    procedure _Log(AMsg:string);
  public
    { Public declarations }
  end;

var
  TabbedForm: TTabbedForm;

implementation

{$R *.fmx}

procedure TTabbedForm.Button1Click(Sender: TObject);
var
  mInfo: TTetheringManagerInfo;
begin
  _Log('--------------------');
  ttManagerPairedToRemote(nil, mInfo);
end;

procedure TTabbedForm.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
end;

procedure TTabbedForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount-1] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

procedure TTabbedForm.FormShow(Sender: TObject);
begin
  lblID.Text := ttManager.Identifier;
  ttManager.AutoConnect();
end;

procedure TTabbedForm.ttaProfileResourceUpdated(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  edtRes.Text := AResource.Value.AsString;
end;

procedure TTabbedForm.ttManagerPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('OnPairedFromLocal; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TTabbedForm.ttManagerPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
var
  rRes:TRemoteResource;
  pInfo:TTetheringProfileInfo;
begin
  _Log('OnPairedToRemote; ' + AManagerInfo.ManagerIdentifier);

  // Nos suscribimos al recurso...
  pInfo := ttManager.RemoteProfiles[0];
  rRes := ttaProfile.GetRemoteResourceValue(pInfo, 'SharedRes1');
  // Nos subscribimos para futuros cambios
  ttaProfile.SubscribeToRemoteItem(pInfo, rRes);

end;

procedure TTabbedForm.ttManagerUnPairManager(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('OnUnPairManager; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TTabbedForm._Log(AMsg: string);
begin
  mmLog.Lines.Add(AMsg);
  mmLog.Text := mmLog.Text + AMsg + sLineBreak;
end;

end.
