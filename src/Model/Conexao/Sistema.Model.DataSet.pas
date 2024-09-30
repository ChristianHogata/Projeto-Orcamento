unit Sistema.Model.DataSet;

interface

uses
  Sistema.Model.Interfaces, System.Classes, FireDAC.Comp.Client;

type
  TModelDataSet = class(TInterfacedObject, IModelDataSet)
  private
    FDataSet: TFDQuery;
    FModelConexao: IModelConexao;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelDataSet;
    function open(aTable: String): TComponent;
    function get: TComponent;
    procedure ExecutarQuery(pQuery: string);
  end;

implementation

uses
  System.SysUtils, Sistema.Model.ConexaoFactory;

{ TModelDataSet }

constructor TModelDataSet.create;
begin
  FDataSet := TFDQuery.Create(nil);
  FModelConexao := TModelConexaoFactory.new.getConexao;
  FDataSet.Connection := TFDConnection(FModelConexao.Get);
end;

destructor TModelDataSet.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TModelDataSet.ExecutarQuery(pQuery: string);
begin
  var lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := TFDConnection(FModelConexao.Get);
    lQuery.SQL.Text := pQuery;
    lQuery.ExecSQL;
  finally
    lQuery.Free;
  end;
end;

function TModelDataSet.get: TComponent;
begin
  if Assigned(FDataSet) then
    Result := FDataSet
  else
    raise Exception.Create('DataSet não foi criado.');
end;

class function TModelDataSet.new: IModelDataSet;
begin
  Result := Self.Create;
end;

function TModelDataSet.open(aTable: String): TComponent;
begin
  FDataSet.Open(aTable);

  Result := FDataSet;
end;
end.
