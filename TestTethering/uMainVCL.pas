unit uMainVCL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  Vcl.StdCtrls, System.Tether.Manager, System.Tether.AppProfile, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList;

type
  TForm1 = class(TForm)
    ttaProfile: TTetheringAppProfile;
    ttManager: TTetheringManager;
    lblID: TLabel;
    mmLog: TMemo;
    edtTime: TEdit;
    Timer1: TTimer;
    edtSend: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ActionList1: TActionList;
    ActionCerrar: TAction;
    procedure FormShow(Sender: TObject);
    procedure ttManagerPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure ttManagerPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ActionCerrarExecute(Sender: TObject);
  private
    procedure _log(AMsg:string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.ActionCerrarExecute(Sender: TObject);
begin
  ShowMessage('Cerrar remoto...');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // enviar cadena
  ttaProfile.SendString(ttManager.RemoteProfiles[0], 'Enviando...', edtSend.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ra:TRemoteAction;
begin
  ra := ttaProfile.GetRemoteProfileActions(ttManager.RemoteProfiles[0]).Items[0];
  if Assigned(ra) then begin
    ra.Execute;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  lblID.Caption := ttManager.Identifier;
  Self.Caption := ttManager.Identifier;
  // Autoconectar
  ttManager.AutoConnect();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  edtTime.Text := FormatDateTime('hh:nn:ss', Now);
  ttaProfile.Resources.FindByName('SharedRes1').Value := edtTime.Text;
end;

procedure TForm1.ttManagerPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('PairedFromLocal; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm1.ttManagerPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  _Log('PairedToRemote; ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm1._log(AMsg: string);
begin
  mmLog.Lines.Add(Amsg);
end;

end.
