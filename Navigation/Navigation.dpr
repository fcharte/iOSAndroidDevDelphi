program Navigation;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas',
  Unit3 in 'Unit3.pas' {DataModule3: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.Run;
end.
