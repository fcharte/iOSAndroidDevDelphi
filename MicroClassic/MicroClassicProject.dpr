program MicroClassicProject;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MicroClassic in 'MicroClassic.pas' {Form1},
  Collectible in 'Collectible.pas',
  Computer in 'Computer.pas',
  Collection in 'Collection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
