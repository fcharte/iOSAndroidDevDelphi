program StylesProject;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Styles in 'Styles.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
