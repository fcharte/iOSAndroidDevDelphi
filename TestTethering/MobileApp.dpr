program MobileApp;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  FMainMobile in 'FMainMobile.pas' {TabbedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
