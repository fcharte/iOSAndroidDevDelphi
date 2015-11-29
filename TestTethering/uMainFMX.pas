unit uMainFMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IPPeerClient, IPPeerServer, FMX.Layouts, FMX.Memo, System.Tether.Manager,
  System.Tether.AppProfile, FMX.Edit, System.Actions, FMX.ActnList;

type
  TForm2 = class(TForm)
    ttaProfile: TTetheringAppProfile;
    ttManager: TTetheringManager;
    lblID: TLabel;
    mmLog: TMemo;
    edtSended: TEdit;
    edtTime: TEdit;
    Button1: TButton;
    ActionList1: TActionList;
    ActionCerrar: TAction;
    procedure FormShow(Sender: TObject);
    procedure ttManagerPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure ttManagerPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure ttaProfileAcceptResource(const Sender: TObject;
      const AProfileId: string; const AResource: TCustomRemoteItem;
      var AcceptResource: Boolean);
    procedure ttaProfileResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure Button1Click(Sender: TObject);
    procedure ttaProfileResourceUpdated(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure ActionCerrarExecute(Sender: TObject);
  private
    procedure _log(AMsg:string);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.ActionCerrarExecute(Sender: TObject);
begin
  ShowMessage('Cerrando...');
  Self.Close;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  pInfo:TTetheringProfileInfo;
  rRes:TRemoteResource;
begin
  pInfo := ttManager.RemoteProfiles[0];
  rRes := ttaProfile.GetRemoteResourceValue(pInfo, 'SharedRes1');
  ttaProfile.SubscribeToRemoteItem(pInfo, rRes);

end;

procedure TForm2.FormShow(Sender: TObject);
begin
  lblID.Text := ttManager.Identifier;
  Self.Caption := ttManager.Identifier;
  // autoconectar
  ttManager.AutoConnect();
end;

procedure TForm2.ttaProfileAcceptResource(const Sender: TObject;
  const AProfileId: string; const AResource: TCustomRemoteItem;
  var AcceptResource: Boolean);
begin
  AcceptResource := true;
end;

procedure TForm2.ttaProfileResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  edtSended.Text := AResource.Value.AsString;
end;

procedure TForm2.ttaProfileResourceUpdated(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  edtTime.Text := AResource.Value.AsString;
end;

procedure TForm2.ttManagerPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('PairedFromLocal; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm2.ttManagerPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('PairedToRemote; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm2._log(AMsg: string);
begin
  mmLog.Lines.Add(AMsg);
end;

end.
