unit Sistema.Model.ConexaoFactory;

interface

uses
  Sistema.Model.Interfaces;

type
  TModelConexaoFactory = class(TInterfacedObject, IModelConexaoFactory)
    private
      function getConexao: IModelConexao;
    public
      class function new: IModelConexaoFactory;
  end;

implementation

uses
  Sistema.Model.Conexao, IniFiles, System.SysUtils;

{ TModelConexaoFactory }

function TModelConexaoFactory.getConexao: IModelConexao;
var
  IniFile: TIniFile;
  lLibraryPath: string;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  try
    lLibraryPath := IniFile.ReadString('Database', 'LibraryPath', '');


    Result :=
      TModelConexao
       .new
        .setParametros
          .Name('ConexaoMySQL')
          .DataBase(UTF8String(IniFile.ReadString('Database', 'Database', '')))
          .UserName(UTF8String(IniFile.ReadString('Database', 'Username', '')))
          .Password(UTF8String(IniFile.ReadString('Database', 'Password', '')))
          .Server(UTF8String(IniFile.ReadString('Database', 'Server', '')))
          .Port(UTF8String(IniFile.ReadString('Database', 'Port', '')))
          .DriverId('MYSQL')
          .VendorHome(UTF8ToString(lLibraryPath))
        .&End;
  finally
    IniFile.Free;
  end;
end;

class function TModelConexaoFactory.new: IModelConexaoFactory;
begin
  Result := Self.Create;
end;

end.
