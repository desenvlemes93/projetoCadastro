program ProjetoCadastro;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {Form2},
  uDmDados in 'repository\uDmDados.pas' {DataModule1: TDataModule},
  uformatacao in 'util\uformatacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
