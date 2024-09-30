unit Sistema.Model.Conexao;

interface

uses
  Sistema.Model.Interfaces, FireDAC.Comp.Client, FireDAC.Phys.MYSQL,
  FireDAC.Stan.Def, FireDAC.VCLUI.Wait, System.Classes, FireDAC.Dapt;

type
  TModelConexao = class(TInterfacedObject, IModelConexao, IModelConexaoParametros)
    private
      FConexao : TFDConnection;
      FDrive :  TFDPhysMYSQLDriverLink;
      FName: UTF8String;
      FDriverName: UTF8String;
      FDataBase: UTF8String;
      FUserName: UTF8String;
      FPassword: UTF8String;
      FServer: UTF8String;
      FPort: UTF8String;
      FDriverId: UTF8String;
      FVendorHome: string;
      constructor Create;
    public
      destructor Destroy; override;
      class function new: IModelConexao;
      function Name(value: UTF8String) : IModelConexaoParametros;
      function DriverName(value: UTF8String) : IModelConexaoParametros;
      function DataBase(value: UTF8String) : IModelConexaoParametros;
      function UserName(value: UTF8String) : IModelConexaoParametros;
      function Password(value: UTF8String) : IModelConexaoParametros;
      function Server(value: UTF8String) : IModelConexaoParametros;
      function Port(value: UTF8String) : IModelConexaoParametros;
      function DriverId(value: UTF8String) : IModelConexaoParametros;
      function VendorHome(value: string) : IModelConexaoParametros;
      function &end: IModelConexao;
      function setParametros: IModelConexaoParametros;
      function Get: TComponent;
  end;

implementation

{ TModelConexao }

function TModelConexao.Get: TComponent;
begin
  FDrive.VendorHome := FVendorHome;

  FConexao.Name := UTF8ToString(FName);
  FConexao.DriverName := FDrive.DriverID;
  FConexao.Params.Values['DataBase'] := UTF8ToString(FDataBase);
  FConexao.Params.Values['User_Name'] := UTF8ToString(FUserName);
  FConexao.Params.Values['Password'] := UTF8ToString(FPassword);
  FConexao.Params.Values['Server'] := UTF8ToString(FServer);
  FConexao.Params.Values['Port'] := UTF8ToString(FPort);
  FConexao.Params.Values['DriverId'] := UTF8ToString(FDriverId);
  FConexao.Transaction := TFDTransaction.Create(nil);

  Result := FConexao;
end;

constructor TModelConexao.create;
begin
  FDrive := TFDPhysMYSQLDriverLink.Create(nil);
  FConexao := TFDConnection.Create(nil);
end;

class function TModelConexao.new: IModelConexao;
begin
  Result := Self.Create;
end;

function TModelConexao.DataBase(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FDataBase := value;
end;

destructor TModelConexao.Destroy;
begin
  FConexao.Transaction.Free;
  FConexao.Free;
  FDrive.Free;
  inherited;
end;

function TModelConexao.DriverId(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FDriverId := value;
end;

function TModelConexao.DriverName(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FDriverName := value;
end;

function TModelConexao.&end: IModelConexao;
begin
  Result := Self;
end;

function TModelConexao.Name(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FName := value;
end;

function TModelConexao.Password(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FPassword := value;
end;

function TModelConexao.Port(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FPort := value;
end;

function TModelConexao.Server(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FServer := value;
end;

function TModelConexao.setParametros: IModelConexaoParametros;
begin
  Result := Self;
end;

function TModelConexao.UserName(value: UTF8String): IModelConexaoParametros;
begin
  Result := Self;
  FUserName := value;
end;

function TModelConexao.VendorHome(value: string): IModelConexaoParametros;
begin
  Result := Self;
  FVendorHome := value;
end;

end.
