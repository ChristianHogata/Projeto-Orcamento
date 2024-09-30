unit Sistema.Model.Entidades.Clientes;

interface

uses
  Sistema.Model.Interfaces, Data.DB, System.Classes, Datasnap.DBClient, System.Generics.Collections;

type
  TDadosCliente = class(TInterfacedObject, IDadosClientes)
  public
    Nome: string;
    class function new: IDadosClientes;
  end;

  TModelEntidadeClientes = class(TInterfacedObject, IModelEntidade<IDadosClientes>)
  private
    FDataSet: IModelDataSet;
    FClientDataSet: TClientDataSet;
    FDadosCliente: IDadosClientes;
    procedure CriarClientDataSet;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelEntidade<IDadosClientes>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosClientes;
  end;

implementation

uses
  System.SysUtils, Sistema.Model.DataSetFactory;

Const
  FQUERY = 'SELECT * FROM clientes';

{ TModelEntidadeClientes }

procedure TModelEntidadeClientes.Cancelar;
begin
  FClientDataSet.Cancel;
end;

constructor TModelEntidadeClientes.create;
begin
  FDataSet := TModelDataSetFactory.new.dataSet;
  FClientDataSet := TClientDataSet.Create(nil);
  FDadosCliente := TDadosCliente.new;

  CriarClientDataSet();
end;

procedure TModelEntidadeClientes.CriarClientDataSet;
begin
  FClientDataSet.FieldDefs.Add('codigo', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('nome', ftstring, 100);

  FClientDataSet.SetProvider(FDataSet.open(FQUERY));
  FClientDataSet.Open;

  FClientDataSet.FieldByName('codigo').DisplayWidth := 10;
  FClientDataSet.FieldByName('nome').DisplayWidth := 100;

  FClientDataSet.AddIndex('IdxCodigoNome', 'codigo;nome;', [ixUnique]);
  FClientDataSet.IndexName := 'IdxCodigoNome';
end;

function TModelEntidadeClientes.Dados: IDadosClientes;
begin
  Result := FDadosCliente;
end;

procedure TModelEntidadeClientes.Deletar;
begin
  FClientDataSet.Delete;
  FClientDataSet.ApplyUpdates(0);
end;

destructor TModelEntidadeClientes.destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

procedure TModelEntidadeClientes.Editar;
begin
  FClientDataSet.Edit;
  FClientDataSet.ApplyUpdates(0);
end;

procedure TModelEntidadeClientes.Inserir;
begin
  FClientDataSet.Append;
end;

function TModelEntidadeClientes.Listar: TComponent;
begin
  Result := FClientDataSet;
end;

class function TModelEntidadeClientes.new: IModelEntidade<IDadosClientes>;
begin
  Result := Self.create;
end;

procedure TModelEntidadeClientes.Finalizar;
begin
   FClientDataSet.post;
   FClientDataSet.ApplyUpdates(0);
   FClientDataSet.Refresh;
end;

{ TDadosCliente }

class function TDadosCliente.new: IDadosClientes;
begin
  Result := Self.Create;
end;

end.
