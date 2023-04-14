unit uformatacao;

interface
     uses System.MaskUtils,System.SysUtils;
     Function formacpf(numtexto:String):String;
     Function formacnpj(numtexto:String):String;
     procedure excluirRegistro;
     function retirarPontuacao(pNumero : String) : String;

implementation

  Function formacpf(numtexto:String):String;
begin
  Delete(numtexto,ansipos('.',numtexto),1);
  Delete(numtexto,ansipos('.',numtexto),1);
  Delete(numtexto,ansipos('-',numtexto),1);
  Delete(numtexto,ansipos('/',numtexto),1);
  Result:=FormatmaskText('000\.000\.000\-00;0;',numtexto);
end;

  Function formacnpj(numtexto:String):String;
begin
  Delete(numtexto,ansipos('.',numtexto),1);
  Delete(numtexto,ansipos('.',numtexto),1);
  Delete(numtexto,ansipos('-',numtexto),1);
  Delete(numtexto,ansipos('/',numtexto),1);
  Result:=FormatmaskText('00\.000\.000\/0000\-00;0;',numtexto);
end;
procedure excluirRegistro;
var s:string;
arq: TextFile;
begin
  s:= 'C:\Source\arquivoXml\clientes.xml';
  AssignFile ( arq, s );
  Rewrite ( arq );
  CloseFile ( arq );
  DeleteFile(s);
end;

function retirarPontuacao(pNumero : String) : String;
var
  str, str2, str3,str4,str5: String;
begin
  str:= StringReplace(pNumero,'.','', [rfReplaceAll]);
  str2:= StringReplace(str,'-','', [rfReplaceAll]);
  str3:= StringReplace(str2,'/','', [rfReplaceAll]);
  str4:= StringReplace(str3,')','', [rfReplaceAll]);
  str5:= StringReplace(str4,'(','', [rfReplaceAll]);
  Result := str5;
end;
end.
