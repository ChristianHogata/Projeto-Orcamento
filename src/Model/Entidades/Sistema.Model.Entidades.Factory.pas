unit Sistema.Model.Entidades.Factory;

interface

uses
  Sistema.Model.Interfaces;

type
  TModelEntityFactory = class(TInterfacedObject, IModelEntidadeFactory)
  private

  public
    class function new: IModelEntidadeFactory;
    function GetModelEntidadesClientes: IModelEntidade<IDadosClientes>;
    function GetModelEntidadesProdutos: IModelEntidade<IDadosProdutos>;
    function GetModelEntidadesPedidos: IModelEntidade<IDadosPedidos>;
    function GetModelEntidadesEnderecos: IModelEntidade<IDadosEndereco>;
    function GetModelEntidadesPedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

implementation

uses
  Sistema.Model.Entidades.Clientes, Sistema.Model.Entidades.PedidosItens,
  Sistema.Model.DataSetFactory, Sistema.Model.Entidades.Produtos,
  Sistema.Model.Entidades.Pedidos, Sistema.Model.Entidades.Enderecos;

{ TModelEntityFactory }

function TModelEntityFactory.GetModelEntidadesClientes: IModelEntidade<IDadosClientes>;
begin
  Result := TModelEntidadeClientes.new;
end;

function TModelEntityFactory.GetModelEntidadesEnderecos: IModelEntidade<IDadosEndereco>;
begin
  Result := TModelEntidadeEnderecos.new;
end;

function TModelEntityFactory.GetModelEntidadesPedidos: IModelEntidade<IDadosPedidos>;
begin
  Result := TModelEntidadePedidos.new;
end;

function TModelEntityFactory.GetModelEntidadesPedidosItens: IModelEntidade<IDadosPedidosItens>;
begin
  Result := TModelEntidadePedidosItens.new;
end;

function TModelEntityFactory.GetModelEntidadesProdutos: IModelEntidade<IDadosProdutos>;
begin
  Result := TModelEntidadeProdutos.new;
end;

class function TModelEntityFactory.new: IModelEntidadeFactory;
begin
  Result := Self.Create;
end;

end.
