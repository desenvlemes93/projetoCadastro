unit uDmDados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, System.json,Winapi.Messages,
  FireDAC.Comp.DataSet,uformatacao, idSMTP, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase,XMLDoc, XMLIntf,  IniFiles;

type
  TDataModule1 = class(TDataModule)
    dsCliente: TDataSource;
     cdsCadastroCliente: TClientDataSet;
    cdsCadastroClienteNome: TStringField;
    cdsCadastroClienteIdentidade: TStringField;
    cdsCadastroClienteemail: TStringField;
    cdsCadastroClienteCEP: TStringField;
    cdsCadastroClienteLogradouro: TStringField;
    cdsCadastroClientenumero: TStringField;
    cdsCadastroClientecomplemento: TStringField;
    cdsCadastroClientebairro: TStringField;
    cdsCadastroClienteCidade: TStringField;
    cdsCadastroClienteEstado: TStringField;
    cdsCadastroClientePais: TStringField;
    cdsCadastroClienteCPF: TStringField;
    cdsCadastroClienteid: TFDAutoIncField;
    cdsCadastroClientetelefone: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
   Logradouro, Complemento, Bairro, Localidade, UF, IBGE, Gia, Unidade : String;
   numero : Double;
    { Private declarations }
    procedure lerJsonCep (pJsonCep : String);
    function numerador (pNumero : Double) : Double;
  public
    function GetLogradouro            : String;
    function GetComplemento           : String;
    function GetBairro                : String;
    function GetLocalidade            : String;
    function GetUF                    : String;
    function GetIBGE                  : String;
    function GetGia                   : String;
    function GetUnidade               : String;
    procedure buscarCep(pCepInformado : String);
    procedure salvarCadastroCliente(pId, pNome, pCPF, pIdentidade, pEmail, pCep,pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado, pPais,pTelefone : String);
    procedure enviarEmail(pEmail,pNome ,pCPF, pIdentidade, pCep, pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado, pPais, pTelefone: String) ;
    procedure salvarCadastroXml(pId, pNome, pCPF, pIdentidade, pEmail, pCep,pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado, pPais,pTelefone : String);
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.buscarCep(pCepInformado: String);
var
  IdHTTP: TIdHTTP;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  Json: String;
  URL : String;
begin
  IdHTTP := TIdHTTP.Create();
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    try
      IdHttp.IOHandler := LHandler;
      URL := 'https://viacep.com.br/ws/' + pCepInformado + '/json/';
      Json := IdHTTP.Get(URL);
      lerJsonCep(Json);
    except

    end;
  finally
    FreeAndNil(LHandler);
    FreeAndNil(IdHTTP);
  end;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
 cdsCadastroCliente.CreateDataSet;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
 cdsCadastroCliente.Destroy;
end;

procedure TDataModule1.enviarEmail(pEmail,pNome,pCPF, pIdentidade, pCep, pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado, pPais, pTelefone : String);
var
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
  AAnexo : String;
begin
  try
    try
      //Cria��o e leitura do arquivo INI com as configura��es
      IniFile                          := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'ConfigEmail.ini');
      sFrom                            := IniFile.ReadString('Email' , 'From'     , sFrom);
      sBccList                         := IniFile.ReadString('Email' , 'BccList'  , sBccList);
      sHost                            := IniFile.ReadString('Email' , 'Host'     , sHost);
      iPort                            := IniFile.ReadInteger('Email', 'Port'     , iPort);
      sUserName                        := IniFile.ReadString('Email' , 'UserName' , sUserName);
      sPassword                        := IniFile.ReadString('Email' , 'Password' , sPassword);

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.sslOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'Cadastro de Cliente';
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := 'Cadastro do cliente ';

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := pEmail;
      idMsg.CCList.EMailAddresses      := 'PARA@DOMINIO.COM.BR';
      idMsg.BccList.EMailAddresses    := sBccList;

      //Vari�vel do texto
      idText := TIdText.Create(idMsg.MessageParts);
     // idText.Body.Add(ACorpo.Text);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      IDtEXT.Body.Add('Nome:'        + pNome + #13 +
                      'Email:'       + pEmail+ #13 +
                      'CPF:'         + pCPF+ #13 +
                      'Telefone:'    + pTelefone + #13 +
                      'RG:'          + pIdentidade + #13 +
                      'Cep:'         + pCep + #13 +
                      'Logradouro:'  + pLogradouro + #13 +
                      'Numero:'      + pNumero  + #13 +
                      'Complemento:' + pComplemento + #13 +
                      'Bairro:'      + pBairro + #13 +
                      'Cidade:'      + pcidade  + #13 +
                      'Estado:'      + pEstado + #13 +
                      '\Pais:'        + pPais );

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseExplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := sUserName;
      IdSMTP.Password                  := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      AAnexo := 'c:\Source\arquivoXml\'+pNome+'.xml';
      if AAnexo <> EmptyStr then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
           raise Exception.Create('Erro ao enviar o email' + e.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;


    finally
      IniFile.Free;

      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
     raise Exception.Create('Erro ao mandar email'+ e.Message);
    end;
  end;

end;
function TDataModule1.GetBairro: String;
begin
  Result := Bairro;
end;

function TDataModule1.GetComplemento: String;
begin
  Result := Complemento;
end;

function TDataModule1.GetGia: String;
begin
  Result := Gia;
end;

function TDataModule1.GetIBGE: String;
begin
  Result := IBGE;
end;

function TDataModule1.GetLocalidade: String;
begin
 Result := Localidade;
end;

function TDataModule1.GetLogradouro: String;
begin
 Result := Logradouro;
end;

function TDataModule1.GetUF: String;
begin
  Result := UF;
end;

function TDataModule1.GetUnidade: String;
begin
 Result := Unidade;
end;

procedure TDataModule1.lerJsonCep(pJsonCep: String);
var
  vCadastroJson : TJSONObject;

begin
  try
    vCadastroJson := TJSONObject.Create;
    vCadastroJson:= TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pJsonCep),0) as TJSONObject;
    Logradouro  := vCadastroJson.GetValue<string>('logradouro','');
    Bairro      := vCadastroJson.GetValue<string>('bairro','');
    Localidade  := vCadastroJson.GetValue<string>('localidade','');
    Complemento := vCadastroJson.GetValue<string>('complemento','');
    Unidade     := vCadastroJson.GetValue<string>('unidade','');
    IBGE        := vCadastroJson.GetValue<string>('ibge','');
    UF          := vCadastroJson.GetValue<string>('uf','');
    Gia         := vCadastroJson.GetValue<string>('gia','');
  finally
    FreeAndNil(vCadastroJson);
  end;

end;


function TDataModule1.numerador(pNumero: Double): Double;
begin
  Result := pNumero + 1;
end;

procedure TDataModule1.salvarCadastroCliente(pId,pNome, pCPF, pIdentidade, pEmail,
  pCep, pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado,
  pPais,pTelefone: String);
begin
  try
    if  not (cdsCadastroCliente.State = dsEdit) then
    begin
      cdsCadastroCliente.Append;
    end;

    cdsCadastroClienteNome.AsString        := pNome;
    cdsCadastroClienteCPF.AsString         := pCPF;
    cdsCadastroClienteTelefone.AsString    :=pTelefone;
    cdsCadastroClienteIdentidade.AsString  := pIdentidade;
    cdsCadastroClienteemail.AsString       := pEmail;
    cdsCadastroClienteCEP.AsString         := pCep;
    cdsCadastroClienteLogradouro.AsString  := pLogradouro;
    cdsCadastroClientenumero.AsString      := pNumero;
    cdsCadastroClientecomplemento.AsString := pComplemento;
    cdsCadastroClientebairro.AsString      := pBairro;
    cdsCadastroClienteCidade.AsString      := pCidade;
    cdsCadastroClienteEstado.AsString      := pEstado;
    cdsCadastroClientePais.AsString        := pPais;
    cdsCadastroCliente.Post;

    cdsCadastroCliente.LogChanges := False;

    cdsCadastroCliente.SaveToFile('C:\Source\arquivoXml\clientes.xml', dfXML);
    cdsCadastroCliente.LogChanges := False;
  except
    on e : Exception do
    begin
      raise    E.Create('Erro ao salvar o cadastro'+ e.message);
    end;
  end;
end;
procedure TDataModule1.salvarCadastroXml(pId, pNome, pCPF, pIdentidade, pEmail,
  pCep, pLogradouro, pNumero, pComplemento, pBairro, pCidade, pEstado,
  pPais,pTelefone: String);
var
  XMLDocument: TXMLDocument;
  NodeTabela, NodeRegistro, NodeEndereco: IXMLNode;
  I: Integer;
begin
  XMLDocument                                 := TXMLDocument.Create(Self);
  try
    XMLDocument.Active                        := True;
    NodeTabela                                := XMLDocument.AddChild('Pessoa');

      NodeRegistro                            := NodeTabela.AddChild('Registro');
      NodeRegistro.ChildValues['Id']          := pId;
      NodeRegistro.ChildValues['Nome']        := pNome;
      NodeRegistro.ChildValues['Identidade']  := pIdentidade;
      NodeRegistro.ChildValues['Cep']         := pCep;
      NodeRegistro.ChildValues['Email']       := pEmail;
      NodeRegistro.ChildValues['Telefone']    := pTelefone;


      NodeEndereco                            := NodeRegistro.AddChild('Endereco');
      NodeEndereco.ChildValues['Logradouro']  :=pLogradouro;
      NodeEndereco.ChildValues['Numero']      := pNumero;
      NodeEndereco.ChildValues['Complemento'] := pComplemento;
      NodeEndereco.ChildValues['Bairro']      := pBairro;
      NodeEndereco.ChildValues['Cidade']      := pCidade;
      NodeEndereco.ChildValues['Estado']      := pEstado;
      NodeEndereco.ChildValues['Pais']        := pPais;


    XMLDocument.SaveToFile('C:\Source\arquivoXml\'+pNome+'.xml');
  finally
    XMLDocument.Free;
  end;

end;

end.
